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
    title: Text('Accent color', style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.surface)),
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