import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../types/checklist_item.dart';
import '../providers/status_provider.dart';

class ChecklistPage extends ConsumerStatefulWidget{
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends ConsumerState<ChecklistPage> {
  @override
  Widget build(BuildContext context) {
    var items = ref.watch(getChecklistItemsProvider);
    items.when(
      data: (data) {
        
      },
      error: (err, stack) {
        print("an error has occured");
        print("\t$err");
        print("\tt$stack");
      },
      loading: () {},
    );
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: items.when(
        data: (data) => ListView.separated(
          itemCount: data.length+1,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) => index == 0 ? Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12), 
                child: Text("Title")
              ),
              Expanded(
                child: OutlinedButton(
                  child: Text("Add Item"), 
                  onPressed: (){}
                )
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12), 
                child: Text("Requested By")
              ),
            ]
          ) : ListTile(
            title: Text(data[index-1].name),
            leading: Checkbox(
              value: data[index-1].completed,
              onChanged: null,
              fillColor: WidgetStateProperty.resolveWith<Color?>((states) => states.contains(WidgetState.selected) ? 
                Theme.of(context).colorScheme.primary : 
                Colors.transparent
              ),
            ),
            trailing: Text(data[index-1].requestedBy),
          ),
        ),
        error: (_, __) => Text("Error"),
        loading: () => Text("Loading"),
      ),
    );
  }
}
