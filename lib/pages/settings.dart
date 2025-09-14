import 'package:clashofclanstracker/theme.dart' hide ThemeType;
import 'package:color_hex/color_hex.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/Presets.dart' as Presets;
import '../utils/UserSP.dart';
import '../utils/Utils.dart' as Utils;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final List<String> user = UserSP.getUser();
  final Map<String, dynamic> usermap = UserSP.getDecodedUserMap();
  String currentuser = UserSP.getCurrentUser();
  ThemeType darktheme = UserSP.getDarkTheme()? ThemeType.dark : ThemeType.light;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]
          )
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.secondaryContainer],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Appearance",
                              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                            ),
                            SizedBox(height: 5),
                            Center(
                              child: SegmentedButton(
                                style: SegmentedButton.styleFrom(
                                  foregroundColor: Theme.of(context).colorScheme.surface,
                                  selectedBackgroundColor: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3),
                                  selectedForegroundColor: Theme.of(context).colorScheme.tertiary,
                                ),
                                segments: [
                                  ButtonSegment(icon: Icon(Icons.sunny, color: Theme.of(context).colorScheme.surface), label: Text("Light", style: TextStyle(
                                      fontSize: 15)), value: ThemeType.light
                                  ),
                                  ButtonSegment(icon: Icon(Icons.mode_night, color: Theme.of(context).colorScheme.surface), label: Text("Dark", style: TextStyle(
                                      fontSize: 15)), value: ThemeType.dark
                                  ),
                                ],
                                onSelectionChanged: (Set<ThemeType> newSelection) {
                                  setState(() {
                                    darktheme = newSelection.first;
                                    UserSP.setDarkTheme(darktheme == ThemeType.dark? true : false);
                                    Provider.of<ThemeProvider>(context, listen: false).setTheme(darktheme == ThemeType.dark? true : false, UserSP.getAccentColor().convertToColor);
                                  });
                                },
                                selected: <ThemeType>{darktheme},
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Accent Color",
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                          builder: (BuildContext context) {
                                            return Presets.getColorPickDialog(context);
                                          }
                                      );
                                    },
                                    icon: DecoratedBox(
                                      position: DecorationPosition.foreground,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          width: 2,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: UserSP.getAccentColor().convertToColor,
                                        radius: 16,
                                      ),
                                    ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.secondaryContainer],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Account",
                              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                            ),
                            ListTile(
                              title: Text(usermap[currentuser]),
                              trailing: const Icon(Icons.chevron_right_rounded),
                              onTap: () async {
                                String? newuser = await showModalBottomSheet(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Presets.getAccountSwitchDialog(context);
                                    }
                                );
                                if(newuser != null) {
                                  setState(() {
                                    currentuser = newuser;
                                  });
                                }
                              },
                            ),
                            ListTile(
                              title: Text("Account hinzufügen"),
                              trailing: const Icon(Icons.add),
                              onTap: () async {
                                Navigator.pushNamed(context, "/start");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
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