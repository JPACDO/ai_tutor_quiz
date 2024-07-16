import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_tutor_quiz/infrastructure/services/services.dart';
import 'package:ai_tutor_quiz/presentation/widgets/widgets.dart';

class ForceUpgradePage extends StatefulWidget {
  const ForceUpgradePage({super.key});

  @override
  State<ForceUpgradePage> createState() => _ForceUpgradeState();
}

class _ForceUpgradeState extends State<ForceUpgradePage> {
  // Get the necessary classes using get_it
  final packageInfo = AppVersionPackageInfo.version;
  final featureFlagRepository = FirebaseRemoteConfigService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get the current app version
      var appVersion = _getExtendedVersionNumber(packageInfo);

      // Get the required min version from Firebase Remote Config
      var requiredMinVersion = _getExtendedVersionNumber(
          featureFlagRepository.getRequiredMinimumVersion());

      // Get the recommended min version from Firebase Remote Config
      var recommendedMinVersion = _getExtendedVersionNumber(
          featureFlagRepository.getRecommendedMinimumVersion());

      // Compare the versions and display a dialog if the app version is lower than
      // the required or recommended version
      if (appVersion < requiredMinVersion) {
        showUpdateVersionDialog(context, false);
      } else if (appVersion < recommendedMinVersion) {
        showUpdateVersionDialog(context, true);
      } else {
        // If the current version is higher than the required and recommended version, navgiate to the next Page - in this case the LoginPage()
        context.go('/home/0');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  // Helper method to compare two semver versions.
  int _getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }
}
