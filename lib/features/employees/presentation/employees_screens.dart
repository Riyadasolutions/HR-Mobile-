import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_routes.dart';
import '../../../data/careconnect_api.dart';
import '../../../data/careconnect_models.dart';
import '../../../shared/widgets/careconnect_shells.dart';
import '../../../theme/careconnect_theme.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmployeesDirectoryContent();
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
        return StandalonePageScaffold(
          title: 'Employees',
          subtitle: 'Team directory',
          trailingBadge: '${employees.length}',
          child: Column(
            children: [
              const SearchField(hintText: 'Search employees...'),
              const SizedBox(height: 16),
              SectionSurface(
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

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = context.read<CareConnectApi>();
    return FutureBuilder<EmployeeProfile>(
      future: api.fetchEmployeeProfile(),
      builder: (context, snapshot) {
        final profile = snapshot.data ?? employeeProfile;
        return StandalonePageScaffold(
          title: 'Employee Details',
          subtitle: 'Profile overview',
          onBack: () => Navigator.pop(context),
          child: Column(
            children: [
              SectionSurface(
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
              SectionSurface(
                child: Column(
                  children: [
                    InfoRow(label: 'Email', value: profile.email),
                    const RowDivider(),
                    InfoRow(label: 'Phone', value: profile.phone),
                    const RowDivider(),
                    InfoRow(label: 'Department', value: profile.department),
                    const RowDivider(),
                    InfoRow(label: 'Join Date', value: profile.joinDate),
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
          boxShadow: careConnectSurfaceShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(color: CareConnectColors.tealLight, shape: BoxShape.circle),
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
            BadgePill(label: employee.status),
          ],
        ),
      ),
    );
  }
}
