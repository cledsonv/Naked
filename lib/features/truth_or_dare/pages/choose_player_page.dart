import 'package:flutter/material.dart';
import 'package:naked/core/theme/app_colors.dart';
import 'package:naked/features/truth_or_dare/pages/category_selection_page.dart';
import 'package:naked/features/truth_or_dare/pages/widgets/player_field.dart';
import 'package:naked/features/truth_or_dare/models/player.dart';

enum SelectionMode { inOrder, random }

class ChoosePlayerPage extends StatefulWidget {
  const ChoosePlayerPage({super.key});

  @override
  State<ChoosePlayerPage> createState() => _ChoosePlayerPageState();
}

class _ChoosePlayerPageState extends State<ChoosePlayerPage> {
  List<Player> players = [
    Player(name: '', gender: Gender.female),
    Player(name: '', gender: Gender.male),
  ];
  SelectionMode selectionMode = SelectionMode.random;

  void _addPlayer() {
    setState(() {
      players.add(Player(name: '', gender: Gender.female));
    });
  }

  void _removePlayer(int index) {
    if (players.length > 2) {
      setState(() {
        players.removeAt(index);
      });
    }
  }

  bool _canProceed() {
    return players.length >= 2 &&
        players.every((player) => player.name.trim().isNotEmpty);
  }

  void _proceedToGame() {
    if (_canProceed()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CategorySelectionPage(
            players: players,
            isRandomOrder: selectionMode == SelectionMode.random,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.whiteWithAlpha(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.textPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Verdade ou Desafio',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.whiteWithAlpha(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.whiteWithAlpha(0.1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Como funciona?',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '• Adicione pelo menos 2 jogadores\n'
                              '• Digite o nome e selecione o gênero\n'
                              '• Escolha como os jogadores serão selecionados\n'
                              '• Clique no + para adicionar mais jogadores',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.whiteWithAlpha(0.8),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Jogadores',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...players.asMap().entries.map((entry) {
                        int index = entry.key;
                        Player player = entry.value;
                        return PlayerField(
                          index: index,
                          player: player,
                          players: players,
                          onRemove: _removePlayer,
                        );
                      }),

                      GestureDetector(
                        onTap: _addPlayer,
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.whiteWithAlpha(0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.5),
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: AppColors.primary,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Adicionar Jogador',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.whiteWithAlpha(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.whiteWithAlpha(0.1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Modo de Seleção dos Jogadores',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildSelectionOption(
                              'Ordem da Lista',
                              'Os jogadores serão selecionados na ordem que foram adicionados',
                              Icons.format_list_numbered,
                              SelectionMode.inOrder,
                            ),
                            const SizedBox(height: 12),
                            _buildSelectionOption(
                              'Aleatório',
                              'Os jogadores serão selecionados de forma aleatória',
                              Icons.shuffle,
                              SelectionMode.random,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: _canProceed() ? _proceedToGame : null,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: _canProceed()
                          ? AppColors.primaryGradient
                          : LinearGradient(
                              colors: [
                                AppColors.gray.withValues(alpha: 0.3),
                                AppColors.gray.withValues(alpha: 0.2),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: _canProceed()
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: _canProceed()
                              ? AppColors.textPrimary
                              : AppColors.gray,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Escolher Categoria',
                          style: TextStyle(
                            color: _canProceed()
                                ? AppColors.textPrimary
                                : AppColors.gray,
                            fontSize: 18,
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
        ),
      ),
    );
  }

  Widget _buildSelectionOption(
    String title,
    String description,
    IconData icon,
    SelectionMode mode,
  ) {
    bool isSelected = selectionMode == mode;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectionMode = mode;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.whiteWithAlpha(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.whiteWithAlpha(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.whiteWithAlpha(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? AppColors.textPrimary
                    : AppColors.whiteWithAlpha(0.7),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.whiteWithAlpha(0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primary, size: 24),
          ],
        ),
      ),
    );
  }
}
