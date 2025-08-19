import 'package:flutter/material.dart';
import 'dart:math';

import 'package:naked/core/theme/app_colors.dart';
import 'package:naked/features/truth_or_dare/pages/widgets/naked_button.dart';
import 'package:naked/features/truth_or_dare/models/player.dart';
import 'package:naked/features/truth_or_dare/models/category.dart';

class TruthOrDareScreen extends StatefulWidget {
  final List<Player> players;
  final bool isRandomOrder;
  final CategoryLevel? category;

  const TruthOrDareScreen({
    super.key,
    required this.players,
    required this.isRandomOrder,
    this.category,
  });

  @override
  State<TruthOrDareScreen> createState() => _TruthOrDareScreenState();
}

class _TruthOrDareScreenState extends State<TruthOrDareScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _loadingController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  String currentText = "";
  String currentType = "";
  bool isRevealed = false;
  bool isLoading = false;

  late List<Player> playersQueue;
  late Player currentPlayer;
  int currentPlayerIndex = 0;

  final List<String> truthQuestions = [
    "Qual foi sua fantasia mais ousada comigo?",
    "O que mais te excita em mim?",
    "Qual parte do meu corpo você mais adora?",
    "Qual foi o momento mais intenso que vivemos juntos?",
    "O que você gostaria de experimentar comigo?",
    "Qual foi seu sonho erótico mais memorável comigo?",
    "O que te deixa mais excitado(a) quando estamos juntos?",
    "Qual posição você mais gosta?",
    "O que você sente quando me toca?",
    "Qual foi nossa noite mais apaixonada?",
    "O que você mudaria em nossa intimidade?",
    "Qual é seu fetiche secreto?",
    "Onde você gostaria de fazer amor comigo?",
    "O que mais te surpreende na nossa química?",
    "Qual é sua memória mais sensual de nós?",
  ];

  final List<String> dareQuestions = [
    "Sussurre algo sensual no meu ouvido",
    "Me beije por 30 segundos sem parar",
    "Faça uma massagem sensual nas minhas costas",
    "Me conte uma fantasia sua enquanto me toca",
    "Dance de forma sedutora para mim",
    "Me dê um beijo no pescoço por 1 minuto",
    "Remova uma peça de roupa de forma provocante",
    "Me faça um carinho íntimo por 2 minutos",
    "Sussurre o que quer fazer comigo agora",
    "Me toque de forma que me faça derreter",
    "Crie um clima romântico no ambiente",
    "Me seduza usando apenas o olhar por 1 minuto",
    "Faça algo que sempre quis fazer comigo",
    "Me provoque sem me tocar por 3 minutos",
    "Me mostre como quer ser tocado(a)",
  ];

  @override
  void initState() {
    super.initState();

    // Configurar animações
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(parent: _loadingController, curve: Curves.linear),
    );

    // Configurar jogadores
    _setupPlayers();
  }

  void _setupPlayers() {
    playersQueue = List.from(widget.players);
    if (widget.isRandomOrder) {
      playersQueue.shuffle();
    }
    currentPlayer = playersQueue[currentPlayerIndex];
    currentText = "Olá, ${currentPlayer.name}!\nEscolha Verdade ou Desafio";
  }

  void _nextPlayer() async {
    setState(() {
      isLoading = true;
    });

    _loadingController.repeat();

    // Simular loading
    await Future.delayed(const Duration(milliseconds: 2000));

    _loadingController.stop();
    _loadingController.reset();

    setState(() {
      isLoading = false;
      isRevealed = false;
      currentType = "";

      if (widget.isRandomOrder) {
        // Seleção aleatória
        currentPlayer = playersQueue[Random().nextInt(playersQueue.length)];
      } else {
        // Seleção em ordem
        currentPlayerIndex = (currentPlayerIndex + 1) % playersQueue.length;
        currentPlayer = playersQueue[currentPlayerIndex];
      }

      currentText = "Olá, ${currentPlayer.name}!\nEscolha Verdade ou Desafio";
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  void _selectTruth() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    setState(() {
      isRevealed = true;
      currentType = "VERDADE";
      currentText = truthQuestions[Random().nextInt(truthQuestions.length)];
    });
  }

  void _selectDare() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    setState(() {
      isRevealed = true;
      currentType = "DESAFIO";
      currentText = dareQuestions[Random().nextInt(dareQuestions.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.whiteWithAlpha(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.textPrimary,
                          size: 20,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Verdade ou Desafio',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 40),
                  ],
                ),
              ),

              // Conteúdo principal
              Expanded(
                child: isLoading ? _buildLoadingScreen() : _buildGameScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value * 3.14159,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.refresh,
                    color: AppColors.textPrimary,
                    size: 40,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Selecionando próximo jogador...',
            style: TextStyle(
              color: AppColors.whiteWithAlpha(0.8),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameScreen() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Nome do jogador atual
          if (!isRevealed) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    currentPlayer.gender == Gender.female
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : AppColors.blue.withValues(alpha: 0.2),
                    AppColors.whiteWithAlpha(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: currentPlayer.gender == Gender.female
                      ? AppColors.primary.withValues(alpha: 0.5)
                      : AppColors.blue.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        currentPlayer.gender == Gender.female
                            ? Icons.female
                            : Icons.male,
                        color: currentPlayer.gender == Gender.female
                            ? AppColors.primary
                            : AppColors.blue,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        currentPlayer.name,
                        style: TextStyle(
                          color: currentPlayer.gender == Gender.female
                              ? AppColors.primary
                              : AppColors.blue,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'É sua vez!',
                    style: TextStyle(
                      color: AppColors.whiteWithAlpha(0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],

          const Spacer(),

          // Card principal
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isRevealed
                          ? (currentType == "VERDADE"
                                ? [AppColors.primary, AppColors.secondary]
                                : [AppColors.purple, AppColors.blue])
                          : [
                              AppColors.whiteWithAlpha(0.1),
                              AppColors.whiteWithAlpha(0.05),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: isRevealed
                            ? (currentType == "VERDADE"
                                  ? AppColors.primary.withValues(alpha: 0.3)
                                  : AppColors.purple.withValues(alpha: 0.3))
                            : AppColors.transparent,
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      if (isRevealed) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.whiteWithAlpha(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                currentPlayer.gender == Gender.female
                                    ? Icons.female
                                    : Icons.male,
                                color: AppColors.textPrimary,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${currentPlayer.name} - $currentType',
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      Icon(
                        isRevealed
                            ? (currentType == "VERDADE"
                                  ? Icons.psychology_rounded
                                  : Icons.favorite_rounded)
                            : Icons.help_outline_rounded,
                        color: AppColors.textPrimary,
                        size: 48,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        isRevealed ? currentText : 'Escolha Verdade ou Desafio',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const Spacer(),

          // Botões
          if (!isRevealed) ...[
            Row(
              children: [
                Expanded(
                  child: NakedButton(
                    text: "VERDADE",
                    color: AppColors.primary,
                    icon: Icons.psychology_rounded,
                    onTap: _selectTruth,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: NakedButton(
                    text: "DESAFIO",
                    color: AppColors.purple,
                    icon: Icons.favorite_rounded,
                    onTap: _selectDare,
                  ),
                ),
              ],
            ),
          ] else ...[
            NakedButton(
              text: "PRÓXIMA RODADA",
              color: AppColors.green,
              icon: Icons.arrow_forward,
              onTap: _nextPlayer,
            ),
          ],

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
