import 'package:flutter/material.dart';
import 'package:survey_app/view/home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../surveys/current_survey.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // List of screens for each tab
  final List<Widget> _screens = [
    HomeScreen(),  // Home screen will show the survey count
    SurveyForm(),  // SurveyForm screen to fill out the survey
    ProfileScreen(),  // If you have a profile screen, you can add it here
  ];

  // Method to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Update the selected tab index
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',  // This will show the survey count
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            label: 'Survey',  // This will take you to th survey form
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',  // Profile tab (if implemented)
          ),
        ],
      ),
    );
  }
}
