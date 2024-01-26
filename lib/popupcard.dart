import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'grateful.dart';

class PopupCard extends StatefulWidget {
  const PopupCard({Key? key}) : super(key: key);

  @override
  State<PopupCard> createState() => _PopupCardState();
}

class _PopupCardState extends State<PopupCard> {
  Future<void> saveItems() async {//save items to Sharedpref (when adding)
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

  @override
  Widget build(BuildContext context) {
    String currentText = "";
    return ShowUpAnimation(
      curve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 400),
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: 2000,
          width: 800,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "I'm Grateful For",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              TextFormField(
                onChanged: (value) {
                  currentText = value;
                },
                decoration: InputDecoration(
                  hintText: "A lovely family",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        BorderSide(color: Colors.purple.shade300, width: 1.0),
                  ),
                  fillColor: Colors.purple.shade200,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          items.add(GratefulItem(currentText, false));
                          saveItems();

                          Navigator.pop(context);
                        },
                        child: Text("Save"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white)),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel")),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
