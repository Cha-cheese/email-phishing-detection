import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1B263B),
        title: Center(
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/minilogo.png',
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Text('Lorem')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
