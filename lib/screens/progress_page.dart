import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/app_message.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _Week {
  const _Week({
    required this.label,
    required this.studied,
    required this.tasksDone,
    required this.streak,
    required this.progress,
    required this.goal,
    required this.delta,
  });

  final String label;
  final String studied;
  final String tasksDone;
  final String streak;
  final double progress;
  final String goal;
  final String delta;
}

class _ProgressPageState extends State<ProgressPage> {
  static const _weeks = [
    _Week(
      label: 'Last week · 2 to 8 Nov',
      studied: '7h 40m',
      tasksDone: '11',
      streak: '5 days',
      progress: 0.64,
      goal: '7h 40m of 12h goal',
      delta: '+6% vs previous week',
    ),
    _Week(
      label: 'This week · 9 to 15 Nov',
      studied: '9h 21m',
      tasksDone: '14',
      streak: '6 days',
      progress: 0.78,
      goal: '9h 21m of 12h goal',
      delta: '+18% vs last week',
    ),
    _Week(
      label: 'Next week · 16 to 22 Nov',
      studied: '1h 05m',
      tasksDone: '2',
      streak: '6 days',
      progress: 0.09,
      goal: '1h 05m of 12h goal',
      delta: 'Week just started',
    ),
  ];

  int _index = 1;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final week = _weeks[_index];

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Row(
            children: [
              const Text(
                'Progress',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => showAppMessage(context, 'Calendar'),
                icon: Icon(Icons.calendar_today_outlined, color: colors.ink),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: colors.searchFill,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: _index == 0
                      ? null
                      : () => setState(() => _index -= 1),
                  icon: const Icon(Icons.chevron_left),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      week.label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: _index == _weeks.length - 1
                      ? null
                      : () => setState(() => _index += 1),
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _StatCard(
                icon: Icons.schedule,
                iconColor: AppPalette.blue,
                value: week.studied,
                label: 'Studied',
              ),
              const SizedBox(width: 10),
              _StatCard(
                icon: Icons.check_circle_outline,
                iconColor: AppPalette.lowForeground,
                value: week.tasksDone,
                label: 'Tasks done',
              ),
              const SizedBox(width: 10),
              _StatCard(
                icon: Icons.local_fire_department_outlined,
                iconColor: const Color(0xFFF08A24),
                value: week.streak,
                label: 'Streak',
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.card,
              borderRadius: BorderRadius.circular(18),
              boxShadow: colors.cardShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      switch (_index) {
                        0 => 'Last week',
                        2 => 'Next week',
                        _ => 'This week',
                      },
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${(week.progress * 100).round()}%',
                      style: const TextStyle(
                        color: AppPalette.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  week.goal,
                  style: TextStyle(color: colors.muted, fontSize: 13),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: week.progress,
                    minHeight: 8,
                    backgroundColor: colors.track,
                    color: AppPalette.blue,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppPalette.lowBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    week.delta,
                    style: const TextStyle(
                      color: AppPalette.lowForeground,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              const Text(
                'Courses',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => showAppMessage(context, 'Manage courses'),
                child: const Text(
                  'Manage',
                  style: TextStyle(
                    color: AppPalette.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const _CourseCard(
            code: '464',
            title: 'CSE 464 · Mobile Dev',
            next: 'Next: Lab 6, today',
            progress: 0.72,
            color: AppPalette.blue,
          ),
          const SizedBox(height: 12),
          const _CourseCard(
            code: '303',
            title: 'CSE 303 · Databases',
            next: 'Next: ER diagram, Sat',
            progress: 0.58,
            color: Color(0xFFF08A24),
          ),
          const SizedBox(height: 12),
          const _CourseCard(
            code: '212',
            title: 'MAT 212 · Linear Algebra',
            next: 'Next: Problem set 4, Mon',
            progress: 0.84,
            color: AppPalette.lowForeground,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(18),
          boxShadow: colors.cardShadow,
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(height: 10),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: colors.muted, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({
    required this.code,
    required this.title,
    required this.next,
    required this.progress,
    required this.color,
  });

  final String code;
  final String title;
  final String next;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(18),
        boxShadow: colors.cardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              code,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      '${(progress * 100).round()}%',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  next,
                  style: TextStyle(color: colors.muted, fontSize: 13),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: colors.track,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
