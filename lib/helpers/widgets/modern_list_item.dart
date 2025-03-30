import "package:flutter/material.dart";
class ModernListItem extends StatelessWidget {
  final bool isEnd;
  final bool isStart;
  final Widget? child;
  final Widget? trailing;
  final Widget? leading;
  final Widget? title;
  final String? titleText;
  final Widget? subtitle;
  final String? subtitleText;
  final int horizPadding;
  final int interItemSpacing;
  final double cornerRadius;
  final Color? color;
  final Color? textColor;
  ModernListItem({super.key, required this.isEnd, required 
    this.isStart, this.child, this.trailing, this.leading, 
    this.title, this.subtitle, this.titleText, this.subtitleText, 
    this.color, this.textColor,
    this.horizPadding = 12, this.interItemSpacing = 2, this.cornerRadius = 24}) {
    assert(child != null || (leading != null || title != null || subtitle != null || subtitleText != null || titleText != null), "Either child or layout-specific widget should be defined");
    assert(child == null && (leading != null || title != null || subtitle != null || titleText != null || subtitleText != null), "Both child and layout-specific widget cannot be defined");
    //assert(title != null && titleText != null, "Either titleText or title should be defined");
    //assert(subtitle != null || subtitleText != null, "Either subtitleText or subtitle should be defined");
    assert((title == null) ^ (titleText == null), "Either titleText or title should be defined but not both");
    assert((subtitle == null) ^ (subtitleText == null), "Either subtitleText or subtitle should be defined but not both");
    //assert(child != null && (leading == null && title == null && subtitle == null), "Both child and layout-specific widget cannot be defined");
  }
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: isStart || isEnd ? 100 : 84,
      margin: EdgeInsets.only(
        bottom: isEnd ? 0 : interItemSpacing/2.0,
        top: isStart ? 0 : interItemSpacing/2.0,
        left: horizPadding.toDouble(),
        right: horizPadding.toDouble()
      ),
      //margin: EdgeInsets.only(bottom: isEnd ? 0 : 8),
      padding: 
        // isStart ? EdgeInsets.symmetric(horizontal: 12).copyWith(top: 16) :
        // isEnd ? EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 16) :
        EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: 
          isStart && isEnd ? BorderRadius.circular(cornerRadius) :
          isEnd ? BorderRadius.only(bottomLeft: Radius.circular(cornerRadius), bottomRight: Radius.circular(cornerRadius), topLeft: Radius.circular(4), topRight: Radius.circular(4)) :
          isStart ? BorderRadius.only(topLeft: Radius.circular(cornerRadius), topRight: Radius.circular(cornerRadius), bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4)) :
          BorderRadius.all(Radius.circular(4)),
        color: this.color ?? theme.colorScheme.surfaceContainerHighest,
      ),
      child: child ?? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) leading!,
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  title != null ? title! : Text(titleText!, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, color: textColor), overflow: TextOverflow.ellipsis),
                  subtitle != null ? subtitle! : Text(subtitleText!, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: textColor), overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
          ),
          // if (trailing != null) const Spacer(),
          if (trailing != null) trailing! //trailing!,
        ],
      ),
    );
  }
}