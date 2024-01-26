import 'package:flutter/material.dart';
import 'tips.dart';
import 'grateful.dart';
import 'mood.dart';
import 'emergency.dart';

//

Widget myCustomNav(int page) {
  if (page == 0) {
    return Grateful();
  }

  if (page == 1) {
    return Mood();
  }

  if (page == 2) {
    return Tips();
  } else {
    return Emergency();
  }
}
