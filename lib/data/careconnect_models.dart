import 'package:flutter/material.dart';

class DashboardSummary {
  const DashboardSummary({
    required this.userName,
    required this.role,
    required this.employeeId,
    required this.department,
    required this.monthLabel,
    required this.teamMembers,
    required this.pendingApprovals,
    required this.netPay,
    required this.attendanceRate,
    required this.checkInTime,
  });

  final String userName;
  final String role;
  final String employeeId;
  final String department;
  final String monthLabel;
  final int teamMembers;
  final int pendingApprovals;
  final String netPay;
  final int attendanceRate;
  final String checkInTime;
}

class EmployeeSummary {
  const EmployeeSummary({
    required this.name,
    required this.department,
    required this.employeeId,
    required this.status,
  });

  final String name;
  final String department;
  final String employeeId;
  final String status;
}

class EmployeeProfile {
  const EmployeeProfile({
    required this.name,
    required this.role,
    required this.employeeId,
    required this.email,
    required this.phone,
    required this.department,
    required this.joinDate,
  });

  final String name;
  final String role;
  final String employeeId;
  final String email;
  final String phone;
  final String department;
  final String joinDate;
}

class AttendanceRecord {
  const AttendanceRecord({required this.date, required this.status});

  final String date;
  final String status;
}

class LeaveEntry {
  const LeaveEntry({required this.title, required this.dateRange, required this.status});

  final String title;
  final String dateRange;
  final String status;
}

class NotificationItem {
  const NotificationItem({
    required this.title,
    required this.message,
    required this.badge,
    required this.icon,
  });

  final String title;
  final String message;
  final String badge;
  final IconData icon;
}

class PayslipBreakdownItem {
  const PayslipBreakdownItem({
    required this.label,
    required this.amount,
    this.isNegative = false,
    this.isNetTotal = false,
  });

  final String label;
  final String amount;
  final bool isNegative;
  final bool isNetTotal;
}

class PayslipSummary {
  const PayslipSummary({
    required this.employeeName,
    required this.role,
    required this.employeeId,
    required this.period,
    required this.paidOn,
    required this.basicSalary,
    required this.netPay,
    required this.breakdown,
  });

  final String employeeName;
  final String role;
  final String employeeId;
  final String period;
  final String paidOn;
  final String basicSalary;
  final String netPay;
  final List<PayslipBreakdownItem> breakdown;
}

const dashboardSummary = DashboardSummary(
  userName: 'Ahmed Sayed',
  role: 'Human Resources',
  employeeId: 'EMP001',
  department: 'CareConnect',
  monthLabel: 'March 2025',
  teamMembers: 24,
  pendingApprovals: 3,
  netPay: 'SAR 8,450',
  attendanceRate: 92,
  checkInTime: '8:30 AM',
);

const employeeDirectory = <EmployeeSummary>[
  EmployeeSummary(name: 'Ahmed Sayed', department: 'HR', employeeId: 'EMP001', status: 'Online'),
  EmployeeSummary(name: 'Fatima Ahmed', department: 'Finance', employeeId: 'EMP002', status: 'Active'),
  EmployeeSummary(name: 'Mohammed Ali', department: 'IT', employeeId: 'EMP003', status: 'Active'),
];

const employeeProfile = EmployeeProfile(
  name: 'Ahmed Sayed',
  role: 'Senior Manager',
  employeeId: 'EMP001',
  email: 'ahmed@company.com',
  phone: '+966 50 1234567',
  department: 'Human Resources',
  joinDate: 'Jan 15, 2022',
);

const attendanceRecords = <AttendanceRecord>[
  AttendanceRecord(date: 'Mar 20', status: 'Present'),
  AttendanceRecord(date: 'Mar 19', status: 'Present'),
  AttendanceRecord(date: 'Mar 18', status: 'Absent'),
];

const leaveHistory = <LeaveEntry>[
  LeaveEntry(title: 'Annual Leave', dateRange: 'Mar 15 - Mar 18, 2025', status: 'Approved'),
  LeaveEntry(title: 'Annual Leave', dateRange: 'Mar 15 - Mar 18, 2025', status: 'Approved'),
];

const notifications = <NotificationItem>[
  NotificationItem(
    title: 'Leave request approved',
    message: 'Ahmed\'s annual leave was approved',
    badge: 'New',
    icon: Icons.notifications_none_rounded,
  ),
  NotificationItem(
    title: 'Payslip is ready',
    message: 'March 2025 payroll slip is available',
    badge: 'View',
    icon: Icons.account_balance_wallet_outlined,
  ),
  NotificationItem(
    title: 'Attendance reminder',
    message: 'Please mark attendance before 9:00 AM',
    badge: 'Soon',
    icon: Icons.schedule_rounded,
  ),
];

const payslipSummary = PayslipSummary(
  employeeName: 'Ahmed Sayed',
  role: 'Human Resources • EMP001',
  employeeId: 'March 2025 Payroll',
  period: 'March 2025',
  paidOn: 'Paid on 28 Mar',
  basicSalary: 'SAR 6,000',
  netPay: 'SAR 8,450',
  breakdown: <PayslipBreakdownItem>[
    PayslipBreakdownItem(label: 'Basic Salary', amount: 'SAR 6,000'),
    PayslipBreakdownItem(label: 'Allowances', amount: 'SAR 0'),
    PayslipBreakdownItem(label: 'Deductions', amount: 'SAR 0', isNegative: true),
    PayslipBreakdownItem(label: 'GOSI', amount: 'SAR 150', isNegative: true),
    PayslipBreakdownItem(label: 'Net Pay', amount: 'SAR 8,450', isNetTotal: true),
  ],
);
