import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as prov;
import '../providers/theme_provider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends ConsumerState<SettingsPage> {
  Color schemeColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    final themeChanger = prov.Provider.of<ThemeChanger>(context);
    schemeColor = HexColor.fromHex(themeChanger.seedColor);
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: Column(
        children: [
          FilledButton(
            child: Text("Use ${themeChanger.isDark ? 'Light' : 'Dark'} Mode"),
            onPressed: () => themeChanger.toggleTheme(),
          ),
          Container(height: 6),
          FilledButton(
            child: Text("Change theme color"),
            onPressed: () => colorPickerDialog(themeChanger),
          ),
        ]
      )
    );
  }
  Future<bool> colorPickerDialog(ThemeChanger themeChanger) async {
    return ColorPicker(
      // Use the dialogPickerColor as start and active color.
      color: schemeColor,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) =>
        setState(() {
          themeChanger.seedColor = color.toHex();
        }),
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

