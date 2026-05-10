import 'package:flutter/material.dart';

void main() {
  runApp(const ConverterApp());
}

/// Main Application Widget
class ConverterApp extends StatelessWidget {
  const ConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

/// Home Screen
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _inputController = TextEditingController();

  String result = "";
  String selectedConversion = "C to F";

  final List<String> options = [
    "C to F",
    "F to C",
    "Km to Miles",
    "Miles to Km"
  ];

  /// Main conversion function
  void convert() {
    double input = double.tryParse(_inputController.text) ?? 0;

    double output;

    switch (selectedConversion) {
      case "C to F":
        output = (input * 1.8) + 32;
        result = "${output.toStringAsFixed(2)} °F";
        break;

      case "F to C":
        output = (input - 32) / 1.8;
        result = "${output.toStringAsFixed(2)} °C";
        break;

      case "Km to Miles":
        output = input * 0.621371;
        result = "${output.toStringAsFixed(2)} miles";
        break;

      case "Miles to Km":
        output = input / 0.621371;
        result = "${output.toStringAsFixed(2)} km";
        break;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unit Converter"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Enter Value",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Select Conversion Type",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: selectedConversion,
              items: options.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedConversion = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: convert,
              child: const Text("Convert"),
            ),

            const SizedBox(height: 30),

            Text(
              result,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}