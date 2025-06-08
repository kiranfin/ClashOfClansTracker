import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../utils/UserSP.dart';

class LeaguePage extends StatefulWidget {
  const LeaguePage({super.key});

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {

  final List<String> user = UserSP.getUser();
  String currentuser = UserSP.getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                ],
              ),
            ),
          )
      ),
    );
  }
}