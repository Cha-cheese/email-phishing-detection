import 'package:flutter/material.dart';
import 'package:seniorproject/URL.dart';
import 'package:seniorproject/email.dart';
import 'package:seniorproject/help.dart';
import 'package:seniorproject/report.dart';

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
        scaffoldBackgroundColor: Color.fromARGB(255, 27, 38, 59),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: [
            Email(),
            Report(),
            Url(),
            Help(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color(0xFF778DA9),
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.email), text: "Email"),
              Tab(icon: Icon(Icons.poll), text: "Report"),
              Tab(icon: Icon(Icons.link), text: "URL"),
              Tab(icon: Icon(Icons.help), text: "Help"),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
      ),
    );
  }
}
