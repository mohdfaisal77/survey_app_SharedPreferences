import 'package:flutter/material.dart';

import '../login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  // Add the navigation to LoginScreen here
  void _signOut(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app), // Icon for sign out button
            onPressed: () => _signOut(context), // Trigger the sign-out function
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("Name : Mohd Faisal"),
          ),
          SizedBox(height: 20),
          Center(
            child: Text("Address : Malihabad Lucknow"),
          ),
          SizedBox(height: 20),
          Center(
            child: Text("User Logged In successfully"),
          ),
        ],
      ),
    );
  }
}

