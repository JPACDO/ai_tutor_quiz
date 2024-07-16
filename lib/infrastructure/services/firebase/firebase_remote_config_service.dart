import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;
  static FirebaseRemoteConfigService? _instance; // NEW

  FirebaseRemoteConfigService._()
      : _remoteConfig = FirebaseRemoteConfig.instance; // MODIFIED

  factory FirebaseRemoteConfigService() =>
      _instance ??= FirebaseRemoteConfigService._(); // NEW

  String getString(String key) => _remoteConfig.getString(key); // NEW
  bool getBool(String key) => _remoteConfig.getBool(key); // NEW
  int getInt(String key) => _remoteConfig.getInt(key); // NEW
  double getDouble(String key) => _remoteConfig.getDouble(key); // NEW

  // Inicializar Firebase Remote Config con valores predeterminados
  Future<void> initialize() async {
    try {
      // await _remoteConfig.ensureInitialized();
      await _remoteConfig.setDefaults(const <String, dynamic>{
        FirebaseRemoteConfigKeys.updateMessage:
            'Please update to the latest version of the app.',
        FirebaseRemoteConfigKeys.requiredMinimumVersion: '1.0.0',
        FirebaseRemoteConfigKeys.recommendedMinimumVersion: '1.0.0',
        FirebaseRemoteConfigKeys.urlUpdate: '@',
        FirebaseRemoteConfigKeys.projectSinAds: 3,
        FirebaseRemoteConfigKeys.showAds: true,
        // Define otros valores predeterminados aquí
      });

      await fetchAndActivate();
    } catch (e, stackTrace) {
      await FirebaseCrashlytics.instance
          .recordError(e, stackTrace, reason: 'a non-fatal error RemoteConfig');
    }
  }

  // Obtener los parámetros de configuración remota
  Future<void> fetchAndActivate() async {
    try {
      // Usar valores predeterminados en modo de depuración para evitar límites de frecuencia
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: const Duration(hours: 12),
      ));
      bool updated = await _remoteConfig.fetchAndActivate();
      _remoteConfig.onConfigUpdated.listen((event) async {
        await _remoteConfig.activate();

        // Use the new config values here.
      });
      if (updated) {
        debugPrint('The config has been updated.');
      } else {
        debugPrint('The config is not updated..');
      }
    } catch (e) {
      debugPrint('Unable to fetch remote config. Default values will be used');
    }
  }

  String get updateMessage =>
      _remoteConfig.getString(FirebaseRemoteConfigKeys.updateMessage); // NEW

  String get urlUpdate =>
      _remoteConfig.getString(FirebaseRemoteConfigKeys.urlUpdate); // NEW

  int get projectSinAds =>
      _remoteConfig.getInt(FirebaseRemoteConfigKeys.projectSinAds); // NEW

  bool get showAds =>
      _remoteConfig.getBool(FirebaseRemoteConfigKeys.showAds); // NEW

  // Helper methods to simplify using the values in other parts of the code
  String getRequiredMinimumVersion() =>
      _remoteConfig.getString('requiredMinimumVersion');

  String getRecommendedMinimumVersion() =>
      _remoteConfig.getString('recommendedMinimumVersion');
}

class FirebaseRemoteConfigKeys {
  //define como se llaman las variales en firebase
  static const String updateMessage = 'update_message';
  static const String requiredMinimumVersion = 'requiredMinimumVersion';
  static const String recommendedMinimumVersion = 'recommendedMinimumVersion';
  static const String urlUpdate = 'url_update';
  static const String projectSinAds = 'projectSinAds';
  static const String showAds = 'showAds';
}
