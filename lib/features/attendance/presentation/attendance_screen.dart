import 'package:flutter/material.dart';

import '../../../data/careconnect_models.dart';
import '../../../shared/widgets/careconnect_shells.dart';
import '../../../theme/careconnect_theme.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AttendanceContent();
  }
}

class AttendanceContent extends StatelessWidget {
  const AttendanceContent({super.key});

  @override
  Widget build(BuildContext context) {
    const records = attendanceRecords;
    return StandalonePageScaffold(
      title: 'Attendance',
      subtitle: 'March 2025',
      trailingBadge: '92%',
      child: Column(
        children: [
          const StatusOutlineCard(
            title: 'Today - Present',
            subtitle: 'Check In: 8:30 AM | Check Out: (Pending)',
          ),
          const SizedBox(height: 18),
          const Row(
            children: [
              Expanded(child: MetricMiniCard(label: 'Present', value: '22', caption: '')),
              SizedBox(width: 12),
              Expanded(child: MetricMiniCard(label: 'Absent', value: '1', caption: '', valueColor: Color(0xFFE13A35))),
              SizedBox(width: 12),
              Expanded(child: MetricMiniCard(label: 'Rate', value: '92%', caption: '')),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(label: 'Check In', onPressed: () {}),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SecondaryActionButton(label: 'Check Out', onPressed: () {}),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SectionSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Recent Records', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                const SizedBox(height: 18),
                for (final record in records) ...[
                  _AttendanceRow(record: record),
                  if (record != records.last) const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Divider(height: 1, color: CareConnectColors.border),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceRow extends StatelessWidget {
  const _AttendanceRow({required this.record});

  final AttendanceRecord record;

  @override
  Widget build(BuildContext context) {
    final isAbsent = record.status.toLowerCase() == 'absent';
    return Row(
      children: [
        Text(record.date, style: const TextStyle(fontSize: 21)),
        const Spacer(),
        BadgePill(
          label: record.status,
          backgroundColor: isAbsent ? const Color(0xFFF8DFE0) : const Color(0xFFE4F8EC),
          textColor: isAbsent ? const Color(0xFFE15A58) : const Color(0xFF49B673),
        ),
      ],
    );
  }
}
