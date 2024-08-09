import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../types/checklist_item.dart';
import '../providers/data/status_provider.dart';

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
                  onPressed: (){
                    final _formKey = GlobalKey<FormState>();
                    final _name = TextEditingController();
                    final _description = TextEditingController();
                    showDialog(context: context, builder: (context) => 
                      AlertDialog(
                        title: Text("Request a feature"),
                        content: SingleChildScrollView(
                          child: Container(
                            constraints: BoxConstraints(minWidth: 512, maxWidth: 512, maxHeight: 300),
                            child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _name,
                                  decoration: InputDecoration(
                                    labelText: "Name of feature",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                Container(height: 8),
                                Expanded(child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter some text\nI need to know what it I'm trying to write";
                                    }
                                    return null;
                                  },
                                  controller: _description,
                                  decoration: InputDecoration(
                                    labelText: "Detailed description of feature",
                                    border: OutlineInputBorder(),
                                  ),
                                  // minLines: 1,
                                  maxLines: 10,
                                  keyboardType: TextInputType.multiline,
                                ),)
                              ],
                            ),
                          ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text("Submit"),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await ref.read(addChecklistItemProvider([_name.text, _description.text]).future);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Request sent!")));
                                Navigator.of(context).pop();
                                ref.refresh(getChecklistItemsProvider);
                              }
                            }
                          ),
                        ]
                      ),
                    );
                  }
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
