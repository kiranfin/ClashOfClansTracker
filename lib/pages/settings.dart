import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../utils/UserSP.dart';
import '../utils/Utils.dart' as Utils;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final List<String> usermap = UserSP.getUser();
  String currentuser = UserSP.getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [/*Color(0xFF1C2952)*/Color(0xFF171717), /*Color(0xFF101E6B)*/Color(0xFF171717)]
          )
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 20),
                    child: Text("Account wechseln", style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
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
                      items: usermap
                          .map<DropdownMenuItem<String>>(
                            (String user) => DropdownMenuItem<String>(
                          value: user,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("#$user", style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 15)),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      List<String> userlist = UserSP.getUser();
                                      userlist.remove(user);
                                      UserSP.setUsers(userlist);
                                      if(UserSP.getCurrentUser() == user) UserSP.setCurrentUser(userlist[0]);
                                      Navigator.popAndPushNamed(context, "/default");
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
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                              fontFamily: "Poppins",
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