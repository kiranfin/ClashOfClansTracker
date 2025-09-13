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
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 20),
                    child: Text("Account wechseln", style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25)),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 60.0,
                    width: MediaQuery.of(context).size.width - 2 * 20,
                    child: DropdownButton2(
                      isExpanded: true,
                      buttonStyleData: ButtonStyleData(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black,
                          ),
                          padding: const EdgeInsets.only(left: 10, right: 25)
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black,
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.arrow_drop_down_outlined),
                        iconSize: 24,
                        iconEnabledColor: Colors.white,
                      ),
                      items: user
                          .map<DropdownMenuItem<String>>(
                            (String user) => DropdownMenuItem<String>(
                          value: user,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(usermap[user], style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15)),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      List<String> userlist = UserSP.getUser();
                                      if(userlist.length > 1) {
                                        userlist.remove(user);
                                        UserSP.setUsers(userlist);
                                        if (UserSP.getCurrentUser() == user) UserSP.setCurrentUser(userlist[0]);
                                        Navigator.popAndPushNamed(context, "/default");
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.delete, color: Colors.redAccent)
                              )
                            ],
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: (String? user) {
                        setState(() {
                            currentuser = user ?? currentuser;
                            UserSP.setCurrentUser(currentuser);
                          },
                        );
                      },
                      underline: const SizedBox.shrink(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                      value: currentuser,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 60.0,
                    width: MediaQuery.of(context).size.width - 2 * 20,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.black),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )
                          )
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/start");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Account hinzufügen", style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15)),
                          Icon(Icons.add, size: 25)
                        ],
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