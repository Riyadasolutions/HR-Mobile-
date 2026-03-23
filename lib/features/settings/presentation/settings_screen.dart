import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_routes.dart';
import '../../../shared/widgets/careconnect_shells.dart';
import '../../../state/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return StandalonePageScaffold(
      title: 'Settings',
      subtitle: 'Language and appearance',
      trailingBadge: 'Saved',
      child: Column(
        children: [
          SectionSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Language', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: ChoicePill(
                        label: 'EN',
                        icon: Icons.translate_rounded,
                        selected: !appState.isArabic,
                        onTap: () => context.read<AppState>().setLanguage(CareConnectLanguage.english),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ChoicePill(
                        label: 'AR',
                        icon: Icons.translate_rounded,
                        selected: appState.isArabic,
                        onTap: () => context.read<AppState>().setLanguage(CareConnectLanguage.arabic),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Theme Mode', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: ChoicePill(
                        label: 'Light',
                        icon: Icons.wb_sunny_outlined,
                        selected: !appState.isDarkMode,
                        onTap: () => context.read<AppState>().setTheme(false),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ChoicePill(
                        label: 'Dark',
                        icon: Icons.nightlight_round,
                        selected: appState.isDarkMode,
                        onTap: () => context.read<AppState>().setTheme(true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('App Preferences', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                const SizedBox(height: 16),
                _SettingsTile(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifications',
                  subtitle: 'Push and in-app alerts',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
                ),
                const SizedBox(height: 12),
                _SettingsTile(
                  icon: Icons.security_rounded,
                  title: 'Security',
                  subtitle: 'Face ID and session timeout',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.title, required this.subtitle, required this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: careConnectSurfaceShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(color: Color(0xFFDAF3EF), shape: BoxShape.circle),
              child: Icon(icon, color: Colors.teal),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 15, color: Color(0xFF6F7B85))),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFFB7BEC6), size: 30),
          ],
        ),
      ),
    );
  }
}
