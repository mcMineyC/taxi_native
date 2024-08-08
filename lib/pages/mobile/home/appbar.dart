import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import '../../../providers/search_provider.dart';

class MobileAppBar extends ConsumerWidget {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var qText = ref.watch(searchProvider.notifier).text;
    var onSearch = Beamer.of(context).currentPages.last.key == const ValueKey("search");
    if(onSearch && qText.isNotEmpty && _searchController.text == "") {
      print("Restoring text: $qText");
      _searchController.text = qText;
    }else if(onSearch && qText == "") {
      _searchController.clear();
    }
    if(onSearch) {
      ref.watch(searchProvider.select((value) => value.query));
    }
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      height: 58,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, right: onSearch ? 24 : 16),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Beamer.of(context).beamBack(),
            ),
          ),
          if(!onSearch) Text(
            Beamer.of(context).currentPages.last.title ?? "Home",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: onSearch ? TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: (value) async {
                ref.read(searchProvider.notifier).search(value);
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
                      ref.read(searchProvider.notifier).search("");
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
              ) :
              Container(),
            ),
            Container(
              width: 96,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => Beamer.of(context).beamToNamed('/settings'),
                ),
              ),
            ),
        ]
      )
    );
  }
}
