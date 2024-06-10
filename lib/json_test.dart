import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Json-Abfrage',
      home: JsonQueryScreen(),
    );
  }
}

class JsonQueryScreen extends StatefulWidget {
  const JsonQueryScreen({super.key});

  @override
  _JsonQueryScreenState createState() => _JsonQueryScreenState();
}

class _JsonQueryScreenState extends State<JsonQueryScreen> {
  final String jsonFile = """
{
  "ip": "161.185.160.93",
  "city": "New York City",
  "region": "New York",
  "country": "US",
  "loc": "40.7143,-74.0060",
  "org": "AS22252 The City of New York",
  "postal": "10001",
  "timezone": "America/New_York",
  "readme": "https://ipinfo.io/missingauth"
}
""";

  String? selectedParameter;
  Map<String, dynamic> jsonMap = {};
  String result = "";

  @override
  void initState() {
    super.initState();
    jsonMap = jsonDecode(jsonFile);
    selectedParameter = "ip";
    result = jsonMap[selectedParameter!] ?? "Nicht verfügbar";
  }

  void updateResult() {
    setState(() {
      result = jsonMap[selectedParameter!] ?? "Nicht verfügbar";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Json-Abfrage'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedParameter,
              onChanged: (String? newValue) {
                setState(() {
                  selectedParameter = newValue!;
                });
                updateResult();
              },
              items: jsonMap.keys.map<DropdownMenuItem<String>>((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(key),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Ergebnis: $result",
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
