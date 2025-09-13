import 'package:color_hex/color_hex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../theme.dart';
import 'UserSP.dart' hide ThemeType;

Widget getEditWallsDialog(BuildContext context, String inital) {
  String newval = inital;
  return Dialog(
      backgroundColor: const Color(0xFF252525),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width - 2 * 40,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Edit Walls", style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Inter",
                      fontSize: 20)),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onChanged: (value) {
                  newval = value;
                },
                initialValue: inital,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, newval);
                      },
                      child: Text("Ok", style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Inter",
                          fontSize: 15))
                  ),
                ],
              )
            ],
          ),
        ),
      ),
  );
}

Widget getImportJSONDialog(BuildContext context, String inital) {
  String newval = inital;
  return Dialog(
    backgroundColor: const Color(0xFF252525),
    child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width - 2 * 40,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Import Json", style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Inter",
                    fontSize: 20)),
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                newval = value;
              },
              initialValue: inital,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, newval);
                    },
                    child: Text("Ok", style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Inter",
                        fontSize: 15))
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget getColorPickDialog(BuildContext context) {
  return AlertDialog(
    title: Text('Accent Color', style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.surface)),
    content: SingleChildScrollView(
      child: ColorPicker(
        pickerColor: UserSP.getAccentColor().convertToColor,
        onColorChanged: (newColor) {
          UserSP.setAccentColor(newColor.convertToHex.hex!);
          Provider.of<ThemeProvider>(context, listen: false).setTheme(UserSP.getDarkTheme(), UserSP.getAccentColor().convertToColor);
        },
        enableAlpha: false,
        pickerAreaBorderRadius:
        const BorderRadius.all(Radius.circular(8)),
        labelTypes: const [],
      ),
    ),
    actions: [
      SizedBox(
        width: double.infinity,
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3),
          ),
          onPressed: () => Navigator.pop(context),
          child: Text('Done', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface)),
        ),
      ),
    ],
  );
}

Widget getAccountSwitchDialog(BuildContext context) {
  final List<String> user = UserSP.getUser();
  final Map<String, dynamic> usermap = UserSP.getDecodedUserMap();
  return DraggableScrollableSheet(
    expand: false,
    key: UniqueKey(),
    initialChildSize: 0.7,
    maxChildSize: 0.9,
    minChildSize: .5,
    builder: (context, controller) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('Acccount wechseln', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.surface)),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: user.length,
              itemBuilder: (BuildContext context, index) {
                String currentuser = user[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
                  child: ListTile(
                    tileColor: UserSP.getCurrentUser() == currentuser? Theme.of(context).colorScheme.surface.withValues(alpha: 0.3): Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
                    onTap: () {
                      currentuser = user[index];
                      UserSP.setCurrentUser(currentuser);
                      Navigator.pop(context, currentuser);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    title: Text(usermap[currentuser], style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface)),
                    trailing: IconButton(
                        onPressed: () {
                          List<String> userlist = UserSP.getUser();
                          if(userlist.length > 1) {
                            userlist.remove(currentuser);
                            UserSP.setUsers(userlist);
                            if (UserSP.getCurrentUser() == currentuser) UserSP.setCurrentUser(userlist[0]);
                            Navigator.popAndPushNamed(context, "/default");
                          }
                        },
                        icon: Icon(Icons.delete, color: Colors.redAccent)
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    ),
  );



    /*Column(
      children: [
        Text('Acccount wechseln', style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.surface)),
        ListView.builder(
            itemBuilder: (BuildContext context, index) {
              String currentuser = user[index];
              return ListTile(
                title: Text(usermap[currentuser], style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15)),
                trailing: IconButton(
                    onPressed: () {
                      List<String> userlist = UserSP.getUser();
                      if(userlist.length > 1) {
                        userlist.remove(currentuser);
                        UserSP.setUsers(userlist);
                        if (UserSP.getCurrentUser() == currentuser) UserSP.setCurrentUser(userlist[0]);
                        Navigator.popAndPushNamed(context, "/default");
                      }
                    },
                    icon: Icon(Icons.delete, color: Colors.redAccent)
                ),
              );
            }
        ),
      ]
  );*/
}