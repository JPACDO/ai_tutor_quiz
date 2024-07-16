import 'package:package_info_plus/package_info_plus.dart';

class AppVersionPackageInfo {
  static late String version;

  Future<void> initialize() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }
}
