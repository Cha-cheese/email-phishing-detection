import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  List<Map<String, dynamic>> emails = [];
  List<Map<String, dynamic>> filteredEmails = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchEmails();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchEmails() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/gmail'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          emails = data.map((email) {
            return {
              'sender': email['sender'],
              'subject': email['subject'],
              'time': email['time'],
              'body': email['body'] ?? '',
              'status': email['status'] ?? 'Safe',
            };
          }).toList();
          filteredEmails = List.from(emails);
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        throw Exception('Failed to load emails');
      }
    } catch (error) {
      setState(() => isLoading = false);
      print('Error fetching emails: $error');
    }
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredEmails = emails.where((email) {
        final sender = email['sender'].toLowerCase();
        final subject = email['subject'].toLowerCase();
        final time = email['time'].toLowerCase();
        return sender.contains(query) || subject.contains(query) || time.contains(query);
      }).toList();
    });
  }

  void handleEmailTap(Map<String, dynamic> email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(email['sender']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Subject: ${email['subject']}"),
              Text("Time: ${email['time']}"),
              Text("Status: ${email['status']}"),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
            if (email['status'] == 'Safe')
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SafeEmailDetail(email: email)),
                  );
                },
                child: const Text('View'),
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 159, 188, 242),
        title: Center(
          child: Image.asset('assets/images/minilogo.png', width: 60, height: 60),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
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
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
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
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : filteredEmails.isEmpty
                        ? const Center(
                            child: Text(
                              'No results found.',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )
                        : ListView.builder(
                            itemCount: filteredEmails.length,
                            itemBuilder: (context, index) {
                              final email = filteredEmails[index];
                              return SizedBox(
                                height: 70,
                                child: GestureDetector(
                                  onTap: () => handleEmailTap(email),
                                  child: Card(
                                    child: Row(
                                      children: [
                                        const Expanded(flex: 2, child: Icon(Icons.email, size: 40)),
                                        Expanded(
                                          flex: 9,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 6.0),
                                                child: Text(
                                                  email['sender'],
                                                  style: const TextStyle(fontSize: 18),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                  color: email['status'] == 'Risk' ? Colors.red : Colors.green,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  email['status'],
                                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 12.0, right: 16.0),
                                            child: Text(
                                              email['time'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SafeEmailDetail extends StatelessWidget {
  final Map<String, dynamic> email;
  const SafeEmailDetail({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(email['subject']), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("From: ${email['sender']}", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text("Time: ${email['time']}", style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 20),
              Text(email['body'], style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
