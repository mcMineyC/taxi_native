import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_native/helpers/constants.dart';
import 'package:taxi_native/helpers/widgets/helper_widgets.dart';
import "package:taxi_native/providers/data/info_provider.dart";
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdateChecker extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<String> latestVersion = ref.watch(latestVersionProvider);
    String currentVersion = kVersionString;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Current: ${currentVersion}"),
        latestVersion.when(
          data: (data) => Text("Latest: ${data}"),
          loading: () => Text("Latest: Loading..."),
          error: (_, __) => Text("Error"),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => ref.refresh(latestVersionProvider),
              icon: Icon(Icons.refresh_rounded)
            ),
            latestVersion.when(
              data: (latest) => latest == currentVersion ? FilledButton.icon(
                onPressed: () {
                  launchUrlString(kRepoUrl + "/versions/latest");
                },
                icon: Icon(Icons.cloud_upload_outlined),
                label: Text("Update"),
              ) : SpacerWidget(width: 32),
              error: (_, __) => SpacerWidget(width: 32),
              loading: () => SpacerWidget(width: 32),
            )
          ],
        )
      ],
    );
  }
}