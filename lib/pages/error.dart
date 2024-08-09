import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 512,maxHeight: 128),
          child: Column(
            children: [
              const Text(
                "How did you even get here? Well, you're here now. There's nothing to do here, so feel free to hit the back button.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Some debug info:",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Beamer: ${Beamer.of(context).currentPages.last}",
                style: const TextStyle(fontSize: 16),
              ),
              IconButton.filledTonal(
                onPressed: () => Beamer.of(context).beamToNamed('/home'),
                icon: const Icon(Icons.arrow_upward_rounded),
              )
            ],
          )
        ),
      );
  }
}
