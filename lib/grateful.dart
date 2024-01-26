import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<GratefulItem> items = []; //items the user is grateful for

class Grateful extends StatefulWidget {
  const Grateful({Key? key}) : super(key: key);

  @override
  State<Grateful> createState() => _GratefulState();
}

class _GratefulState extends State<Grateful> {
  @override
  void initState() {
    super.initState();
    items = [];
    _loadItems(); //get the items from Sharedpref
  }

  Future<void> saveItems() async {//save items to Sharedpref (when deleting)
    final prefs = await SharedPreferences.getInstance();
    List<String> itemsToSave = [];
    List<String> itemsToSaveF = [];

    for (int i = 0; i < items.length; i++) {
      itemsToSave.add(items[i].text);
      if (items[i].isFavorite == true) {
        itemsToSaveF.add("1");
      } else
        itemsToSaveF.add("0");
    }

    prefs.setStringList('gratefulItems', itemsToSave);
    prefs.setStringList('gratefulItemsF', itemsToSaveF);
  }

  Future<void> _loadItems() async {
    bool mybool;
    final prefs = await SharedPreferences.getInstance();
    final savedItems = prefs.getStringList('gratefulItems') ?? [];
    final savedItemsF = prefs.getStringList('gratefulItemsF') ?? [];
    for (int i = 0; i < savedItems.length; i++) {
      if (savedItemsF[i] == "1")
        items.add(GratefulItem(savedItems[i], true));
      else
        items.add(GratefulItem(savedItems[i], false));
    }
    setState(() {});
  }

  void _deleteItem(int index) {//delete item and save at the same time to Sharedpref
    items.removeAt(index);
    saveItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (items.length == 0)
        ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Text(
                    "Even in the emptiest of moments, there's always something to be grateful for. Take a moment to appreciate the little things, they often make the biggest difference.")),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12),
                    ),
                    child: ListTile(
                      title: Text(item.text),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        textDirection: TextDirection.rtl,
                        children: [
                          IconButton(
                            color: Colors.deepPurple,
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete item?'),
                                  content: Text(
                                      'Are you sure you want to delete "${item.text}"?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _deleteItem(index);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          IconButton(
                            color: Colors.deepPurple,
                            icon: Icon(
                              item.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                            onPressed: () {
                              setState(() {
                                item.isFavorite = !item.isFavorite;
                                saveItems();
                              });
                            },
                          ),
                        ],
                      ),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete item?'),
                            content: Text(
                                'Are you sure you want to delete "${item.text}"?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  _deleteItem(index);
                                  Navigator.pop(context);
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                    ));
              },
            ),
          );
  }
}

class GratefulItem {
  final String text;
  bool isFavorite;

  GratefulItem(this.text, this.isFavorite);
}