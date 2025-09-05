import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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