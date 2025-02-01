import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import '../../../providers/services/search.dart';
import '../../../utilities.dart';

class DesktopAppBar extends ConsumerWidget {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var qText = ref.watch(searchProvider.notifier).text;
    if(Beamer.of(context).currentPages.last.key == ValueKey("search") && qText.isNotEmpty && _searchController.text == "") {
      print("Restoring text: $qText");
      _searchController.text = qText;
    }else if(Beamer.of(context).currentPages.last.key == ValueKey("search") && qText == "") {
      _searchController.clear();
    }
    if(Beamer.of(context).currentPages.last.key == ValueKey("search")) {
      ref.watch(searchProvider.select((value) => value.query));
    }
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      height: 58,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 22),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Beamer.of(context).beamBack(),
            ),
          ),
          Text(
            Beamer.of(context).currentPages.last.title ?? "Home",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(child: Container()),
          if(Beamer.of(context).currentPages.last.key == const ValueKey("search")) Container(
            constraints: const BoxConstraints(maxWidth: 512),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: (value) async {
                ref.read(searchProvider.notifier).search(value, "all");
              },
              decoration: ref.read(searchProvider.notifier).text.isNotEmpty ? InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9999)),
                ),
                hintText: "Search",
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear), 
                    onPressed: () {
                      _searchController.clear();
                      ref.read(searchProvider.notifier).search("", "all");
                    },
                  )
                ) :
                InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(9999)),
                  ),
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search_rounded),
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () {
                  refreshChanges(ref);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Refreshed")));
                }
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4).copyWith(right: 22),
              child: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => Beamer.of(context).beamToNamed('/settings'),
              ),
            ),
        ]
      )
    );
  }
}
