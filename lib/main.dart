import 'dart:convert';
import 'dart:io';
import 'package:clashofclanstracker/pages/detail.dart';
import 'package:clashofclanstracker/pages/home.dart';
import 'package:clashofclanstracker/pages/league.dart';
import 'package:clashofclanstracker/pages/settings.dart';
import 'package:clashofclanstracker/pages/startscreen.dart';
import 'package:clashofclanstracker/provider/DataProvider.dart' as DataProvider;
import 'package:clashofclanstracker/theme.dart';
import 'package:clashofclanstracker/utils/UserSP.dart';
import 'package:color_hex/color_hex.dart';
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
    final themes = CoCTrackerThemes(colorSeed: UserSP.getAccentColor().convertToColor);
    print(themes.colorSeed);
    return MaterialApp(
      theme: themes.light,
      darkTheme: themes.dark,
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15,
                top: 5,
                bottom: 20,
                right: 15
            ),
            child: GNav(
              selectedIndex: 1,
              color: Theme.of(context).colorScheme.surface,
              backgroundColor: Theme.of(context).colorScheme.primary,
              activeColor: Theme.of(context).colorScheme.surface,
              hoverColor: Colors.grey.shade900,
              gap: 8,
              tabBackgroundColor: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3),
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              padding: EdgeInsets.all(16),
              onTabChange: (index) {
                navigateBottomBar(index);
              },
              tabs: [
                GButton(
                  icon: Icons.emoji_events,
                  iconColor: Theme.of(context).colorScheme.tertiary,
                  iconActiveColor: Theme.of(context).colorScheme.tertiary,
                  text: "League",
                  textStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
                GButton(
                  icon: Icons.home,
                  iconColor: Theme.of(context).colorScheme.tertiary,
                  iconActiveColor: Theme.of(context).colorScheme.tertiary,
                  text: "Start",
                  textStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
                GButton(
                  icon: Icons.settings,
                  iconColor: Theme.of(context).colorScheme.tertiary,
                  iconActiveColor: Theme.of(context).colorScheme.tertiary,
                  text: "Einstellungen",
                  textStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}