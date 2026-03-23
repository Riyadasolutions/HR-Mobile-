import 'package:flutter/material.dart';

import '../../../data/careconnect_models.dart';
import '../../../shared/widgets/careconnect_shells.dart';
import '../../../theme/careconnect_theme.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LeaveContent();
  }
}

class LeaveContent extends StatelessWidget {
  const LeaveContent({super.key});

  @override
  Widget build(BuildContext context) {
    return StandalonePageScaffold(
      title: 'Leave Management',
      subtitle: 'Leave balance and requests',
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(child: MetricMiniCard(label: 'Available', value: '5', caption: 'days')),
              SizedBox(width: 12),
              Expanded(child: MetricMiniCard(label: 'Used', value: '10', caption: 'days', valueColor: Color(0xFFF0A61A))),
            ],
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'Request New Leave',
            icon: Icons.calendar_month_outlined,
            onPressed: () {},
          ),
          const SizedBox(height: 18),
          SectionSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Leave History', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                const SizedBox(height: 18),
                for (final leave in leaveHistory) ...[
                  _LeaveHistoryCard(entry: leave),
                  if (leave != leaveHistory.last) const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeaveHistoryCard extends StatelessWidget {
  const _LeaveHistoryCard({required this.entry});

  final LeaveEntry entry;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 5, height: 58, decoration: BoxDecoration(color: CareConnectColors.teal, borderRadius: BorderRadius.circular(10))),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(entry.dateRange, style: const TextStyle(fontSize: 16, color: CareConnectColors.textSecondary)),
            ],
          ),
        ),
        BadgePill(label: entry.status, backgroundColor: const Color(0xFFE2FAE9), textColor: const Color(0xFF58B873)),
      ],
    );
  }
}
