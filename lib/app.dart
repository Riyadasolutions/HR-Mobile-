import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_routes.dart';
import 'data/careconnect_api.dart';
import 'features/attendance/presentation/attendance_screen.dart';
import 'features/auth/presentation/auth_screens.dart';
import 'features/employees/presentation/employees_screens.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/leave/presentation/leave_screen.dart';
import 'features/notifications/presentation/notifications_screen.dart';
import 'features/payslip/presentation/payslip_screen.dart';
import 'features/profile/presentation/profile_screen.dart';
import 'features/settings/presentation/settings_screen.dart';
import 'state/app_state.dart';
import 'theme/careconnect_theme.dart';

class CareConnectApp extends StatelessWidget {
  const CareConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        Provider<Dio>(
          create: (_) => Dio(
            BaseOptions(
              baseUrl: 'https://careconnect.example',
              connectTimeout: const Duration(seconds: 3),
              receiveTimeout: const Duration(seconds: 3),
            ),
          ),
        ),
        Provider<CareConnectApi>(
          create: (context) => CareConnectApi(context.read<Dio>()),
        ),
      ],
      child: Consumer<AppState>(
        builder: (context, appState, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CareConnect',
            themeMode: appState.themeMode,
            theme: buildLightTheme(),
            darkTheme: buildDarkTheme(),
            initialRoute: AppRoutes.splash,
            routes: {
              AppRoutes.splash: (_) => const SplashScreen(),
              AppRoutes.login: (_) => const LoginScreen(),
              AppRoutes.register: (_) => const RegisterScreen(),
              AppRoutes.forgotPassword: (_) => const ForgotPasswordScreen(),
              AppRoutes.otp: (_) => const OtpScreen(),
              AppRoutes.home: (_) => const HomeShell(),
              AppRoutes.employees: (_) => const EmployeesScreen(),
              AppRoutes.employeeDetails: (_) => const EmployeeDetailsScreen(),
              AppRoutes.attendance: (_) => const AttendanceScreen(),
              AppRoutes.notifications: (_) => const NotificationsScreen(),
              AppRoutes.settings: (_) => const SettingsScreen(),
              AppRoutes.payslip: (_) => const PayslipScreen(),
              AppRoutes.profile: (_) => const ProfileScreen(),
              AppRoutes.leave: (_) => const LeaveScreen(),
            },
            builder: (context, child) {
              return Directionality(
                textDirection:
                    appState.isArabic ? TextDirection.rtl : TextDirection.ltr,
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
