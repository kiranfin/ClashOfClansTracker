import 'package:flutter/material.dart';
import '../provider/DataProvider.dart' as DataProvider;
import '../utils/UserSP.dart';

class StartScreenPage extends StatefulWidget {
  const StartScreenPage({super.key});

  @override
  State<StartScreenPage> createState() => _StartScreenPageState();
}

class _StartScreenPageState extends State<StartScreenPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        leading: UserSP.getUser().isEmpty? Container() : IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Column(
                  children: [
                    UserSP.getUser().isEmpty? Text("Welcome!", style: const TextStyle(color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 35)) : Text(""),
                    Text("Account hinzufügen", style: const TextStyle(color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 20)
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}