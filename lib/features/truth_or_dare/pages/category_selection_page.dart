import 'package:flutter/material.dart';
import 'package:naked/core/theme/app_colors.dart';
import 'package:naked/features/truth_or_dare/models/category.dart';
import 'package:naked/features/truth_or_dare/models/player.dart';
import 'package:naked/features/truth_or_dare/pages/truth_or_dare_screen.dart';

class CategorySelectionPage extends StatefulWidget {
  final List<Player> players;
  final bool isRandomOrder;

  const CategorySelectionPage({
    super.key,
    required this.players,
    required this.isRandomOrder,
  });

  @override
  State<CategorySelectionPage> createState() => _CategorySelectionPageState();
}

class _CategorySelectionPageState extends State<CategorySelectionPage>
    with TickerProviderStateMixin {
  CategoryLevel? selectedCategory;
  CategoryLevel? expandedCategory;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _proceedToGame() {
    if (selectedCategory != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TruthOrDareScreen(
            players: widget.players,
            isRandomOrder: widget.isRandomOrder,
            category: selectedCategory!,
          ),
        ),
      );
    }
  }

  Color _getCategoryColor(CategoryLevel level) {
    switch (level) {
      case CategoryLevel.romantic:
        return AppColors.primary;
      case CategoryLevel.intimate:
        return AppColors.purple;
      case CategoryLevel.passionate:
        return AppColors.secondary;
      case CategoryLevel.wild:
        return const Color(0xFF8B0000); // Dark red
    }
  }

  IconData _getCategoryIcon(CategoryLevel level) {
    switch (level) {
      case CategoryLevel.romantic:
        return Icons.favorite_border;
      case CategoryLevel.intimate:
        return Icons.favorite;
      case CategoryLevel.passionate:
        return Icons.local_fire_department;
      case CategoryLevel.wild:
        return Icons.whatshot;
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
              // Header
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
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.textPrimary,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Escolha a Categoria',
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
                      // Instruções simples
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Selecione o nível de intensidade desejado',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteWithAlpha(0.8),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Text(
                          'Toque no ícone ℹ️ para ver mais detalhes',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.whiteWithAlpha(0.6),
                          ),
                        ),
                      ),

                      // Lista de categorias
                      ...TruthOrDareCategory.categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildCategoryCard(category),
                        );
                      }),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              // Botão de continuar
              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: selectedCategory != null ? _proceedToGame : null,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: selectedCategory != null
                          ? AppColors.primaryGradient
                          : LinearGradient(
                              colors: [
                                AppColors.gray.withValues(alpha: 0.3),
                                AppColors.gray.withValues(alpha: 0.2),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: selectedCategory != null
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
                          color: selectedCategory != null
                              ? AppColors.textPrimary
                              : AppColors.gray,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Começar Jogo',
                          style: TextStyle(
                            color: selectedCategory != null
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

  Widget _buildCategoryCard(TruthOrDareCategory category) {
    final bool isSelected = selectedCategory == category.level;
    final bool isExpanded = expandedCategory == category.level;
    final Color categoryColor = _getCategoryColor(category.level);
    final IconData categoryIcon = _getCategoryIcon(category.level);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category.level;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? categoryColor.withValues(alpha: 0.1)
              : AppColors.whiteWithAlpha(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? categoryColor : AppColors.whiteWithAlpha(0.1),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: categoryColor.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? categoryColor
                        : categoryColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    categoryIcon,
                    color: isSelected ? AppColors.textPrimary : categoryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? categoryColor
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        category.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.whiteWithAlpha(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                // Info button
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: expandedCategory == null
                          ? _pulseAnimation.value
                          : 1.0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            expandedCategory = isExpanded
                                ? null
                                : category.level;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isExpanded
                                ? categoryColor.withValues(alpha: 0.2)
                                : AppColors.whiteWithAlpha(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isExpanded ? Icons.info : Icons.info_outline,
                            color: isExpanded
                                ? categoryColor
                                : AppColors.whiteWithAlpha(0.6),
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                if (isSelected)
                  Icon(Icons.check_circle, color: categoryColor, size: 24),
              ],
            ),

            // Expanded content
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: const SizedBox.shrink(),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: categoryColor.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: categoryColor.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.description_outlined,
                              color: categoryColor,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Detalhes',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: categoryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.details,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.whiteWithAlpha(0.8),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              Icons.star_outline,
                              color: categoryColor,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Características',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: categoryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: category.features.map((feature) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: categoryColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: categoryColor.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: categoryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
