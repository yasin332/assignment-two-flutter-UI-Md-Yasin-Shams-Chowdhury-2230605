import 'package:flutter/material.dart';

import '../data/student.dart';
import '../theme/app_colors.dart';
import '../widgets/app_message.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notifications = true;

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('Log out of Study on this device?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                'Log out',
                style: TextStyle(color: AppPalette.danger),
              ),
            ),
          ],
        );
      },
    );
    if (confirmed == true && mounted) {
      showAppMessage(context, 'Logged out');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final dark = widget.themeMode == ThemeMode.dark;

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Row(
            children: [
              const Text(
                'Profile',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => showAppMessage(context, 'Settings'),
                icon: Icon(Icons.settings_outlined, color: colors.ink),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Center(
            child: CircleAvatar(
              radius: 42,
              backgroundColor: AppPalette.blue,
              child: Text(
                Student.initials,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            Student.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            Student.id,
            textAlign: TextAlign.center,
            style: TextStyle(color: colors.muted, fontSize: 14),
          ),
          const SizedBox(height: 26),
          const _GroupLabel('Personal details'),
          const SizedBox(height: 10),
          const _DetailRow(
            icon: Icons.badge_outlined,
            label: 'Student ID',
            value: Student.id,
          ),
          const _DetailRow(
            icon: Icons.mail_outline,
            label: 'Email',
            value: Student.email,
          ),
          const _DetailRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: Student.phone,
          ),
          const _DetailRow(
            icon: Icons.desktop_windows_outlined,
            label: 'Department',
            value: Student.department,
          ),
          const _DetailRow(
            icon: Icons.calendar_today_outlined,
            label: 'Semester',
            value: Student.semester,
          ),
          const SizedBox(height: 18),
          const _GroupLabel('Preferences'),
          const SizedBox(height: 10),
          _PreferenceRow(
            icon: Icons.notifications_none_rounded,
            label: 'Notifications',
            trailing: Switch(
              value: _notifications,
              activeThumbColor: Colors.white,
              activeTrackColor: AppPalette.blue,
              onChanged: (value) => setState(() => _notifications = value),
            ),
          ),
          _PreferenceRow(
            icon: Icons.schedule,
            label: 'Study reminder',
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Study reminder'),
                    content: const Text('Your reminder is set for 8:00 PM.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '8:00 PM',
                  style: TextStyle(
                    color: colors.ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.chevron_right, color: colors.muted),
              ],
            ),
          ),
          _PreferenceRow(
            icon: Icons.dark_mode_outlined,
            label: 'Dark mode',
            trailing: Switch(
              value: dark,
              activeThumbColor: Colors.white,
              activeTrackColor: AppPalette.blue,
              onChanged: (value) {
                widget.onThemeModeChanged(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: colors.card,
              foregroundColor: AppPalette.danger,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: _logout,
            child: const Text(
              'Log out',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupLabel extends StatelessWidget {
  const _GroupLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: colors.cardShadow,
        ),
        child: Row(
          children: [
            _IconBadge(icon: icon),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(color: colors.muted, fontSize: 14)),
            const SizedBox(width: 12),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  value,
                  style: TextStyle(
                    color: colors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreferenceRow extends StatelessWidget {
  const _PreferenceRow({
    required this.icon,
    required this.label,
    required this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: colors.card,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.fromLTRB(14, 8, 10, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: colors.cardShadow,
            ),
            child: Row(
              children: [
                _IconBadge(icon: icon),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(color: colors.ink, fontSize: 15),
                  ),
                ),
                trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppPalette.blue.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: AppPalette.blue, size: 18),
    );
  }
}
