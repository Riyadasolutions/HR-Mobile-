import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_routes.dart';
import '../data/careconnect_api.dart';
import '../data/careconnect_models.dart';
import '../state/app_state.dart';
import '../theme/careconnect_theme.dart';

const _pagePadding = EdgeInsets.symmetric(horizontal: 18, vertical: 14);
const _surfaceShadow = [
  BoxShadow(
    color: Color(0x12000000),
    blurRadius: 24,
    offset: Offset(0, 12),
  ),
];

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [CareConnectColors.teal, CareConnectColors.tealDark],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: 118,
                  height: 118,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(34),
                    border: Border.all(color: Colors.white.withOpacity(0.25)),
                  ),
                  child: const Icon(
                    Icons.health_and_safety_rounded,
                    color: Colors.white,
                    size: 58,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'CareConnect',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'HR MOBILE APP',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.82),
                    letterSpacing: 5,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Good Morning, Ahmed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    height: 1.08,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Attendance, leave, employee details, notifications, and payslips in one clean mobile experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.88),
                    fontSize: 17,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _SplashFeatureCard(label: 'Attendance', value: 'Fast'),
                    _SplashFeatureCard(label: 'Leave', value: 'Simple'),
                    _SplashFeatureCard(label: 'Profile', value: 'Secure'),
                  ],
                ),
                const Spacer(),
                _PrimaryButton(
                  label: 'Sign In',
                  backgroundColor: Colors.white,
                  textColor: CareConnectColors.textPrimary,
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                ),
                const SizedBox(height: 12),
                _PrimaryButton(
                  label: 'Create Account',
                  backgroundColor: const Color(0xFF21C07E),
                  textColor: Colors.white,
                  icon: Icons.arrow_forward_rounded,
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [CareConnectColors.teal, Color(0xFF46C2B3)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(26),
                    bottomRight: Radius.circular(26),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'CARECONNECT',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 4,
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.16),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: const Icon(Icons.health_and_safety_rounded, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Welcome back',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        height: 1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Sign in to manage attendance, leave requests, notifications, and payslips.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 18,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: _SecondaryButton(
                            label: 'Guest User',
                            backgroundColor: Colors.white,
                            textColor: CareConnectColors.textPrimary,
                            onPressed: () => Navigator.pushNamed(context, AppRoutes.home),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SecondaryButton(
                            label: 'Face ID',
                            backgroundColor: const Color(0xFF2BC67B),
                            textColor: Colors.white,
                            onPressed: () => Navigator.pushNamed(context, AppRoutes.home),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    _SectionSurface(
                      child: Row(
                        children: const [
                          Expanded(
                            child: _MetricMiniCard(
                              label: 'TODAY',
                              value: '92%',
                              caption: 'Attendance rate',
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _MetricMiniCard(
                              label: 'TASKS',
                              value: '3',
                              caption: 'Pending approvals',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SectionSurface(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Use your account email and password.',
                            style: TextStyle(fontSize: 16, color: CareConnectColors.textSecondary),
                          ),
                          const SizedBox(height: 16),
                          const _TextFieldCard(
                            hintText: 'Email Address',
                            icon: Icons.mail_outline_rounded,
                          ),
                          const SizedBox(height: 12),
                          const _TextFieldCard(
                            hintText: 'Password',
                            icon: Icons.lock_outline_rounded,
                            obscureText: true,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pushNamed(context, AppRoutes.forgotPassword),
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: CareConnectColors.tealDark,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                                child: const Text(
                                  'Create account',
                                  style: TextStyle(color: CareConnectColors.textSecondary),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _PrimaryButton(
                            label: 'Sign In',
                            onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _ActionPill(
                            label: 'Need Help',
                            icon: Icons.help_outline_rounded,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _PrimaryButton(
                            label: 'Register',
                            icon: Icons.arrow_forward_rounded,
                            onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AuthPageScaffold(
      leadingAction: () => Navigator.pop(context),
      title: 'Create Account',
      subtitle: 'Register with your employee details',
      body: Column(
        children: [
          _SectionSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'JOIN CARECONNECT',
                  style: TextStyle(letterSpacing: 3, color: CareConnectColors.textSecondary),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Register a new employee profile',
                  style: TextStyle(fontSize: 30, height: 1.05, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Fill in your details, choose a branch, and verify your account with OTP.',
                  style: TextStyle(fontSize: 17, height: 1.5, color: CareConnectColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionSurface(
            child: Column(
              children: const [
                _TextFieldCard(hintText: 'Register Code', icon: Icons.key_outlined),
                SizedBox(height: 12),
                _TextFieldCard(hintText: 'Phone Number', icon: Icons.call_outlined),
                SizedBox(height: 12),
                _TextFieldCard(hintText: 'Full Name', icon: Icons.person_outline_rounded),
                SizedBox(height: 12),
                _TextFieldCard(hintText: 'Email Address', icon: Icons.mail_outline_rounded),
                SizedBox(height: 12),
                _TextFieldCard(hintText: 'Main Branch', icon: Icons.apartment_outlined, trailingIcon: Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _PrimaryButton(
            label: 'Register',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.otp),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
            child: const Text(
              'Already have an account? Sign in',
              style: TextStyle(color: CareConnectColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AuthPageScaffold(
      leadingAction: () => Navigator.pop(context),
      title: 'Forgot Password',
      subtitle: 'Reset access to your account',
      body: Column(
        children: [
          const _IconIntroCard(
            icon: Icons.key_rounded,
            title: 'Recover your account',
            subtitle: 'Enter your email address and we’ll send a one-time code to continue.',
          ),
          const SizedBox(height: 18),
          _SectionSurface(
            child: Column(
              children: [
                const _TextFieldCard(hintText: 'Email Address', icon: Icons.mail_outline_rounded),
                const SizedBox(height: 14),
                _PrimaryButton(
                  label: 'Send OTP',
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.otp),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                  child: const Text('Back to Sign In', style: TextStyle(color: CareConnectColors.textSecondary)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AuthPageScaffold(
      leadingAction: () => Navigator.pop(context),
      title: 'OTP Verification',
      subtitle: 'Enter the 6-digit code',
      body: Column(
        children: [
          const _IconIntroCard(
            icon: Icons.verified_user_outlined,
            title: 'Verify your code',
            subtitle: 'We sent a verification code to your phone and email.',
          ),
          const SizedBox(height: 18),
          _SectionSurface(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (_) => const _OtpBox(),
                  ),
                ),
                const SizedBox(height: 18),
                _PrimaryButton(
                  label: 'Verify & Continue',
                  onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Resend Code',
                        style: TextStyle(
                          color: CareConnectColors.tealDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                      child: const Text('Back to Register', style: TextStyle(color: CareConnectColors.textSecondary)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
        child: IndexedStack(
          index: appState.homeTabIndex,
          children: pages,
        ),
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
          padding: _pagePadding.copyWith(bottom: 24),
          child: Column(
            children: [
              _HomeTopBar(
                onMenuTap: () => context.read<AppState>().selectHomeTab(4),
                onNotificationsTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
              ),
              const SizedBox(height: 14),
              _QuickAccessCard(
                onPayslipTap: () => Navigator.pushNamed(context, AppRoutes.payslip),
              ),
              const SizedBox(height: 16),
              _HomeHeroCard(summary: summary),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _MetricMiniCard(
                      label: 'Team',
                      value: '${summary.teamMembers}',
                      caption: 'Members',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MetricMiniCard(
                      label: 'Pending',
                      value: '${summary.pendingApprovals}',
                      caption: 'Approvals',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MetricMiniCard(
                      label: 'Net Pay',
                      value: 'SAR\n8,450',
                      caption: 'March 2025',
                      valueColor: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _StatusBanner(
                label: 'TODAY',
                title: 'Checked in at ${summary.checkInTime}',
                trailing: Icons.verified_rounded,
              ),
            ],
          ),
        );
      },
    );
  }
}

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StandalonePageShell(
      title: 'Employees',
      subtitle: 'Team directory',
      trailingBadge: '24',
      child: EmployeesDirectoryContent(),
    );
  }
}

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = context.read<CareConnectApi>();
    return _StandalonePageShell(
      title: 'Employee Details',
      subtitle: 'Profile overview',
      leadingAction: () => Navigator.pop(context),
      child: FutureBuilder<EmployeeProfile>(
        future: api.fetchEmployeeProfile(),
        builder: (context, snapshot) {
          final profile = snapshot.data ?? employeeProfile;
          return Column(
            children: [
              _SectionSurface(
                child: Column(
                  children: [
                    Container(
                      width: 112,
                      height: 112,
                      decoration: const BoxDecoration(
                        color: CareConnectColors.tealLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person_outline_rounded, size: 58, color: CareConnectColors.teal),
                    ),
                    const SizedBox(height: 16),
                    Text(profile.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text(profile.role, style: const TextStyle(fontSize: 18, color: CareConnectColors.textSecondary)),
                    const SizedBox(height: 10),
                    Text('ID: ${profile.employeeId}', style: const TextStyle(fontSize: 16, color: CareConnectColors.textSecondary)),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _SectionSurface(
                child: Column(
                  children: [
                    _InfoRow(label: 'Email', value: profile.email),
                    const _RowDivider(),
                    _InfoRow(label: 'Phone', value: profile.phone),
                    const _RowDivider(),
                    _InfoRow(label: 'Department', value: profile.department),
                    const _RowDivider(),
                    _InfoRow(label: 'Join Date', value: profile.joinDate),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StandalonePageShell(
      title: 'Attendance',
      subtitle: 'March 2025',
      trailingBadge: '92%',
      child: AttendanceContent(),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = context.read<CareConnectApi>();
    return _StandalonePageShell(
      title: 'Notifications',
      subtitle: 'Recent alerts and updates',
      trailingBadge: '4 New',
      child: FutureBuilder<List<NotificationItem>>(
        future: api.fetchNotifications(),
        builder: (context, snapshot) {
          final items = snapshot.data ?? notifications;
          return Column(
            children: [
              _SectionSurface(
                child: Row(
                  children: const [
                    Expanded(child: _MetricMiniCard(label: 'UNREAD', value: '4', caption: '')),
                    SizedBox(width: 12),
                    Expanded(child: _MetricMiniCard(label: 'TODAY', value: '7', caption: '')),
                    SizedBox(width: 12),
                    Expanded(child: _MetricMiniCard(label: 'ALERTS', value: '2', caption: '')),
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
              _SectionSurface(
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
          );
        },
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return _StandalonePageShell(
      title: 'Settings',
      subtitle: 'Language and appearance',
      trailingBadge: 'Saved',
      child: Column(
        children: [
          _SectionSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Language', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _ChoicePill(
                        label: 'EN',
                        icon: Icons.translate_rounded,
                        selected: !appState.isArabic,
                        onTap: () => context.read<AppState>().setLanguage(CareConnectLanguage.english),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ChoicePill(
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
          _SectionSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Theme Mode', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _ChoicePill(
                        label: 'Light',
                        icon: Icons.wb_sunny_outlined,
                        selected: !appState.isDarkMode,
                        onTap: () => context.read<AppState>().setTheme(false),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ChoicePill(
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
          _SectionSurface(
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

class PayslipScreen extends StatelessWidget {
  const PayslipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = context.read<CareConnectApi>();
    return _StandalonePageShell(
      title: 'Payslip',
      subtitle: 'March 2025',
      trailingBadge: 'SAR 8,450',
      child: FutureBuilder<PayslipSummary>(
        future: api.fetchPayslipSummary(),
        builder: (context, snapshot) {
          final payslip = snapshot.data ?? payslipSummary;
          return Column(
            children: [
              _PayslipHeroCard(summary: payslip),
              const SizedBox(height: 18),
              Row(
                children: const [
                  Expanded(child: _PayslipTotalCard(label: 'Basic', value: 'SAR\n6,000', caption: 'Salary')),
                  SizedBox(width: 12),
                  Expanded(child: _PayslipTotalCard(label: 'Net Pay', value: 'SAR\n8,450', caption: 'March 2025', valueColor: Colors.green)),
                ],
              ),
              const SizedBox(height: 18),
              _SectionSurface(
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
              _PrimaryButton(
                label: 'Download Payslip',
                icon: Icons.download_rounded,
                onPressed: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _StandalonePageShell(
      title: 'My Profile',
      subtitle: 'Account settings',
      child: const ProfileContent(),
    );
  }
}

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _StandalonePageShell(
      title: 'Leave Management',
      subtitle: 'Leave balance and requests',
      child: const LeaveContent(),
    );
  }
}

class EmployeesDirectoryContent extends StatelessWidget {
  const EmployeesDirectoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final api = context.read<CareConnectApi>();
    return FutureBuilder<List<EmployeeSummary>>(
      future: api.fetchEmployees(),
      builder: (context, snapshot) {
        final employees = snapshot.data ?? employeeDirectory;
        return SingleChildScrollView(
          padding: _pagePadding.copyWith(bottom: 24),
          child: Column(
            children: [
              _SimpleHeader(
                title: 'Employees',
                subtitle: 'Team directory',
                trailingBadge: '${employees.length}',
              ),
              const SizedBox(height: 18),
              const _SearchBar(hintText: 'Search employees...'),
              const SizedBox(height: 16),
              _SectionSurface(
                child: Column(
                  children: [
                    for (final employee in employees) ...[
                      _EmployeeListCard(
                        employee: employee,
                        onTap: () => Navigator.pushNamed(context, AppRoutes.employeeDetails),
                      ),
                      if (employee != employees.last) const SizedBox(height: 12),
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

class AttendanceContent extends StatelessWidget {
  const AttendanceContent({super.key});

  @override
  Widget build(BuildContext context) {
    final records = attendanceRecords;
    return SingleChildScrollView(
      padding: _pagePadding.copyWith(bottom: 24),
      child: Column(
        children: [
          _SimpleHeader(
            title: 'Attendance',
            subtitle: 'March 2025',
            trailingBadge: '92%',
          ),
          const SizedBox(height: 18),
          _StatusOutlineCard(
            title: 'Today - Present',
            subtitle: 'Check In: 8:30 AM | Check Out: (Pending)',
          ),
          const SizedBox(height: 18),
          const Row(
            children: [
              Expanded(child: _MetricMiniCard(label: 'Present', value: '22', caption: '')),
              SizedBox(width: 12),
              Expanded(child: _MetricMiniCard(label: 'Absent', value: '1', caption: '', valueColor: Color(0xFFE13A35))),
              SizedBox(width: 12),
              Expanded(child: _MetricMiniCard(label: 'Rate', value: '92%', caption: '')),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _PrimaryButton(
                  label: 'Check In',
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SecondaryActionButton(
                  label: 'Check Out',
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SectionSurface(
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

class LeaveContent extends StatelessWidget {
  const LeaveContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: _pagePadding.copyWith(bottom: 24),
      child: Column(
        children: [
          const _SimpleHeader(
            title: 'Leave Management',
            subtitle: 'Leave balance and requests',
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              Expanded(child: _MetricMiniCard(label: 'Available', value: '5', caption: 'days')),
              SizedBox(width: 12),
              Expanded(child: _MetricMiniCard(label: 'Used', value: '10', caption: 'days', valueColor: Color(0xFFF0A61A))),
            ],
          ),
          const SizedBox(height: 16),
          _PrimaryButton(
            label: 'Request New Leave',
            icon: Icons.calendar_month_outlined,
            onPressed: () {},
          ),
          const SizedBox(height: 18),
          _SectionSurface(
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

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = employeeProfile;
    return SingleChildScrollView(
      padding: _pagePadding.copyWith(bottom: 24),
      child: Column(
        children: [
          const _SimpleHeader(
            title: 'My Profile',
            subtitle: 'Account settings',
          ),
          const SizedBox(height: 18),
          _SectionSurface(
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(color: CareConnectColors.tealLight, shape: BoxShape.circle),
                  child: const Icon(Icons.person_outline_rounded, size: 60, color: CareConnectColors.teal),
                ),
                const SizedBox(height: 18),
                Text(profile.name, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                const Text('Senior Manager', style: TextStyle(fontSize: 18, color: CareConnectColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionSurface(
            child: Column(
              children: const [
                _InfoRow(label: 'Employee ID', value: 'EMP001'),
                _RowDivider(),
                _InfoRow(label: 'Email', value: 'ahmed@company.com'),
                _RowDivider(),
                _InfoRow(label: 'Department', value: 'Human Resources'),
                _RowDivider(),
                _InfoRow(label: 'Manager', value: 'Riyad Solutions'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) => const HomeDashboardContent();
}

class _AuthPageScaffold extends StatelessWidget {
  const _AuthPageScaffold({
    required this.title,
    required this.subtitle,
    required this.body,
    required this.leadingAction,
  });

  final String title;
  final String subtitle;
  final Widget body;
  final VoidCallback leadingAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: _pagePadding.copyWith(bottom: 24),
          child: Column(
            children: [
              Row(
                children: [
                  _HeaderCircleButton(icon: Icons.arrow_back_rounded, onTap: leadingAction),
                  const Spacer(),
                  Column(
                    children: [
                      Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text(subtitle, style: const TextStyle(fontSize: 17, color: CareConnectColors.textSecondary)),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 14),
              const _HeaderAccentLine(),
              const SizedBox(height: 18),
              body,
            ],
          ),
        ),
      ),
    );
  }
}

class _StandalonePageShell extends StatelessWidget {
  const _StandalonePageShell({
    required this.title,
    required this.subtitle,
    required this.child,
    this.trailingBadge,
    this.leadingAction,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final String? trailingBadge;
  final VoidCallback? leadingAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CareConnectColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: _pagePadding.copyWith(bottom: 24),
          child: Column(
            children: [
              _SimpleHeader(
                title: title,
                subtitle: subtitle,
                trailingBadge: trailingBadge,
                leadingAction: leadingAction,
              ),
              const SizedBox(height: 18),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _SimpleHeader extends StatelessWidget {
  const _SimpleHeader({
    required this.title,
    required this.subtitle,
    this.trailingBadge,
    this.leadingAction,
  });

  final String title;
  final String subtitle;
  final String? trailingBadge;
  final VoidCallback? leadingAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (leadingAction != null)
              _HeaderCircleButton(
                icon: Icons.arrow_back_rounded,
                onTap: leadingAction!,
              )
            else
              const SizedBox(width: 54),
            const Spacer(),
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 31, fontWeight: FontWeight.w800, height: 1),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 18, color: CareConnectColors.textSecondary),
                ),
              ],
            ),
            const Spacer(),
            if (trailingBadge != null)
              _BadgePill(label: trailingBadge!)
            else
              const SizedBox(width: 54),
          ],
        ),
        const SizedBox(height: 14),
        const _HeaderAccentLine(),
        const SizedBox(height: 18),
      ],
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
        _HeaderCircleButton(icon: Icons.menu_rounded, onTap: onMenuTap),
        const SizedBox(width: 14),
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: _surfaceShadow,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CARECONNECT',
                style: TextStyle(letterSpacing: 4, fontSize: 11, color: CareConnectColors.textSecondary),
              ),
              SizedBox(height: 4),
              Text(
                'Welcome Back',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        _HeaderCircleButton(
          icon: Icons.notifications_none_rounded,
          onTap: onNotificationsTap,
          badge: true,
        ),
      ],
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  const _QuickAccessCard({required this.onPayslipTap});

  final VoidCallback onPayslipTap;

  @override
  Widget build(BuildContext context) {
    return _SectionSurface(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Quick access to your daily tools',
              style: TextStyle(fontSize: 17, color: CareConnectColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: onPayslipTap,
            child: const Text(
              'Payslip',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: CareConnectColors.tealDark),
            ),
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
    return _SectionSurface(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: CareConnectColors.teal,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'CARECONNECT',
                  style: TextStyle(letterSpacing: 4, fontSize: 12, color: Colors.white70),
                ),
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
              style: const TextStyle(
                fontSize: 34,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                height: 1.02,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              '3 approvals and 1 leave request waiting.',
              style: TextStyle(fontSize: 17, color: Colors.white, height: 1.45),
            ),
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
                  const Text(
                    '24 employees • 1 runs',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: _PrimarySurfaceButton(
                    label: 'Attendance',
                    backgroundColor: Colors.white,
                    textColor: CareConnectColors.textPrimary,
                    onPressed: () => context.read<AppState>().selectHomeTab(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _PrimarySurfaceButton(
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

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.label, required this.title, required this.trailing});

  final String label;
  final String title;
  final IconData trailing;

  @override
  Widget build(BuildContext context) {
    return _SectionSurface(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  letterSpacing: 4,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: CareConnectColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            ],
          ),
          const Spacer(),
          Icon(trailing, color: CareConnectColors.teal, size: 34),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: _surfaceShadow,
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_rounded, color: CareConnectColors.textSecondary),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _EmployeeListCard extends StatelessWidget {
  const _EmployeeListCard({required this.employee, required this.onTap});

  final EmployeeSummary employee;
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
          boxShadow: _surfaceShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: CareConnectColors.tealLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.groups_outlined, color: CareConnectColors.teal),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(employee.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text('${employee.department} - ID: ${employee.employeeId}', style: const TextStyle(fontSize: 15, color: CareConnectColors.textSecondary)),
                ],
              ),
            ),
            _BadgePill(label: employee.status),
          ],
        ),
      ),
    );
  }
}

class _StatusOutlineCard extends StatelessWidget {
  const _StatusOutlineCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE9FAF5),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: CareConnectColors.teal, width: 1.6),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline_rounded, color: CareConnectColors.teal, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(subtitle, style: const TextStyle(fontSize: 17, color: CareConnectColors.textSecondary)),
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
        _BadgePill(
          label: record.status,
          backgroundColor: isAbsent ? const Color(0xFFF8DFE0) : const Color(0xFFE4F8EC),
          textColor: isAbsent ? const Color(0xFFE15A58) : const Color(0xFF49B673),
        ),
      ],
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
        _BadgePill(label: entry.status, backgroundColor: const Color(0xFFE2FAE9), textColor: const Color(0xFF58B873)),
      ],
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
        boxShadow: _surfaceShadow,
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
          _BadgePill(label: item.badge),
        ],
      ),
    );
  }
}

class _PayslipHeroCard extends StatelessWidget {
  const _PayslipHeroCard({required this.summary});

  final PayslipSummary summary;

  @override
  Widget build(BuildContext context) {
    return _SectionSurface(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: CareConnectColors.teal,
          borderRadius: BorderRadius.circular(24),
        ),
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
    return _SectionSurface(
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 18, color: CareConnectColors.textSecondary)),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: CareConnectColors.border);
  }
}

class _HeaderAccentLine extends StatelessWidget {
  const _HeaderAccentLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 4,
      decoration: BoxDecoration(color: CareConnectColors.teal, borderRadius: BorderRadius.circular(8)),
    );
  }
}

class _BadgePill extends StatelessWidget {
  const _BadgePill({required this.label, this.backgroundColor, this.textColor});

  final String label;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFEAF7F1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor ?? CareConnectColors.teal,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
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
    final background = selected ? const Color(0xFFE4F6F2) : accent?.withValues(alpha: 0.28) ?? const Color(0xFFF2F5F8);
    final textColor = selected ? CareConnectColors.tealDark : accent ?? CareConnectColors.textSecondary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w600)),
    );
  }
}

class _ChoicePill extends StatelessWidget {
  const _ChoicePill({required this.label, required this.icon, required this.selected, required this.onTap});

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 62,
        decoration: BoxDecoration(
          color: selected ? CareConnectColors.teal : const Color(0xFFF1F5FA),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? Colors.white : CareConnectColors.textPrimary, size: 22),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: selected ? Colors.white : CareConnectColors.textPrimary, fontSize: 22)),
          ],
        ),
      ),
    );
  }
}

class _MetricMiniCard extends StatelessWidget {
  const _MetricMiniCard({
    required this.label,
    required this.value,
    required this.caption,
    this.valueColor,
    this.labelColor,
  });

  final String label;
  final String value;
  final String caption;
  final Color? valueColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: _surfaceShadow,
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: labelColor ?? CareConnectColors.textSecondary)),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              height: 1.0,
              fontWeight: FontWeight.w800,
              color: valueColor ?? CareConnectColors.tealDark,
            ),
          ),
          if (caption.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(caption, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: CareConnectColors.textSecondary)),
          ],
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
          boxShadow: _surfaceShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(color: CareConnectColors.tealLight, shape: BoxShape.circle),
              child: Icon(icon, color: CareConnectColors.teal),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 15, color: CareConnectColors.textSecondary)),
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

class _TextFieldCard extends StatelessWidget {
  const _TextFieldCard({required this.hintText, required this.icon, this.trailingIcon, this.obscureText = false});

  final String hintText;
  final IconData icon;
  final IconData? trailingIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: CareConnectColors.textSecondary),
        suffixIcon: trailingIcon == null ? null : Icon(trailingIcon, color: CareConnectColors.textSecondary),
      ),
    );
  }
}

class _IconIntroCard extends StatelessWidget {
  const _IconIntroCard({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return _SectionSurface(
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(color: CareConnectColors.tealLight, shape: BoxShape.circle),
            child: Icon(icon, color: CareConnectColors.teal, size: 36),
          ),
          const SizedBox(height: 18),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17, height: 1.45, color: CareConnectColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CareConnectColors.border),
        boxShadow: _surfaceShadow,
      ),
    );
  }
}

class _SplashFeatureCard extends StatelessWidget {
  const _SplashFeatureCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 98,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(0.18)),
      ),
      child: Column(
        children: [
          Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _SectionSurface extends StatelessWidget {
  const _SectionSurface({required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: _surfaceShadow,
      ),
      child: child,
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.backgroundColor = CareConnectColors.teal,
    this.textColor = Colors.white,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _PrimarySurfaceButton extends StatelessWidget {
  const _PrimarySurfaceButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor = CareConnectColors.teal,
    this.textColor = Colors.white,
  });

  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
  });

  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: Text(label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  const _SecondaryActionButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: CareConnectColors.textPrimary,
          side: const BorderSide(color: CareConnectColors.border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        child: Text(label, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({required this.label, required this.icon, required this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        backgroundColor: Colors.white,
        foregroundColor: CareConnectColors.textPrimary,
        side: const BorderSide(color: CareConnectColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      icon: Icon(icon, size: 20),
      label: Text(label, style: const TextStyle(fontSize: 17)),
    );
  }
}

class _HeaderCircleButton extends StatelessWidget {
  const _HeaderCircleButton({required this.icon, required this.onTap, this.badge = false});

  final IconData icon;
  final VoidCallback onTap;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F5F4),
              shape: BoxShape.circle,
              boxShadow: _surfaceShadow,
            ),
            child: Icon(icon, color: CareConnectColors.teal, size: 26),
          ),
        ),
        if (badge)
          Positioned(
            right: 3,
            top: 3,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(color: Color(0xFFE25C5A), shape: BoxShape.circle),
            ),
          ),
      ],
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
