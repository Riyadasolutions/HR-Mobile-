import 'package:package_info_plus/package_info_plus.dart';

class AppVersion{
  static Future<String> get() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}