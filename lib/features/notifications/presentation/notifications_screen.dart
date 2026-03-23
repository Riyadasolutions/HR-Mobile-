import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/careconnect_api.dart';
import '../../../data/careconnect_models.dart';
import '../../../shared/widgets/careconnect_shells.dart';
import '../../../theme/careconnect_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = context.read<CareConnectApi>();
    return FutureBuilder<List<NotificationItem>>(
      future: api.fetchNotifications(),
      builder: (context, snapshot) {
        final items = snapshot.data ?? notifications;
        return StandalonePageScaffold(
          title: 'Notifications',
          subtitle: 'Recent alerts and updates',
          trailingBadge: '4 New',
          child: Column(
            children: [
              SectionSurface(
                child: const Row(
                  children: [
                    Expanded(child: MetricMiniCard(label: 'UNREAD', value: '4', caption: '')),
                    SizedBox(width: 12),
                    Expanded(child: MetricMiniCard(label: 'TODAY', value: '7', caption: '')),
                    SizedBox(width: 12),
                    Expanded(child: MetricMiniCard(label: 'ALERTS', value: '2', caption: '')),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Row(
                children: [
                  _TagChip(label: 'All', selected: true),
                  SizedBox(width: 8),
                  _TagChip(label: 'Payroll'),
                  SizedBox(width: 8),
                  _TagChip(label: 'Attendance', accent: Color(0xFFFFD46A)),
                ],
              ),
              const SizedBox(height: 16),
              SectionSurface(
                child: Column(
                  children: [
                    for (final item in items) ...[
                      _NotificationCard(item: item),
                      if (item != items.last) const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label, this.selected = false, this.accent});

  final String label;
  final bool selected;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final background = selected ? const Color(0xFFE4F6F2) : accent?.withOpacity(0.28) ?? const Color(0xFFF2F5F8);
    final textColor = selected ? CareConnectColors.tealDark : accent ?? CareConnectColors.textSecondary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(999)),
      child: Text(label, style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w600)),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.item});

  final NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            decoration: const BoxDecoration(color: CareConnectColors.tealLight, shape: BoxShape.circle),
            child: Icon(item.icon, color: CareConnectColors.teal),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(item.message, style: const TextStyle(fontSize: 15, color: CareConnectColors.textSecondary)),
              ],
            ),
          ),
          BadgePill(label: item.badge),
        ],
      ),
    );
  }
}
