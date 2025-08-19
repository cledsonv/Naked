import 'package:flutter/material.dart';
import 'dart:math';

class DeepQuestionsScreen extends StatefulWidget {
  const DeepQuestionsScreen({super.key});

  @override
  State<DeepQuestionsScreen> createState() => _DeepQuestionsScreenState();
}

class _DeepQuestionsScreenState extends State<DeepQuestionsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  int currentQuestionIndex = 0;
  bool isRevealed = false;

  final List<Map<String, dynamic>> deepQuestions = [
    {
      "question": "O que você mais valoriza em nossa relação?",
      "category": "Amor",
      "color": const Color(0xFFE74C3C),
    },
    {
      "question": "Como você imagina nosso futuro juntos?",
      "category": "Futuro",
      "color": const Color(0xFF8E44AD),
    },
    {
      "question": "Qual é o seu maior medo em relação ao amor?",
      "category": "Medos",
      "color": const Color(0xFF34495E),
    },
    {
      "question": "O que te faz sentir mais amado(a) por mim?",
      "category": "Amor",
      "color": const Color(0xFFE74C3C),
    },
    {
      "question": "Qual momento nosso você guardaria para sempre?",
      "category": "Memórias",
      "color": const Color(0xFFFF6B9D),
    },
    {
      "question": "Como eu posso te apoiar melhor nos seus sonhos?",
      "category": "Apoio",
      "color": const Color(0xFF27AE60),
    },
    {
      "question": "O que você acha que nos torna únicos como casal?",
      "category": "Relacionamento",
      "color": const Color(0xFF3498DB),
    },
    {
      "question":
          "Qual é a coisa mais vulnerável que você compartilharia comigo?",
      "category": "Vulnerabilidade",
      "color": const Color(0xFFF39C12),
    },
    {
      "question": "Como você quer que nossa intimidade evolua?",
      "category": "Intimidade",
      "color": const Color(0xFFE74C3C),
    },
    {
      "question": "O que você mais admira na minha personalidade?",
      "category": "Admiração",
      "color": const Color(0xFF9B59B6),
    },
    {
      "question": "Qual é seu maior sonho que podemos realizar juntos?",
      "category": "Sonhos",
      "color": const Color(0xFF1ABC9C),
    },
    {
      "question": "Como você se sente quando estamos em silêncio juntos?",
      "category": "Conexão",
      "color": const Color(0xFF95A5A6),
    },
    {
      "question": "O que você gostaria que eu soubesse sobre seus sentimentos?",
      "category": "Sentimentos",
      "color": const Color(0xFFFF6B9D),
    },
    {
      "question": "Qual é a forma mais profunda de demonstrar amor para você?",
      "category": "Amor",
      "color": const Color(0xFFE74C3C),
    },
    {
      "question": "Como podemos crescer mais juntos como casal?",
      "category": "Crescimento",
      "color": const Color(0xFF27AE60),
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _revealQuestion() {
    if (!isRevealed) {
      setState(() {
        isRevealed = true;
        currentQuestionIndex = Random().nextInt(deepQuestions.length);
      });
      _animationController.forward();
    }
  }

  void _nextQuestion() {
    _animationController.reverse().then((_) {
      setState(() {
        currentQuestionIndex = Random().nextInt(deepQuestions.length);
      });
      _animationController.forward();
    });
  }

  void _reset() {
    _animationController.reverse().then((_) {
      setState(() {
        isRevealed = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = deepQuestions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A1A), Color(0xFF0F0F0F), Color(0xFF2C1810)],
          ),
        ),
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
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Perguntas Profundas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 40),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Spacer(),

                      // Question Card
                      if (!isRevealed) ...[
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.1),
                                Colors.white.withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.psychology_rounded,
                                color: Colors.white,
                                size: 64,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Toque para revelar\numa pergunta profunda',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Opacity(
                                opacity: _fadeAnimation.value,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        currentQuestion['color'] as Color,
                                        (currentQuestion['color'] as Color)
                                            .withOpacity(0.7),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            (currentQuestion['color'] as Color)
                                                .withOpacity(0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          currentQuestion['category'] as String,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      const Icon(
                                        Icons.favorite_rounded,
                                        color: Colors.white,
                                        size: 48,
                                      ),
                                      const SizedBox(height: 30),
                                      Text(
                                        currentQuestion['question'] as String,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],

                      const Spacer(),

                      // Action Buttons
                      if (!isRevealed) ...[
                        GestureDetector(
                          onTap: _revealQuestion,
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8E44AD), Color(0xFF3498DB)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF8E44AD,
                                  ).withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.psychology_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'REVELAR PERGUNTA',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ] else ...[
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: _nextQuestion,
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF27AE60),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF27AE60,
                                        ).withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.refresh_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'PRÓXIMA',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: GestureDetector(
                                onTap: _reset,
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.home_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'INÍCIO',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
