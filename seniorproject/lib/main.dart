import 'dart:io'; // For Platform
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_links/app_links.dart';
import 'email.dart';
import 'help.dart';
import 'report.dart';
import 'url.dart';
import 'loginpage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 159, 188, 242),
      ),
      home: const PolicyScreen(), // Start with policy screen
    );
  }
}

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  bool _hasNavigated = false; // ตรวจสอบว่าได้เปลี่ยนหน้าแล้วหรือยัง
  final AppLinks appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showPolicyDialog());
    _initAppLinks();
  }

  void _showPolicyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              child: const Text('I Agree'),
            ),
            TextButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _initAppLinks() async {
    try {
      // Check the initial link when the app is opened
      final initialLink = await appLinks.getInitialLink();
      if (initialLink != null && !_hasNavigated) {
        final initialLinkString =
            initialLink.toString(); // Convert Uri to String
        if (initialLinkString.contains('callback')) {
          setState(() {
            _hasNavigated = true; // Set to true when navigation happens
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainScreen()),
          );
        }
      }

      // Listen for incoming app links
      appLinks.uriLinkStream.listen((Uri? link) {
        if (link != null && !_hasNavigated) {
          final linkString = link.toString(); // Convert Uri to String
          if (linkString.contains('callback')) {
            setState(() {
              _hasNavigated = true; // Set to true when navigation happens
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      const MainScreen()), // Go to the main screen after callback
            );
          }
        }
      });
    } catch (error) {
      print('Error initializing app links: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: const Color.fromARGB(255, 129, 162, 223),
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
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
            color: Color.fromARGB(255, 102, 121, 146),
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
