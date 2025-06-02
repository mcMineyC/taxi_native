import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as prov;
import 'package:taxi_native/helpers/widgets/update_checker.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../providers/data/preferences_provider.dart';
import '../../../../providers/services/player.dart';
import '../../../../helpers/platform_utils.dart';
import '../../../../helpers/widgets/helper_widgets.dart';
import '../../../../helpers/utilities.dart';
import "../../../../helpers/constants.dart";
import "../common.dart";
import 'package:flex_color_picker/flex_color_picker.dart';

class DesktopSettingsPage extends ConsumerStatefulWidget {
  const DesktopSettingsPage({super.key});
  @override
  DesktopSettingsPageState createState() => DesktopSettingsPageState();
}

class DesktopSettingsPageState extends ConsumerState<DesktopSettingsPage> {
  Color schemeColor = Colors.black;
  bool init = false;

  TextEditingController _serverUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PreferencesProvider prefProvider =
        prov.Provider.of<PreferencesProvider>(context);
    ThemeChanger themeChanger = prov.Provider.of<ThemeChanger>(context);
    if (!init) {
      schemeColor = HexColor.fromHex(themeChanger.seedColor);
      _serverUrlController.text = prefProvider.backendUrl;
      init = true;
    }
    List<(String header, List<(String label, Widget content)>)> _settings = [
      (
        'Theme',
        [
          (
            "Brightness Mode",
            WideBrightnessModeSwitch(
              mode: getBrightnessModeFromString(themeChanger.mode),
              onSelected: (BrightnessModes mode) {
                print("Selected brightness mode: ${mode.toString().split('.').last}");
                themeChanger.mode = mode.toString().split('.').last;
              },
            )
          ),
          // Container(height: 6),
          (
            "Color source mode",
            WideColorSourceModeSwitch(
              mode: themeChanger.isAuto
                  ? ColorSourceMode.dynamic
                  : ColorSourceMode.manual,
              onSelected: (ColorSourceMode mode) {
                print(
                    "Selected color source mode: ${mode.toString().split('.').last}");
                themeChanger.isAuto =
                    mode.toString().split('.').last == "dynamic";
              },
            ),
          ),
          if(themeChanger.isAuto) (
            "",
            Container(
                margin: const EdgeInsets.only(left: 8),
                child: FilledButton(
                  child: Text("Change theme color"),
                  onPressed: () => colorPickerDialog(themeChanger),
                ),
            ),
          ),
        ]
      ),
      (
        "Shuffle",
        [
          (
            "On loop",
            Switch(
              value: prefProvider.shuffleOnLoop,
              onChanged: (value) => prefProvider.shuffleOnLoop = value,
            ),
          ),
          (
            "By default",
            Switch(
              value: prefProvider.shuffleDefault,
              onChanged: (value) => prefProvider.shuffleDefault = value
            )
          )
        ],
      ),
      /*
        persistence
        - Save current song
          Switch(
              value: prefProvider.persistInfo,
              onChanged: (value) => prefProvider.persistInfo = value,
            ),
        - Auto-resume song
            Switch(
              value: PlatformUtils.isWeb ? false : prefProvider.autoResume,
              onChanged: PlatformUtils.isWeb
                  ? null
                  : (value) => prefProvider.autoResume = value,
            ),
        - Save library tab
            Switch(
              value: prefProvider.saveLibraryTab,
              onChanged: (value) => prefProvider.saveLibraryTab = value,
            ),
      */
      (
        "Persistence",
        [
          (
            "Save current song",
            Switch(
              value: prefProvider.persistInfo,
              onChanged: (value) => prefProvider.persistInfo = value,
            ),
          ),
          (
            "Auto-resume song",
            Switch(
              value: PlatformUtils.isWeb ? false : prefProvider.autoResume,
              onChanged: PlatformUtils.isWeb ? null : (value) => prefProvider.autoResume = value,
            ),
          ),
          (
            "Save library tab",
            Switch(
              value: prefProvider.saveLibraryTab,
              onChanged: (value) => prefProvider.saveLibraryTab = value,
            ),
          )
        ]
      ),
      /*
        Development
        - Debug mode (obselete)
                        Switch(
                value: prefProvider.debugMode,
                onChanged: (value) => prefProvider.debugMode = value,
              ),

        - Server url
      */
      (
        "Development",
        [
          // (
          //   "Debug mode",
          //   Switch(
          //     value: prefProvider.debugMode,
          //     onChanged: (value) => prefProvider.debugMode = value,
          //   ),
          // ),
          (
            "Server url",
            Container(constraints: const BoxConstraints(maxWidth: 512), child: TextField(
              controller: _serverUrlController,
              decoration: const InputDecoration(
                labelText: "Server URL",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => prefProvider.backendUrl = value,
            )),
          ),
          (
            "",
            FilledButton(
              child: const Text("Save"),
              onPressed: () async {
                invalidateProviders(ref);
                Beamer.of(context).beamToNamed("/login");
              },
            ),
          ),
        ],
        /*
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: const Text("Debug mode"),
              ),
            ]),
            Row(
              children: <Widget>[
                Container(
                  width: 372,
                  child:
                ),
                FilledButton(
                  child: const Text("Save"),
                  onPressed: () async {
                    Beamer.of(context).beamToNamed("/login");
                  },
                )
              ],
            ),
          ],
        ),
        */
      ),
      (
        "",
        [
          (
            "",
            UpdateChecker()
          ),
          (
            "",
            Row(
              children: <Widget>[
                OutlinedButton(
                  style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(Colors.red)),
                  child: const Text("Reset"),
                  onPressed: () async {
                    var result = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Reset all settings?"),
                              content: const Text(
                                  "This will reset all settings to their defaults. This action cannot be undone."),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("No"),
                                  onPressed: () => Navigator.of(context).pop(false),
                                ),
                                TextButton(
                                  child: const Text("Yes"),
                                  onPressed: () => Navigator.of(context).pop(true),
                                ),
                              ],
                            ));
                    if (result == true) {
                      prefProvider.reset();
                      themeChanger.reset();
                    }
                  },
                ),
                Container(width: 12),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.red),
                      foregroundColor: WidgetStateProperty.all(Colors.white)),
                  child: const Text("Logout"),
                  onPressed: () async {
                    var result = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Logout?"),
                              content: const Text(
                                  "You will be logged out and need to log in again. This action cannot be undone."),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("No"),
                                  onPressed: () => Navigator.of(context).pop(false),
                                ),
                                TextButton(
                                  child: const Text("Yes"),
                                  onPressed: () => Navigator.of(context).pop(true),
                                ),
                              ],
                            ));
                    if (result == true) {
                      ref.read(playerProvider.notifier).stop();
                      invalidateProviders(ref);
                      //await themeChanger.reset(); // changing the color is a bit too drastic
                      //await prefProvider.reset(); // do I really need to do this?
                      await prefProvider.logout();
                      Beamer.of(context).beamToReplacementNamed("/login");
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ];
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: ListView.separated(
        itemCount: _settings.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) =>
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(_settings[index].$1,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: themeChanger.colorScheme?.onSurface)),
          Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _settings[index].$2.map((e) =>
              Container(
                margin: EdgeInsets.only(top: 4, bottom: 4),
                child: Row(
                  children: [
                    if(e.$1 != "") Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: Text(e.$1),
                    ),
                    e.$2
                  ],
                ),
              ),
            ).toList(),
          )
        ]),
      ),
    );
  }

  Future<bool> colorPickerDialog(ThemeChanger themeChanger) async {
    return ColorPicker(
      color: schemeColor,
      onColorChanged: (Color color) {
        if (color == Colors.black) return;
        setState(() {
          themeChanger.seedColor = color.toHex();
        });
      },
      width: 40,
      height: 40,
      borderRadius: 8,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 200,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: true,
        ColorPickerType.primary: false,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }
}
