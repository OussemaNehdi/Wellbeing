import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mood extends StatefulWidget {
  const Mood({super.key});

  @override
  State<Mood> createState() => _MoodState();
}

class _MoodState extends State<Mood> {
  int j = 0;

  List<int> xValues = [1, 2, 3, 4, 5];
  List<int> yValues = [3, 5, 0, 2, 1]; //theese two lists are a demo
  List<ChartData> chartData = []; //the real data

  double moodRating = 0;

  Future<void> chart_animation() async {
    //to show the real data after showing the demo
    await Future.delayed(Duration(milliseconds: 1800));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? chartDataStrings;
    chartDataStrings = prefs.getStringList("chartData");
    int i = 0;
    chartData = [];
    if (chartDataStrings != null) {
      chartDataStrings.forEach((element) {
        chartData.add(ChartData(x: i, y: double.parse(element).round()));
        i++;
      });
    }
    setState(() {
      // set the real chart data
    });
  }

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < xValues.length; i++) {
      chartData.add(
          ChartData(x: xValues[i], y: yValues[i])); //fill with the demo data
    }
    chart_animation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              RatingBar.builder(
                  initialRating: moodRating,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.deepPurple,
                        );

                      case 1:
                        return Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                      case 2:
                        return Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 3:
                        return Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 4:
                        return Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        );
                      case 5:
                        return Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                      default:
                        return Icon(Icons.add);
                    }
                  },
                  onRatingUpdate: (rating) {
                    moodRating = rating;
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    List<String> chartDataStrings = [];

                    for (j = 0; j < chartData.length; j++) {
                      chartDataStrings.add((chartData[j].y).toString());
                    }

                    chartDataStrings.add(moodRating.toString());
                    prefs.setStringList("chartData", chartDataStrings);
                    setState(() {
                      chartData.add(ChartData(x: j, y: moodRating.toInt()));
                    });
                  },
                  child: Text(
                    "Track Mood",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(31, 17, 55, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        StatefulBuilder(builder: (context, setState) {
          return SfCartesianChart(
            primaryXAxis: NumericAxis(),
            primaryYAxis: NumericAxis(
              interval: 1,
              labelFormat: '{value}',
            ),
            series: <AreaSeries<ChartData, int>>[
              AreaSeries<ChartData, int>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                markerSettings: MarkerSettings(isVisible: true),
                color: Color.fromRGBO(31, 17, 55, 1),
              ),
            ],
          );
        }),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                  '\"Navigate your emotions, each mood shapes your well-being canvas.\"',
                  textStyle: const TextStyle(fontSize: 17)),
            ],
            onTap: () {},
            repeatForever: false,
            totalRepeatCount: 1,
          ),
        )
      ],
    );
  }
}

class ChartData {
  final int x; //x axis
  final int y; //y axis which is the mood rating

  ChartData({required this.x, required this.y});
}
