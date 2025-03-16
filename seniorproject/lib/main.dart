import 'dart:io'; // Import for exit(0)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seniorproject/email.dart';
import 'package:seniorproject/help.dart';
import 'package:seniorproject/report.dart';
import 'package:seniorproject/url.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1B263B),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPolicyDialog();
    });
  }

  void _showPolicyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Privacy Policy'),
          content: const Text(
            'By using this app, you agree to our privacy policy. Please read it carefully.',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('I Agree'),
            ),
            TextButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop(); // Closes the app on Android
                } else if (Platform.isIOS) {
                  exit(0); // Closes the app on iOS
                }
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    Email(),
                    Report(),
                    Url(),
                    Help(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF778DA9),
            border: Border(
              top: BorderSide(color: Colors.white, width: 2),
            ),
          ),
          child: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(icon: Icon(Icons.email), text: "Email"),
              Tab(icon: Icon(Icons.poll), text: "Report"),
              Tab(icon: Icon(Icons.link), text: "URL"),
              Tab(icon: Icon(Icons.help), text: "Help"),
            ],
          ),
        ),
      ),
    );
  }
}
