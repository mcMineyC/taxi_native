import "package:flutter/material.dart";

class WideBrightnessModeSwitch extends StatefulWidget {
  Function(BrightnessModes) onSelected;
  BrightnessModes mode;
  WideBrightnessModeSwitch(
      {super.key, required this.onSelected, required this.mode});

  @override
  State<WideBrightnessModeSwitch> createState() =>
      _WideBrightnessModeSwitchState();
}

class _WideBrightnessModeSwitchState extends State<WideBrightnessModeSwitch> {
  bool init = false;
  BrightnessModes selectedMode = BrightnessModes.auto;

  @override
  Widget build(BuildContext context) {
    if (!init) {
      selectedMode = widget.mode;
      init = true;
    }
    return SegmentedButton<BrightnessModes>(
      segments: const <ButtonSegment<BrightnessModes>>[
        ButtonSegment<BrightnessModes>(
          value: BrightnessModes.auto,
          label: Text('Auto'),
          icon: Icon(Icons.brightness_auto),
        ),
        ButtonSegment<BrightnessModes>(
          value: BrightnessModes.light,
          label: Text('Light'),
          icon: Icon(Icons.brightness_high),
        ),
        ButtonSegment<BrightnessModes>(
          value: BrightnessModes.dark,
          label: Text('Dark'),
          icon: Icon(Icons.brightness_low),
        ),
      ],
      selected: <BrightnessModes>{selectedMode},
      onSelectionChanged: (Set<BrightnessModes> newSelection) {
        setState(() {
          widget.onSelected(newSelection.first);
          selectedMode = newSelection.first;
        });
      },
    );
  }
}

class CompactBrightnessModeSwitch extends StatefulWidget {
  Function(BrightnessModes) onSelected;
  BrightnessModes mode;
  CompactBrightnessModeSwitch(
      {super.key, required this.onSelected, required this.mode});

  @override
  State<CompactBrightnessModeSwitch> createState() =>
      _CompactBrightnessModeSwitchState();
}

class _CompactBrightnessModeSwitchState
    extends State<CompactBrightnessModeSwitch> {
  bool init = false;
  BrightnessModes selectedMode = BrightnessModes.auto;

  @override
  Widget build(BuildContext context) {
    if (!init) {
      selectedMode = widget.mode;
      init = true;
    }
    return DropdownMenu<BrightnessModes>(
      dropdownMenuEntries: [
        DropdownMenuEntry<BrightnessModes>(
          value: BrightnessModes.auto,
          label: 'Auto',
          leadingIcon: const Icon(Icons.brightness_auto),
        ),
        DropdownMenuEntry<BrightnessModes>(
          value: BrightnessModes.light,
          label: 'Light',
          leadingIcon: const Icon(Icons.brightness_high),
        ),
        DropdownMenuEntry<BrightnessModes>(
          value: BrightnessModes.dark,
          label: 'Dark',
          leadingIcon: const Icon(Icons.brightness_low),
        ),
      ],
      initialSelection: selectedMode,
      onSelected: (BrightnessModes? newValue) {
        if (newValue != null) {
          setState(() {
            widget.onSelected(newValue);
            selectedMode = newValue;
          });
        }
      },
    );
  }
}

enum BrightnessModes { auto, light, dark }

BrightnessModes getBrightnessModeFromString(String mode) {
  switch (mode) {
    case "auto":
      return BrightnessModes.auto;
    case "light":
      return BrightnessModes.light;
    case "dark":
      return BrightnessModes.dark;
    default:
      return BrightnessModes.light;
  }
}

class WideColorSourceModeSwitch extends StatefulWidget {
  Function(ColorSourceMode) onSelected;
  ColorSourceMode mode;
  WideColorSourceModeSwitch({required this.onSelected, required this.mode});

  @override
  _WideColorSourceModeSwitchState createState() =>
      _WideColorSourceModeSwitchState();
}

class _WideColorSourceModeSwitchState extends State<WideColorSourceModeSwitch> {
  bool init = false;
  ColorSourceMode selectedMode = ColorSourceMode.dynamic;

  @override
  Widget build(BuildContext context) {
    if (!init) {
      selectedMode = widget.mode;
      init = true;
    }
    return SegmentedButton<ColorSourceMode>(
      segments: const <ButtonSegment<ColorSourceMode>>[
        ButtonSegment<ColorSourceMode>(
          value: ColorSourceMode.dynamic,
          label: Text('Dynamic'),
          icon: Icon(Icons.autorenew),
        ),
        ButtonSegment<ColorSourceMode>(
          value: ColorSourceMode.manual,
          label: Text('Manual'),
          icon: Icon(Icons.settings),
        ),
      ],
      selected: <ColorSourceMode>{selectedMode},
      onSelectionChanged: (Set<ColorSourceMode> newSelection) {
        setState(() {
          widget.onSelected(newSelection.first);
          selectedMode = newSelection.first;
        });
      },
    );
  }
}

class CompactColorSourceModeSwitch extends StatefulWidget {
  Function(ColorSourceMode) onSelected;
  ColorSourceMode mode;
  CompactColorSourceModeSwitch(
      {super.key, required this.onSelected, required this.mode});

  @override
  State<CompactColorSourceModeSwitch> createState() =>
      _CompactColorSourceModeSwitchState();
}

class _CompactColorSourceModeSwitchState
    extends State<CompactColorSourceModeSwitch> {
  bool init = false;
  ColorSourceMode selectedMode = ColorSourceMode.dynamic;

  @override
  Widget build(BuildContext context) {
    if (!init) {
      selectedMode = widget.mode;
      init = true;
    }
    return DropdownMenu<ColorSourceMode>(
      dropdownMenuEntries: [
        DropdownMenuEntry<ColorSourceMode>(
          value: ColorSourceMode.dynamic,
          label: 'Dynamic',
          leadingIcon: const Icon(Icons.autorenew),
        ),
        DropdownMenuEntry<ColorSourceMode>(
          value: ColorSourceMode.manual,
          label: 'Manual',
          leadingIcon: const Icon(Icons.settings),
        ),
      ],
      initialSelection: selectedMode,
      onSelected: (ColorSourceMode? newValue) {
        if (newValue != null) {
          setState(() {
            widget.onSelected(newValue);
            selectedMode = newValue;
          });
        }
      },
    );
  }
}

enum ColorSourceMode { dynamic, manual }

ColorSourceMode getColorSourceModeFromString(String mode) {
  switch (mode) {
    case "dynamic":
      return ColorSourceMode.dynamic;
    case "manual":
      return ColorSourceMode.manual;
    default:
      return ColorSourceMode.dynamic;
  }
}
