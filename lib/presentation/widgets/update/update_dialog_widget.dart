import 'dart:io';

import 'package:ai_tutor_quiz/infrastructure/services/firebase/firebase_remote_config_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> showUpdateVersionDialog(
    BuildContext context, bool isSkippable) async {
  final String remoteconfig = FirebaseRemoteConfigService().urlUpdate;
  final String msgUpdate = FirebaseRemoteConfigService().updateMessage;

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("New version available"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(msgUpdate),
            ],
          ),
        ),
        actions: <Widget>[
          // A "skip" button is only shown if it's a recommended upgrade
          isSkippable
              ? TextButton(
                  child: const Text('Skip'),
                  onPressed: () {
                    context.go('/home/0');
                  },
                )
              : Container(),
          (remoteconfig != "@")
              ? TextButton(
                  child: const Text('Update'),
                  onPressed: () {
                    _launchAppOrPlayStore(remoteconfig);
                  },
                )
              : Container(),
        ],
      );
    },
  );
}

void _launchAppOrPlayStore(String remoteconfig) {
  Uri url;

  if (remoteconfig != "#") {
    url = Uri.parse(remoteconfig);
  } else {
    final appId =
        Platform.isAndroid ? 'com.aplayt.ai_tutor_quiz' : 'YOUR_IOS_APP_ID';
    url = Uri.parse(
      Platform.isAndroid
          ? "https://play.google.com/store/apps/details?id=$appId" //"market://details?id=$appId"
          : "https://apps.apple.com/app/id$appId",
    );
  }

  launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  );
}
