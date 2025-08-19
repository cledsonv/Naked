import 'package:flutter/material.dart';
import 'package:naked/core/theme/app_colors.dart';
import 'package:naked/features/home/view/widgets/game_card.dart';
import 'package:naked/features/truth_or_dare/pages/choose_player_page.dart';
import 'package:naked/features/deep_questions/deep_questions_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColors.borderColor(),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    'NAKED',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      letterSpacing: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Conectem-se mais profundamente',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.whiteWithAlpha(0.7),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Spacer(),

                GameCard(
                  title: 'Verdade ou Desafio',
                  subtitle: 'Descobrindo segredos e criando momentos únicos',
                  icon: Icons.favorite_rounded,
                  gradient: AppColors.primaryGradient,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChoosePlayerPage(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                GameCard(
                  title: 'Perguntas Profundas',
                  subtitle: 'Conversas íntimas que aproximam corações',
                  icon: Icons.psychology_rounded,
                  gradient: AppColors.purpleBlueGradient,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeepQuestionsScreen(),
                      ),
                    );
                  },
                ),

                const Spacer(),

                Text(
                  '💕 Feito com amor para casais 💕',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.whiteWithAlpha(0.5),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
