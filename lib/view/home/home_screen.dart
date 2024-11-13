import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _surveyCount = 0;

  @override
  void initState() {
    super.initState();
    _loadSurveyCount();
  }

  // Load the survey count from SharedPreferences
  void _loadSurveyCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _surveyCount = prefs.getInt('survey_count') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Survey App"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Surveys Completed:",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              "$_surveyCount",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
