enum ScreenBreakpoint{
  small(width: 352),
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
}
