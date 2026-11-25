import 'package:flutter/material.dart';

import '../models/task_item.dart';
import '../theme/app_colors.dart';

class PriorityChip extends StatelessWidget {
  const PriorityChip({super.key, required this.priority});

  final Priority priority;

  @override
  Widget build(BuildContext context) {
    final (label, background, foreground) = switch (priority) {
      Priority.high => (
        'High',
        AppPalette.highBackground,
        AppPalette.highForeground,
      ),
      Priority.medium => (
        'Medium',
        AppPalette.mediumBackground,
        AppPalette.mediumForeground,
      ),
      Priority.low => (
        'Low',
        AppPalette.lowBackground,
        AppPalette.lowForeground,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
