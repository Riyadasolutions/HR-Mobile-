import 'package:flutter/material.dart';

import '../../../core/app_routes.dart';
import '../../../shared/widgets/careconnect_shells.dart';
import '../../../theme/careconnect_theme.dart';

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
                  child: const Icon(Icons.health_and_safety_rounded, color: Colors.white, size: 58),
                ),
                const SizedBox(height: 24),
                const Text(
                  'CareConnect',
                  style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  'HR MOBILE APP',
                  style: TextStyle(color: Colors.white.withOpacity(0.82), letterSpacing: 5, fontSize: 12),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Good Morning, Ahmed',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 38, height: 1.08, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 14),
                Text(
                  'Attendance, leave, employee details, notifications, and payslips in one clean mobile experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.88), fontSize: 17, height: 1.5),
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
                PrimaryButton(
                  label: 'Sign In',
                  backgroundColor: Colors.white,
                  textColor: CareConnectColors.textPrimary,
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
                ),
                const SizedBox(height: 12),
                PrimaryButton(
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
                        const Text('CARECONNECT', style: TextStyle(color: Colors.white, letterSpacing: 4, fontSize: 12)),
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
                    const Text('Welcome back', style: TextStyle(color: Colors.white, fontSize: 40, height: 1, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 14),
                    Text(
                      'Sign in to manage attendance, leave requests, notifications, and payslips.',
                      style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 18, height: 1.45),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            label: 'Guest User',
                            backgroundColor: Colors.white,
                            textColor: CareConnectColors.textPrimary,
                            onPressed: () => Navigator.pushNamed(context, AppRoutes.home),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SecondaryButton(
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
                    SectionSurface(
                      child: const Row(
                        children: [
                          Expanded(
                            child: MetricMiniCard(label: 'TODAY', value: '92%', caption: 'Attendance rate'),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: MetricMiniCard(label: 'TASKS', value: '3', caption: 'Pending approvals'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    SectionSurface(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Sign in', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 8),
                          const Text('Use your account email and password.', style: TextStyle(fontSize: 16, color: CareConnectColors.textSecondary)),
                          const SizedBox(height: 16),
                          const TextFieldCard(hintText: 'Email Address', icon: Icons.mail_outline_rounded),
                          const SizedBox(height: 12),
                          const TextFieldCard(hintText: 'Password', icon: Icons.lock_outline_rounded, obscureText: true),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pushNamed(context, AppRoutes.forgotPassword),
                                child: const Text('Forgot password?', style: TextStyle(color: CareConnectColors.tealDark, fontWeight: FontWeight.w700)),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                                child: const Text('Create account', style: TextStyle(color: CareConnectColors.textSecondary)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          PrimaryButton(
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
                          child: ActionPill(label: 'Need Help', icon: Icons.help_outline_rounded, onTap: () {}),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: PrimaryButton(
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
    return AuthPageScaffold(
      onBack: () => Navigator.pop(context),
      title: 'Create Account',
      subtitle: 'Register with your employee details',
      body: Column(
        children: [
          SectionSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('JOIN CARECONNECT', style: TextStyle(letterSpacing: 3, color: CareConnectColors.textSecondary)),
                SizedBox(height: 12),
                Text('Register a new employee profile', style: TextStyle(fontSize: 30, height: 1.05, fontWeight: FontWeight.w800)),
                SizedBox(height: 12),
                Text('Fill in your details, choose a branch, and verify your account with OTP.', style: TextStyle(fontSize: 17, height: 1.5, color: CareConnectColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SectionSurface(
            child: Column(
              children: const [
                TextFieldCard(hintText: 'Register Code', icon: Icons.key_outlined),
                SizedBox(height: 12),
                TextFieldCard(hintText: 'Phone Number', icon: Icons.call_outlined),
                SizedBox(height: 12),
                TextFieldCard(hintText: 'Full Name', icon: Icons.person_outline_rounded),
                SizedBox(height: 12),
                TextFieldCard(hintText: 'Email Address', icon: Icons.mail_outline_rounded),
                SizedBox(height: 12),
                TextFieldCard(hintText: 'Main Branch', icon: Icons.apartment_outlined, trailingIcon: Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'Register',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.otp),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
            child: const Text('Already have an account? Sign in', style: TextStyle(color: CareConnectColors.textSecondary)),
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
    return AuthPageScaffold(
      onBack: () => Navigator.pop(context),
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
          SectionSurface(
            child: Column(
              children: [
                const TextFieldCard(hintText: 'Email Address', icon: Icons.mail_outline_rounded),
                const SizedBox(height: 14),
                PrimaryButton(
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
    return AuthPageScaffold(
      onBack: () => Navigator.pop(context),
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
          SectionSurface(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (_) => const _OtpBox()),
                ),
                const SizedBox(height: 18),
                PrimaryButton(
                  label: 'Verify & Continue',
                  onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Resend Code', style: TextStyle(color: CareConnectColors.tealDark, fontWeight: FontWeight.w700)),
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

class _IconIntroCard extends StatelessWidget {
  const _IconIntroCard({required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SectionSurface(
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
        boxShadow: careConnectSurfaceShadow,
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
