import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellbeing/grateful.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:math';
import 'package:introduction_screen/introduction_screen.dart';

import 'entrypoint.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();



  //make the introduction screen happen only once
  final prefs = await SharedPreferences.getInstance();
  bool isFirstLaunchx = prefs.getBool('isFirstLaunchx') ?? true;
  /////////////////////////////////////////
  runApp(MyApp(isFirstLaunchx: true));


  //Start the Workmanager that will schedule a notification every while
  List<String> listString = []; //String representation of the items the user is grateful for (Workmanager doesn't accept non native list)
  for (int i = 0; i < items.length; i++) {
    listString.add(items[i].text);
  }
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true); //init and call the workmanager passing the items as input todo changer true to false
  Workmanager().registerPeriodicTask(
    "tips",
    "tipsTag",
    frequency: Duration(seconds: 10),
    inputData: {"listString": listString},
  );
  ////////////////////////////////////////////
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunchx;

  const MyApp({super.key, required this.isFirstLaunchx});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isFirstLaunchx //introduction screen runs only the first time the app is launched and then the entry point is returned normally
          ? Builder(
        builder: (context) => IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Welcome!",
              body: "Welcome to our app.",
              image: Image.asset("assets/images/meme.png"),
            ),
            PageViewModel(
              title: "Explore the Features",
              body: "Our app has many great features.",
              image: Image.asset("assets/images/meme.png"),
            ),
          ],
          onDone: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isFirstLaunchx', false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EntryPoint()),
            );
          },
          onSkip: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isFirstLaunchx', false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EntryPoint()),
            );
          },
          next: const Text("Next"),
          done: const Text("Done"),
          showSkipButton: true,
          skip: const Text("Skip"),
        ),
      )
          : EntryPoint(),
    );
  }
}
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {//Task : send a notification of a random item the user is grateful for
    final prefs = await SharedPreferences.getInstance();
    final savedItems = prefs.getStringList('gratefulItems') ?? [];
    if(savedItems != null && savedItems.length > 0 ) //if there are items :
      {
    String randomTip = savedItems[Random().nextInt(savedItems.length)];

    FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();
    await notifications.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/meme"),
      ),
    );
    notifications.show(
      2,
      "My app notification title",
      "This is the notification body",
      NotificationDetails(
        android: AndroidNotificationDetails(
          "channel_id",
          "Channel Name",
          importance: Importance.high,
          icon: "@mipmap/meme",
          styleInformation: BigTextStyleInformation(
            randomTip,
            contentTitle: "Don't forget to be grateful for",
            summaryText: "Well beingx",
          ),
        ),
      ),
    );}

    return Future.value(true);
  });

}