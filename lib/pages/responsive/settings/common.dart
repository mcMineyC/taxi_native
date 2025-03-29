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
    return DropdownButton<BrightnessModes>(
      value: selectedMode,
      onChanged: (BrightnessModes? newValue) {
        if (newValue != null) {
          setState(() {
            widget.onSelected(newValue);
            selectedMode = newValue;
          });
        }
      },
      items: [
        DropdownMenuItem<BrightnessModes>(
          value: BrightnessModes.auto,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.brightness_auto),
              SizedBox(width: 8),
              Text('Auto'),
            ],
          ),
        ),
        DropdownMenuItem<BrightnessModes>(
          value: BrightnessModes.light,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.brightness_high),
              SizedBox(width: 8),
              Text('Light'),
            ],
          ),
        ),
        DropdownMenuItem<BrightnessModes>(
          value: BrightnessModes.dark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.brightness_low),
              SizedBox(width: 8),
              Text('Dark'),
            ],
          ),
        ),
      ],
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

class _CompactColorSourceModeSwitchState extends State<CompactColorSourceModeSwitch> {
  bool init = false;
  ColorSourceMode selectedMode = ColorSourceMode.dynamic;

  @override
  Widget build(BuildContext context) {
    if (!init) {
      selectedMode = widget.mode;
      init = true;
    }
    return DropdownButton<ColorSourceMode>(
      value: selectedMode,
      onChanged: (ColorSourceMode? newValue) {
        if (newValue != null) {
          setState(() {
            widget.onSelected(newValue);
            selectedMode = newValue;
          });
        }
      },
      items: [
        DropdownMenuItem<ColorSourceMode>(
          value: ColorSourceMode.dynamic,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.autorenew),
              SizedBox(width: 8),
              Text('Dynamic'),
            ],
          ),
        ),
        DropdownMenuItem<ColorSourceMode>(
          value: ColorSourceMode.manual,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.settings),
              SizedBox(width: 8),
              Text('Manual'),
            ],
          ),
        ),
      ],
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
