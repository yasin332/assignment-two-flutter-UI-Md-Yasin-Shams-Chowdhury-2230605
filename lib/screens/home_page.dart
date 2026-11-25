import 'package:flutter/material.dart';

import '../data/student.dart';
import '../models/task_item.dart';
import '../theme/app_colors.dart';
import '../widgets/app_message.dart';
import '../widgets/priority_chip.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onSeeAll});

  final VoidCallback onSeeAll;

  @override
  State<HomePage> createState() => _HomePageState();
}

const _weekDays = [
  ('Mon', '9'),
  ('Tue', '10'),
  ('Wed', '11'),
  ('Thu', '12'),
  ('Fri', '13'),
  ('Sat', '14'),
  ('Sun', '15'),
];

class _HomePageState extends State<HomePage> {
  int _selectedDay = 4;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          _Header(colors: colors),
          const SizedBox(height: 22),
          _WeekStrip(
            colors: colors,
            selectedDay: _selectedDay,
            onSelect: (index) => setState(() => _selectedDay = index),
          ),
          const SizedBox(height: 18),
          const _StudyGoalCard(),
          const SizedBox(height: 22),
          _SectionTitle(
            title: 'Due soon',
            action: 'See all',
            onAction: widget.onSeeAll,
          ),
          const SizedBox(height: 10),
          const _DueCard(
            title: 'Lab 6: Navigation and routing',
            meta: 'CSE 464 · Today, 11:59 PM',
            priority: Priority.high,
            accent: AppPalette.highForeground,
          ),
          const SizedBox(height: 12),
          const _DueCard(
            title: 'ER diagram for library system',
            meta: 'CSE 303 · Tomorrow, 5:00 PM',
            priority: Priority.medium,
            accent: AppPalette.mediumForeground,
          ),
          const SizedBox(height: 22),
          _SectionTitle(
            title: "Today's classes",
            action: 'Timetable',
            onAction: () => showAppMessage(context, 'Timetable'),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _ClassCard(
                  time: '10:00 AM',
                  course: 'CSE 464',
                  room: 'Room 7012',
                  background: colors.classBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ClassCard(
                  time: '1:30 PM',
                  course: 'MAT 212',
                  room: 'Room 3021',
                  background: colors.classGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.colors});

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: AppPalette.blue,
          child: Text(
            Student.initials,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning,',
                style: TextStyle(color: colors.muted, fontSize: 14),
              ),
              const SizedBox(height: 2),
              const Text(
                Student.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => showAppMessage(context, 'No new notifications'),
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(Icons.notifications_none_rounded, color: colors.ink),
              Positioned(
                right: -1,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppPalette.danger,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.background, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WeekStrip extends StatelessWidget {
  const _WeekStrip({
    required this.colors,
    required this.selectedDay,
    required this.onSelect,
  });

  final AppColors colors;
  final int selectedDay;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < _weekDays.length; i++)
          Expanded(
            child: _DayChip(
              label: _weekDays[i].$1,
              date: _weekDays[i].$2,
              selected: i == selectedDay,
              colors: colors,
              onTap: () => onSelect(i),
            ),
          ),
      ],
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.label,
    required this.date,
    required this.selected,
    required this.colors,
    required this.onTap,
  });

  final String label;
  final String date;
  final bool selected;
  final AppColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: selected ? AppPalette.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: selected ? Colors.white70 : colors.muted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: selected ? Colors.white : colors.ink,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StudyGoalCard extends StatelessWidget {
  const _StudyGoalCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4C82FF), AppPalette.blue, AppPalette.blueDeep],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x402F6BFF),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned(
              right: -36,
              top: -28,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              right: 36,
              bottom: -46,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TODAY'S STUDY GOAL",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.82),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '2h 15m',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        TextSpan(
                          text: ' of 3h',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: const LinearProgressIndicator(
                      value: 2.25 / 3,
                      minHeight: 6,
                      backgroundColor: Color(0x55FFFFFF),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '3 tasks due today · 6 day streak',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13,
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.action,
    required this.onAction,
  });

  final String title;
  final String action;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: colors.ink,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onAction,
          child: Text(
            action,
            style: const TextStyle(
              color: AppPalette.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _DueCard extends StatelessWidget {
  const _DueCard({
    required this.title,
    required this.meta,
    required this.priority,
    required this.accent,
  });

  final String title;
  final String meta;
  final Priority priority;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(18),
        boxShadow: colors.cardShadow,
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 36,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  meta,
                  style: TextStyle(color: colors.muted, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          PriorityChip(priority: priority),
        ],
      ),
    );
  }
}

class _ClassCard extends StatelessWidget {
  const _ClassCard({
    required this.time,
    required this.course,
    required this.room,
    required this.background,
  });

  final String time;
  final String course;
  final String room;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Text(course, style: TextStyle(color: colors.muted, fontSize: 13)),
          const SizedBox(height: 2),
          Text(room, style: TextStyle(color: colors.muted, fontSize: 13)),
        ],
      ),
    );
  }
}
