import 'package:flutter/material.dart';

class ScrollToHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;
  final double height;

  const ScrollToHideWidget({
    Key? key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 200),
    required this.height,
  }) : super(key: key);

  @override
  _ScrollToHideWidgetState createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;
  double lastScrollPosition = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listenToScrollChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listenToScrollChange);
    super.dispose();
  }

  void listenToScrollChange() {
    final scrollPosition = widget.controller.position.pixels;

    // Determine scroll direction and distance
    if (scrollPosition > lastScrollPosition + 10 && isVisible) {
      // Scrolling down - hide the AppBar
      setState(() {
        isVisible = false;
      });
    } else if (scrollPosition < lastScrollPosition - 10 ||
        scrollPosition <= 0) {
      // Scrolling up or at the top - show the AppBar
      setState(() {
        isVisible = true;
      });
    }

    lastScrollPosition = scrollPosition;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? widget.height : 0,
      child: isVisible
          ? widget.child
          : const SizedBox(), // Use SizedBox when hidden to maintain layout
    );
  }
}
