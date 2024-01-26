import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import 'mycustomnav.dart';
import 'popupcard.dart';

//The entry point is basically the scaffold and the screens are the body of the scaffold ( my own method implementation to persist
//the top app bar and the bottom navigation bar across different screens (I used Gnav bottom navigation bar for aesthetics) )

bool areNotificationsEnabled =
    true; //the notification bell by default is false until the user accept the notification permission

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});
  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int page =
      0; //by default the body is on the Grateful screen which is of index 0
  String page_name = "I'm Grateful For";

  @override
  void initState() {
    super.initState();

    getNotf();
    //setNotfParm();
  }

  Future<void> getNotf() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? passage = prefs.getBool('allowed');
    (passage == null)
        ? areNotificationsEnabled = true
        : areNotificationsEnabled = passage;
    setState(() {});
  }

  void fromOffToOn(bool value) async {
    var status = await Permission.notification.status;

    if (status.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    } else if (status.isDenied) {
      status = await Permission.notification.request();

      if (status.isGranted) {
        // Permission granted
        areNotificationsEnabled = true;
        print('Notification permission granted.');
      } else {
        // Permission denied permanently
        areNotificationsEnabled = false;
        print('Notification permission permanently denied.');
        // Handle this case appropriately, e.g., by showing a snackbar or dialog
        // that guides the user to app settings to enable notifications manually.
      }
    }
    setState(() {
      areNotificationsEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var ob = myCustomNav(page);

    return FocusScope(
        //I used focus scope to update the state of Listview (which is inside the body of this scaffold) whenever
        //the user add a new element (leaves the add element pop up card)
        onFocusChange: (hasFocus) {
          if (hasFocus) {
            setState(() {}); // Reload items when regaining focus
          }
        },
        child: MaterialApp(
            home: Scaffold(
          body: myCustomNav(page),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Center(
                child: Text(
              page_name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                shadows: [
                  Shadow(
                    color: Colors.grey,
                    offset: Offset(2, 2),
                    blurRadius: 50,
                  ),
                ],
              ),
            )),
            backgroundColor: Color.fromRGBO(31, 17, 55, 1),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15))),
          ),
          bottomNavigationBar: Container(
            //Gnav wrapped in a padding in a container
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: GNav(
                //here i used google Gnav for better aesthetics
                backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                gap: 8,
                padding: EdgeInsets.all(16),

                tabs: [
                  GButton(
                    icon: Icons.sentiment_very_satisfied,
                    text: "Grateful",
                    onPressed: () {
                      setState(() {
                        page = 0;
                        page_name = "I'm Grateful For";
                      });
                    },
                  ),
                  GButton(
                    icon: Icons.signal_cellular_alt,
                    text: "Mood",
                    onPressed: () {
                      setState(() {
                        page = 1;
                        page_name = "Your Mood & Statistics";
                      });
                    },
                  ),
                  GButton(
                    icon: Icons.tips_and_updates,
                    text: "Wellbeing Tips",
                    onPressed: () {
                      setState(() {
                        page = 2;
                        page_name = "Well being Tips";
                      });
                    },
                  ),
                  GButton(
                    icon: Icons.warning,
                    text: "Emergency",
                    onPressed: () {
                      setState(() {
                        page = 3;
                        page_name = "Emergency Numbers";
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          drawer: Drawer(
            child: Stack(
              children: [
                // First phrase on top
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "INSAT Android Club Competetion  ",
                              style: TextStyle(fontSize: 13),
                            ),
                            Icon(
                              Icons.favorite,
                              color: Colors.deepPurple,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              title: Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Icon(Icons.notifications),
                                  const Text('Notifications  '),
                                ],
                              ),
                              trailing: Switch(
                                value: areNotificationsEnabled,
                                onChanged: (value) {
                                  setState(() {
                                    areNotificationsEnabled = value;
                                  });
                                  saveNotf(value);
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/meme.png'),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Made by Oussema Nehdi",
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text("      oussema.nehdi2@gmail.com   "),
                            Icon(
                              Icons.email,
                              color: Colors.deepPurple,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: (page == 0) //`will pop up the pop up card
              ? FloatingActionButton(
                  backgroundColor: Color.fromRGBO(31, 17, 55, 1),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Color.fromRGBO(31, 17, 55, 1),
                      context: context,
                      builder: (context) => Builder(
                        builder: (context) => PopupCard(),
                      ),
                      barrierColor: Colors.black.withOpacity(0.5),
                    );
                  },
                )
              : null,
        )));
  }
}

void saveNotf(bool x) async {
  //save notification to Sharedpref
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('allowed', x);
}
