import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart'; //launch the call after requesting permission
import 'package:animated_text_kit/animated_text_kit.dart';

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('Your ',
                    textStyle: const TextStyle(fontSize: 35)),
                TyperAnimatedText('Well-being ',
                    textStyle: const TextStyle(
                        fontSize: 35, color: Colors.deepPurple)),
                TyperAnimatedText('Matters.',
                    textStyle: const TextStyle(fontSize: 35)),
                TyperAnimatedText('Your life matters.',
                    textStyle: const TextStyle(fontSize: 35)),
                TyperAnimatedText('Your existence matters.',
                    textStyle: const TextStyle(fontSize: 35)),
              ],
              onTap: () {},
              repeatForever: false,
              totalRepeatCount: 1,
            ),
          ),
          const SizedBox(height: 30),
          Card(
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Emergency Numbers (Tunisia)',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                    children: [//a class to make the simple call widget
                      _buildEmergencyItem(
                          '7133', Icons.supervisor_account, 'HelpCN'),
                      _buildEmergencyItem(
                        '190',
                        Icons.local_fire_department,
                        'Fire',
                      ),
                      _buildEmergencyItem(
                        '198',
                        Icons.local_hospital,
                        'Medical',
                      ),
                      _buildEmergencyItem(
                        '197',
                        Icons.local_police,
                        'Police',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyItem(String number, IconData icon, String description) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.black),
      onPressed: () async {
        // here we do the phone call with async
        await _makePhoneCall(number);
      },
      child: Row(
        children: [
          Icon(icon, size: 32.0),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String number) async {//launch the phone call
    if (await Permission.phone.request().isGranted) {
      await launch('tel:$number'); //launch is deprciated
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone call permission denied')),
      );
    }
  }
}
