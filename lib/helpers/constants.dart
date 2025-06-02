import "package:flutter/material.dart";
enum ScreenBreakpoint{
  small(width: 458),
  medium(width: 580),
  large(width: 840),
  huge(width: 840),
  unknown(width: 0);
  const ScreenBreakpoint({
    required this.width
  });
  final int width;
  static ScreenBreakpoint determine(int w){
    if(w <= ScreenBreakpoint.small.width){
      return ScreenBreakpoint.small;
    }else if(w <= ScreenBreakpoint.medium.width){
      return ScreenBreakpoint.medium;
    //}else if(w <= ScreenBreakpoint.mediumLarge.width){
    //  return ScreenBreakpoint.mediumLarge;
    }else if(w <= ScreenBreakpoint.large.width){
      return ScreenBreakpoint.large;
    }else if(w > ScreenBreakpoint.large.width){
      return ScreenBreakpoint.huge;
    }
    return ScreenBreakpoint.unknown;
  }
  static bool isMobile(BuildContext context){
    ScreenBreakpoint sb = determine(MediaQuery.of(context).size.width.toInt());
    return switch(sb){
      ScreenBreakpoint.small => true,
      ScreenBreakpoint.medium => true,
      ScreenBreakpoint.large => true,
      ScreenBreakpoint.huge => false,
      _ => false
    };
  }
  bool operator >(other) => this.width > other.width;
  bool operator >=(other) => this.width >= other.width;
  bool operator <(other) => this.width < other.width;
  bool operator <=(other) => this.width <= other.width;
}
bool isMobile(BuildContext context) => ScreenBreakpoint.isMobile(context);

extension on MediaQueryData{
  ScreenBreakpoint get breakpoint => ScreenBreakpoint.determine(this.size.width.toInt());
}

String kVersionString = "4.1.9";
String kRepoUrl = "https://github.com/mcMineyC/taxi_native";
