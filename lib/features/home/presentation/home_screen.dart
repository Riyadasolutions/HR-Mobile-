import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_routes.dart';
import '../../../data/careconnect_api.dart';
import '../../../data/careconnect_models.dart';
import '../../../shared/widgets/careconnect_shells.dart';
import '../../../state/app_state.dart';
import '../../../theme/careconnect_theme.dart';
import '../../attendance/presentation/attendance_screen.dart';
import '../../employees/presentation/employees_screens.dart';
import '../../leave/presentation/leave_screen.dart';
import '../../profile/presentation/profile_screen.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final pages = <Widget>[
      const HomeDashboardContent(),
      const EmployeesDirectoryContent(),
      const AttendanceContent(),
      const LeaveContent(),
      const ProfileContent(),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: appState.homeTabIndex, children: pages),
      ),
      bottomNavigationBar: _BottomNavBar(
        currentIndex: appState.homeTabIndex,
        onTap: context.read<AppState>().selectHomeTab,
      ),
    );
  }
}

class HomeDashboardContent extends StatelessWidget {
  const HomeDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final api = context.read<CareConnectApi>();
    return FutureBuilder<DashboardSummary>(
      future: api.fetchDashboardSummary(),
      builder: (context, snapshot) {
        final summary = snapshot.data ?? dashboardSummary;
        return SingleChildScrollView(
          padding: careConnectPagePadding.copyWith(bottom: 24),
          child: Column(
            children: [
              _HomeTopBar(
                onMenuTap: () => context.read<AppState>().selectHomeTab(4),
                onNotificationsTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
              ),
              const SizedBox(height: 14),
              _QuickAccessCard(onPayslipTap: () => Navigator.pushNamed(context, AppRoutes.payslip)),
              const SizedBox(height: 16),
              _HomeHeroCard(summary: summary),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: MetricMiniCard(label: 'Team', value: '${summary.teamMembers}', caption: 'Members'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MetricMiniCard(label: 'Pending', value: '${summary.pendingApprovals}', caption: 'Approvals'),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: MetricMiniCard(label: 'Net Pay', value: 'SAR\n8,450', caption: 'March 2025', valueColor: Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              StatusBanner(label: 'TODAY', title: 'Checked in at ${summary.checkInTime}', trailing: Icons.verified_rounded),
            ],
          ),
        );
      },
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 24, offset: Offset(0, -8))],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              _BottomNavItem(icon: Icons.home_outlined, label: 'Home', selected: currentIndex == 0, onTap: () => onTap(0)),
              _BottomNavItem(icon: Icons.people_alt_outlined, label: 'Employees', selected: currentIndex == 1, onTap: () => onTap(1)),
              _BottomNavItem(icon: Icons.access_time_rounded, label: 'Attendance', selected: currentIndex == 2, onTap: () => onTap(2)),
              _BottomNavItem(icon: Icons.event_note_outlined, label: 'Leave', selected: currentIndex == 3, onTap: () => onTap(3)),
              _BottomNavItem(icon: Icons.person_outline_rounded, label: 'Profile', selected: currentIndex == 4, onTap: () => onTap(4)),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({required this.icon, required this.label, required this.selected, required this.onTap});

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? CareConnectColors.tealDark : const Color(0xFF88939D);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 26),
              const SizedBox(height: 4),
              Text(label, textAlign: TextAlign.center, style: TextStyle(color: color, fontSize: 13)),
              const SizedBox(height: 4),
              Container(height: 3, width: 40, decoration: BoxDecoration(color: selected ? CareConnectColors.teal : Colors.transparent, borderRadius: BorderRadius.circular(99))),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeTopBar extends StatelessWidget {
  const _HomeTopBar({required this.onMenuTap, required this.onNotificationsTap});

  final VoidCallback onMenuTap;
  final VoidCallback onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HeaderCircleButton(icon: Icons.menu_rounded, onTap: onMenuTap),
        const SizedBox(width: 14),
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: careConnectSurfaceShadow,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CARECONNECT', style: TextStyle(letterSpacing: 4, fontSize: 11, color: CareConnectColors.textSecondary)),
              SizedBox(height: 4),
              Text('Welcome Back', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        HeaderCircleButton(icon: Icons.notifications_none_rounded, onTap: onNotificationsTap, badge: true),
      ],
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  const _QuickAccessCard({required this.onPayslipTap});

  final VoidCallback onPayslipTap;

  @override
  Widget build(BuildContext context) {
    return SectionSurface(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          const Expanded(
            child: Text('Quick access to your daily tools', style: TextStyle(fontSize: 17, color: CareConnectColors.textSecondary)),
          ),
          TextButton(
            onPressed: onPayslipTap,
            child: const Text('Payslip', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: CareConnectColors.tealDark)),
          ),
        ],
      ),
    );
  }
}

class _HomeHeroCard extends StatelessWidget {
  const _HomeHeroCard({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    return SectionSurface(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: CareConnectColors.teal, borderRadius: BorderRadius.circular(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('CARECONNECT', style: TextStyle(letterSpacing: 4, fontSize: 12, color: Colors.white70)),
                const Spacer(),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.18)),
                  ),
                  child: const Icon(Icons.health_and_safety_rounded, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              'Good\nMorning,\n${summary.userName}',
              style: const TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.w800, height: 1.02),
            ),
            const SizedBox(height: 14),
            const Text('3 approvals and 1 leave request waiting.', style: TextStyle(fontSize: 17, color: Colors.white, height: 1.45)),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.14)),
              ),
              child: Row(
                children: [
                  Text(summary.monthLabel, style: const TextStyle(fontSize: 16, color: Colors.white70)),
                  const Spacer(),
                  const Text('24 employees • 1 runs', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: 'Attendance',
                    backgroundColor: Colors.white,
                    textColor: CareConnectColors.textPrimary,
                    onPressed: () => context.read<AppState>().selectHomeTab(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    label: 'Request Leave',
                    backgroundColor: const Color(0xFF1FC578),
                    textColor: Colors.white,
                    onPressed: () => context.read<AppState>().selectHomeTab(3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
