import 'package:clashofclanstracker/pages/home.dart';
import 'package:clashofclanstracker/pages/settings.dart';
import 'package:clashofclanstracker/provider/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() async {
  await dotenv.load(fileName: "config.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF171717),
        useMaterial3: true,
      ),
      home: DefaultPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DefaultPage extends StatefulWidget {
  const DefaultPage({super.key});

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  final List<Widget> pages = [
    SettingsPage(),
    HomePage(),
    SettingsPage()
  ];

  int selectedindex = 1;

  void navigateBottomBar(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: pages[selectedindex]
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 15,
              top: 5,
              bottom: 20,
              right: 15
          ),
          child: GNav(
            selectedIndex: 1,
            color: Colors.white,
            backgroundColor: Colors.black,
            activeColor: Colors.white,
            hoverColor: Colors.grey.shade900,
            gap: 8,
            tabBackgroundColor: Colors.grey.shade900,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            padding: EdgeInsets.all(16),
            onTabChange: (index) {
              print(MediaQuery.of(context).size.width);
              navigateBottomBar(index);
            },
            tabs: [
              GButton(
                icon: Icons.question_mark,
                text: "League",
              ),
              GButton(
                icon: Icons.home,
                text: "Start",
              ),
              GButton(
                icon: Icons.settings,
                text: "Einstellungen",
              ),
            ],
          ),
        ),
      ),
    );
  }
}