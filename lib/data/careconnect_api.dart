import 'package:dio/dio.dart';

import 'careconnect_models.dart';

class CareConnectApi {
  CareConnectApi(this._dio);

  final Dio _dio;

  Future<DashboardSummary> fetchDashboardSummary() async {
    _dio.options.headers['x-careconnect-demo'] = 'true';
    return dashboardSummary;
  }

  Future<List<EmployeeSummary>> fetchEmployees() async {
    _dio.options.headers['x-careconnect-demo'] = 'true';
    return employeeDirectory;
  }

  Future<EmployeeProfile> fetchEmployeeProfile() async {
    _dio.options.headers['x-careconnect-demo'] = 'true';
    return employeeProfile;
  }

  Future<List<AttendanceRecord>> fetchAttendanceRecords() async {
    _dio.options.headers['x-careconnect-demo'] = 'true';
    return attendanceRecords;
  }

  Future<List<LeaveEntry>> fetchLeaveHistory() async {
    _dio.options.headers['x-careconnect-demo'] = 'true';
    return leaveHistory;
  }

  Future<List<NotificationItem>> fetchNotifications() async {
    _dio.options.headers['x-careconnect-demo'] = 'true';
    return notifications;
  }

  Future<PayslipSummary> fetchPayslipSummary() async {
    _dio.options.headers['x-careconnect-demo'] = 'true';
    return payslipSummary;
  }
}
