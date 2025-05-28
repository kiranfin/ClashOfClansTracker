import 'package:flutter/material.dart';
import '../provider/DataProvider.dart' as DataProvider;

class StartScreenPage extends StatefulWidget {
  const StartScreenPage({super.key});

  @override
  State<StartScreenPage> createState() => _StartScreenPageState();
}

class _StartScreenPageState extends State<StartScreenPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Column(
                children: [
                  Text("lol")
                ],
              ),
            ),
          )
      ),
    );
  }
}