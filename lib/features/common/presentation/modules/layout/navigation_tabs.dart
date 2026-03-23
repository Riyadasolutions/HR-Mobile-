
import 'package:base_app/core/utils/navigation_tab_data.dart';
import 'package:base_app/features/attendance/presentation/attendance_screen.dart';
import 'package:base_app/features/employees/presentation/employees_screens.dart';
import 'package:base_app/features/home/presentation/home_screen.dart';
import 'package:base_app/features/leave/presentation/leave_screen.dart';
import 'package:base_app/features/profile/presentation/profile_screen.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';


class _NavigationTabs {
  /// Default constructor is private because this class will be only used for
  /// static fields and you should not instantiate it.
  _NavigationTabs._();

  static const booking  = 0;
  static const services = 1;
  // static const offers = 1;
  static const home = 2;
  static const hotels = 3 ;
  static const more  =4 ;

}
//       const HomeDashboardContent(),
//       const EmployeesDirectoryContent(),
//       const AttendanceContent(),
//       const LeaveContent(),
//       const ProfileContent(),
const List<NavigationTabData> kUserTabs = <NavigationTabData>[
  NavigationTabData(
    title: LocaleKeys.myBookings,
    icon: Assets.iconsNavBookingIcon,
    initialRoute: HomeDashboardContent(),
    index: _NavigationTabs.booking,
  ),
  NavigationTabData(
    title: LocaleKeys.services,
    icon: Assets.iconsNavServicesIcon,
    initialRoute: EmployeesDirectoryContent(),
    index: _NavigationTabs.services,
  ),


  NavigationTabData(
    title: LocaleKeys.hotels,
    icon: Assets.iconsNavNewsIcon,
    initialRoute: AttendanceContent(),
    // initialRoute: NewsScreen(),
    index: _NavigationTabs.hotels,
  ),
  NavigationTabData(
    title: LocaleKeys.more,
    icon: Assets.iconsNavProfileIcon,
    initialRoute: LeaveContent(),
    index: _NavigationTabs.more,
  ),


  NavigationTabData(
    title:'',
    icon: Assets.iconsNavHomeIcon,
    initialRoute: ProfileContent(),
    index: _NavigationTabs.home,
  ),
];
