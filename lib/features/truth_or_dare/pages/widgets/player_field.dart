import 'package:flutter/material.dart';
import 'package:naked/core/theme/app_colors.dart' show AppColors;
import 'package:naked/features/truth_or_dare/models/player.dart';

class PlayerField extends StatefulWidget {
  final int index;
  final Player player;
  final List<Player> players;
  final void Function(int) onRemove;
  const PlayerField({
    super.key,
    required this.index,
    required this.player,
    required this.players,
    required this.onRemove,
  });

  @override
  State<PlayerField> createState() => _PlayerFieldState();
}

class _PlayerFieldState extends State<PlayerField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteWithAlpha(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.whiteWithAlpha(0.1), width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    widget.player.name = value;
                  });
                },
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'Nome do jogador ${widget.index + 1}',
                  hintStyle: TextStyle(color: AppColors.whiteWithAlpha(0.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.whiteWithAlpha(0.2),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.whiteWithAlpha(0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.whiteWithAlpha(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.player.gender = Gender.female;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: widget.player.gender == Gender.female
                            ? AppColors.primary
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.female,
                            size: 16,
                            color: widget.player.gender == Gender.female
                                ? AppColors.textPrimary
                                : AppColors.whiteWithAlpha(0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'F',
                            style: TextStyle(
                              color: widget.player.gender == Gender.female
                                  ? AppColors.textPrimary
                                  : AppColors.whiteWithAlpha(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.player.gender = Gender.male;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: widget.player.gender == Gender.male
                            ? AppColors.blue
                            : AppColors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.male,
                            size: 16,
                            color: widget.player.gender == Gender.male
                                ? AppColors.textPrimary
                                : AppColors.whiteWithAlpha(0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'M',
                            style: TextStyle(
                              color: widget.player.gender == Gender.male
                                  ? AppColors.textPrimary
                                  : AppColors.whiteWithAlpha(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (widget.players.length > 2) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => widget.onRemove(widget.index),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.remove_circle_outline,
                    color: AppColors.secondary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
