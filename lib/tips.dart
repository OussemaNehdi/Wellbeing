import 'package:flutter/material.dart';
import 'dart:math';

class Tips extends StatefulWidget {
  const Tips({super.key});

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  String _tip =
      'Loading...'; //added the loading just to make the experience better and give users a sense of
  // being excited for a tip while waiting

  @override
  void initState() {
    super.initState();
    _getRandomTip();
  }

  Future<void> _getRandomTip() async {
    //todo make 100 tips isntead
    // Simulate fetching a random tip from a data source
    await Future.delayed(
        const Duration(seconds: 1)); // Added a slight delay to make it more fun
    final tips = [
      'Prioritize adequate sleep each night for improved mental resilience.',
      'Practice deep breathing exercises to reduce stress and promote relaxation.',
      'Engage in regular physical activity to boost mood and reduce anxiety.',
      'Establish a daily routine to provide structure and stability.',
      'Set realistic goals and break them down into manageable tasks.',
      'Cultivate a positive mindset by focusing on gratitude and positive affirmations.',
      'Limit screen time and take breaks to prevent digital fatigue.',
      'Foster meaningful connections with friends and family.',
      'Practice mindfulness meditation to enhance self-awareness.',
      'Seek professional help when needed; therapy can be beneficial for mental health.',
      'Embrace hobbies and activities that bring joy and fulfillment.',
      'Eat a balanced diet rich in fruits, vegetables, and whole grains.',
      'Learn to say no and set healthy boundaries to manage stress.',
      'Challenge negative thoughts and reframe them in a more positive light.',
      'Spend time in nature to reduce stress and boost mood.',
      'Stay hydrated throughout the day for optimal cognitive function.',
      'Practice self-compassion and treat yourself with kindness.',
      'Foster a sense of purpose by engaging in activities that align with your values.',
      'Limit caffeine and alcohol intake for better sleep and mood regulation.',
      'Develop problem-solving skills to cope with challenges effectively.',
      'Schedule regular breaks to rest and recharge during work or study sessions.',
      'Engage in creative outlets to express emotions and thoughts.',
      'Volunteer or contribute to your community for a sense of purpose.',
      'Build a support system and communicate openly with loved ones.',
      'Listen to music or engage in activities that bring relaxation.',
      'Practice time management to reduce feelings of overwhelm.',
      'Learn and use stress-reducing techniques like progressive muscle relaxation.',
      'Take breaks from news and social media to avoid information overload.',
      'Cultivate a healthy work-life balance for overall well-being.',
      'Practice self-reflection to understand and learn from life experiences.',
      'Surround yourself with positive influences and supportive people.',
      'Set realistic expectations for yourself and others.',
      'Engage in acts of kindness to boost your mood and sense of connection.',
      'Establish a consistent sleep schedule for better sleep quality.',
      'Use positive visualization to focus on future success and happiness.',
      'Journal your thoughts and emotions as a form of self-expression.',
      'Attend social gatherings or events to build a sense of community.',
      'Develop resilience by embracing setbacks as opportunities for growth.',
      'Practice good posture to support physical and mental well-being.',
      'Take time for hobbies that provide a sense of achievement.',
      'Learn and practice effective communication skills in relationships.',
      'Stay curious and open-minded, embracing a growth mindset.',
      'Practice forgiveness to release resentment and promote inner peace.',
      'Schedule regular health check-ups to address any physical concerns.',
      'Engage in activities that bring laughter and joy into your life.',
      'Set boundaries on work-related activities outside of designated hours.',
      'Allow yourself breaks during the day to prevent burnout.',
      'Express gratitude daily to enhance your overall outlook on life.',
      'Attend workshops or classes to continuously learn and grow.',
      'Embrace imperfection and focus on progress rather than perfection.',
      'Identify and challenge negative self-talk for improved self-esteem.',
      'Establish a bedtime routine to signal your body that it\'s time to wind down.',
      'Engage in hobbies that involve mindfulness, such as yoga or gardening.',
      'Develop coping strategies for managing stress, such as visualization techniques.',
      'Practice time outdoors to receive the mental health benefits of sunlight.',
      'Limit exposure to toxic relationships and nurture positive connections.',
      'Celebrate small victories and achievements regularly.',
      'Foster a sense of humor to navigate challenges with a lighter perspective.',
      'Set aside time for hobbies that bring comfort and relaxation.',
      'Create a self-care toolkit with activities that bring comfort and relaxation.',
      'Practice progressive relaxation techniques to release muscle tension.',
      'Engage in activities that promote a sense of accomplishment and mastery.',
      'Cultivate a sense of curiosity and wonder about the world around you.',
      'Establish and maintain healthy boundaries in relationships.',
      'Explore and express your creativity through art, writing, or music.',
      'Challenge negative self-talk by replacing it with positive affirmations.',
      'Set realistic and achievable goals to build a sense of accomplishment.',
      'Develop a hobby or skill that provides a sense of purpose.',
      'Practice assertiveness in communication to express your needs and boundaries.',
      'Cultivate a positive and supportive internal dialogue.',
      'Practice self-reflection to gain insight into your thoughts and behaviors.',
      'Connect with nature regularly for a sense of grounding and tranquility.',
      'Explore relaxation techniques such as guided imagery or progressive muscle relaxation.',
      'Engage in activities that bring a sense of nostalgia and joy.',
      'Set aside time for activities that bring a sense of playfulness and fun.',
      'Remember that seeking help is a sign of strength, not weakness.'
    ]; //100 tipsfor mental health
    setState(() {
      _tip = tips[Random().nextInt(tips.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Image.asset(
                'assets/images/meme.png',
                width: 150,
                height: 100,
              ),
            ),
            Text(
              'Your daily dose of',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Text("Well being tips", style: TextStyle(fontSize: 19)),
            const SizedBox(height: 30.0),
            Card(
              color: Color.fromRGBO(31, 17, 55, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  _tip,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
