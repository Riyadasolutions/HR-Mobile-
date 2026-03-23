import 'package:flutter/material.dart';

import '../../../data/careconnect_models.dart';
import '../../../shared/widgets/careconnect_shells.dart';
import '../../../theme/careconnect_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileContent();
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = employeeProfile;
    return StandalonePageScaffold(
      title: 'My Profile',
      subtitle: 'Account settings',
      child: Column(
        children: [
          SectionSurface(
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
          SectionSurface(
            child: Column(
              children: const [
                InfoRow(label: 'Employee ID', value: 'EMP001'),
                RowDivider(),
                InfoRow(label: 'Email', value: 'ahmed@company.com'),
                RowDivider(),
                InfoRow(label: 'Department', value: 'Human Resources'),
                RowDivider(),
                InfoRow(label: 'Manager', value: 'Riyad Solutions'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
