import 'dart:convert';
import 'dart:io';
import 'package:clashofclanstracker/pages/detail.dart';
import 'package:clashofclanstracker/pages/home.dart';
import 'package:clashofclanstracker/pages/league.dart';
import 'package:clashofclanstracker/pages/settings.dart';
import 'package:clashofclanstracker/pages/startscreen.dart';
import 'package:clashofclanstracker/provider/DataProvider.dart' as DataProvider;
import 'package:clashofclanstracker/utils/UserSP.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSP.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        useMaterial3: true,
      ),
      home: UserSP.getUser().isEmpty? StartScreenPage() : DefaultPage(1),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/default':
            return PageTransition(child: const DefaultPage(1), type: PageTransitionType.fade);
          case '/home':
            return PageTransition(child: const HomePage(), type: PageTransitionType.fade);
          case '/detail':
            return PageTransition(child: const DetailPage(), type: PageTransitionType.fade, settings: settings);
          case '/start':
            return PageTransition(child: const StartScreenPage(), type: PageTransitionType.fade);
        }
        return null;
      }
    );
  }
}

class DefaultPage extends StatefulWidget {
  const DefaultPage(this.pageindex, {super.key});

  final int pageindex;

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  final List<Widget> pages = [
    LeaguePage(),
    HomePage(),
    SettingsPage()
  ];

  int selectedindex = 1;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedindex = widget.pageindex;
    });
  }

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
              navigateBottomBar(index);
            },
            tabs: [
              GButton(
                icon: Icons.emoji_events,
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