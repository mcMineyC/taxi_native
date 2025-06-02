import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_native/helpers/constants.dart';
import 'package:taxi_native/helpers/utilities.dart';
import 'package:taxi_native/helpers/widgets/helper_widgets.dart';
import "package:taxi_native/providers/data/info_provider.dart";
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdateChecker extends ConsumerStatefulWidget{
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateCheckerState();
}

class _UpdateCheckerState extends ConsumerState<UpdateChecker>{
  @override
  Widget build(BuildContext context) {
    AsyncValue<String> latestVersion = ref.watch(latestVersionProvider);
    latestVersion.when(data: (_) => print("Data"), error: (_, __) => print("Error"), loading: () => print("loading"));
    String currentVersion = kVersionString;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("Current: v${currentVersion}"),
        latestVersion.when(
          data: (data) => Text("Latest: ${data}"),
          loading: () => Text("Latest: Loading..."),
          error: (e, __) => Text("$e"),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => setState(() => ref.refresh(latestVersionProvider)),
              icon: Icon(Icons.refresh_rounded)
            ),
            latestVersion.when(
              data: (latest) => hasNewVersion(latest) ? FilledButton.icon(
                onPressed: () {
                  launchUrlString(kUpdatePageUrl);
                },
                icon: Icon(Icons.cloud_upload_rounded),
                label: Text("Update"),
              ) : Row(
                children: [
                  Text("Up to date"),
                  SpacerWidget(width: 4),
                  Icon(Icons.check_circle_rounded, color: Colors.lightGreenAccent),
                ],
              ),
              // ) : SpacerWidget(width: 118),
              error: (_, __) => Container(),
              loading: () => Container(),
            )
          ],
        )
      ],
    );
  }
}

class UpdateDialog extends StatelessWidget {
  String latestVersion;
  UpdateDialog({required this.latestVersion});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AlertDialog(
      title: Text("Update available", style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
      content: Text(
        "Current version: v${kVersionString}\nLatest version: ${latestVersion}\nClick \"View\" to get taken to the download page\nYou can always find it again in settings",
        style: theme.textTheme.bodyLarge,
      ),
      actions: [
        TextButton(
          child: Text("Dismiss"),
          onPressed: () => SchedulerBinding.instance.addPostFrameCallback((_) => Navigator.of(context, rootNavigator: true).pop()),
        ),
        FilledButton.tonal(
          child: Text("View"),
          onPressed: () => launchUrlString(kUpdatePageUrl),
        ),
      ],
    );
  }
}