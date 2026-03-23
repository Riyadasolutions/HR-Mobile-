import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/careconnect_api.dart';
import '../../../data/careconnect_models.dart';
import '../../../shared/widgets/careconnect_shells.dart';
import '../../../theme/careconnect_theme.dart';

class PayslipScreen extends StatelessWidget {
  const PayslipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = context.read<CareConnectApi>();
    return FutureBuilder<PayslipSummary>(
      future: api.fetchPayslipSummary(),
      builder: (context, snapshot) {
        final payslip = snapshot.data ?? payslipSummary;
        return StandalonePageScaffold(
          title: 'Payslip',
          subtitle: 'March 2025',
          trailingBadge: 'SAR 8,450',
          child: Column(
            children: [
              _PayslipHeroCard(summary: payslip),
              const SizedBox(height: 18),
              const Row(
                children: [
                  Expanded(child: _PayslipTotalCard(label: 'Basic', value: 'SAR\n6,000', caption: 'Salary')),
                  SizedBox(width: 12),
                  Expanded(child: _PayslipTotalCard(label: 'Net Pay', value: 'SAR\n8,450', caption: 'March 2025', valueColor: Colors.green)),
                ],
              ),
              const SizedBox(height: 18),
              SectionSurface(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Payroll Breakdown', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 18),
                    for (final item in payslip.breakdown) ...[
                      _PayslipRow(item: item),
                      if (item != payslip.breakdown.last) const SizedBox(height: 18),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 18),
              PrimaryButton(
                label: 'Download Payslip',
                icon: Icons.download_rounded,
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PayslipHeroCard extends StatelessWidget {
  const _PayslipHeroCard({required this.summary});

  final PayslipSummary summary;

  @override
  Widget build(BuildContext context) {
    return SectionSurface(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: CareConnectColors.teal, borderRadius: BorderRadius.circular(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('CARECONNECT PAYSLIP', style: TextStyle(letterSpacing: 4, fontSize: 12, color: Colors.white70)),
            const SizedBox(height: 12),
            Text(summary.employeeName, style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(summary.role, style: const TextStyle(fontSize: 17, color: Colors.white70)),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.16)),
              ),
              child: Row(
                children: [
                  Text(summary.period, style: const TextStyle(fontSize: 16, color: Colors.white70)),
                  const Spacer(),
                  Text(summary.paidOn, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PayslipTotalCard extends StatelessWidget {
  const _PayslipTotalCard({required this.label, required this.value, required this.caption, this.valueColor});

  final String label;
  final String value;
  final String caption;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return SectionSurface(
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 18, color: CareConnectColors.textSecondary)),
          const SizedBox(height: 10),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: valueColor ?? CareConnectColors.tealDark),
          ),
          const SizedBox(height: 6),
          Text(caption, style: const TextStyle(fontSize: 17, color: CareConnectColors.textSecondary)),
        ],
      ),
    );
  }
}

class _PayslipRow extends StatelessWidget {
  const _PayslipRow({required this.item});

  final PayslipBreakdownItem item;

  @override
  Widget build(BuildContext context) {
    final color = item.isNetTotal
        ? CareConnectColors.tealDark
        : item.isNegative
            ? const Color(0xFFD13C34)
            : item.label == 'Allowances'
                ? CareConnectColors.tealDark
                : CareConnectColors.textPrimary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(item.label, style: TextStyle(fontSize: item.isNetTotal ? 24 : 18, fontWeight: item.isNetTotal ? FontWeight.w800 : FontWeight.w400)),
        Text(item.amount, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: color)),
      ],
    );
  }
}
