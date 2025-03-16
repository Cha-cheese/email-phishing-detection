import 'package:flutter/material.dart';
import 'detailemail.dart'; // นำเข้าไฟล์ Detailemail

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final List<Map<String, String>> emails = [
    {'sender': 'Thai Tour Partnership', 'status': 'No data', 'time': '9:41 AM'},
    {'sender': 'Maha Settee', 'status': 'Risk', 'time': '9:41 AM'},
    {'sender': 'Pipo Employment', 'status': 'No url', 'time': '9:41 AM'},
  ];

  List<Map<String, String>> filteredEmails = [];

  @override
  void initState() {
    super.initState();
    filteredEmails = emails;
  }

  void showPopup(Map<String, String> email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(email['sender']!),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Status: ${email['status']}"),
              Text("Time: ${email['time']}"),
            ],
          ),
          actions: <Widget>[
            if (email['status'] == 'No url')
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detailemail(email: email), 
                    ),
                  );
                },
                child: const Text('View Details'),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void searchEmail(String query) {
    final filtered = emails.where((email) {
      final sender = email['sender']!.toLowerCase();
      final input = query.toLowerCase();
      return sender.contains(input);
    }).toList();

    setState(() {
      filteredEmails = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B263B),
        title: Center(
          child: Image.asset(
            'assets/images/minilogo.png',
            width: 60,
            height: 60,
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
              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: 380,
                  height: 40,
                  child: TextField(
                    onChanged: searchEmail,
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: const Icon(Icons.search),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: filteredEmails.map((email) {
                    return SizedBox(
                      height: 70,
                      width: 500,
                      child: GestureDetector(
                        onTap: () => showPopup(email),
                        child: Card(
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.email,
                                    size: 40,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: Text(
                                        email['sender']!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0, horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        color: email['status'] == 'Risk'
                                            ? Colors.red
                                            : email['status'] == 'No url'
                                                ? Colors.blue
                                                : Colors.orange,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        email['status']!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, right: 16.0),
                                  child: Column(
                                    children: [
                                      Text(email['time']!),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
