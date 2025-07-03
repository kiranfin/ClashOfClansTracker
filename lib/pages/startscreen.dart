import 'package:flutter/material.dart';
import '../utils/UserSP.dart';

class StartScreenPage extends StatefulWidget {
  const StartScreenPage({super.key});

  @override
  State<StartScreenPage> createState() => _StartScreenPageState();
}

class _StartScreenPageState extends State<StartScreenPage> {

  final TextEditingController controller = TextEditingController();
  String? errorText = null;
  bool valid = false;
  String? value = null;

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: UserSP.getUser().isEmpty? Container() : IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back, color: Colors.white)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Column(
                    children: [
                      UserSP.getUser().isEmpty? Text("Welcome!", style: const TextStyle(color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 35)) : Text(""),
                      Text("Account hinzufügen", style: const TextStyle(color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 20)
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 70,
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                Icons.tag,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: controller,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    errorText: errorText,
                                    hintText: "#P9V29R8RJ"
                                  ),
                                  validator: (value) => errorText,
                                  onChanged: (val) {
                                    if (val.isEmpty) {
                                      setState(() {
                                        errorText = 'Tag eingeben';
                                        valid = false;
                                        value = null;
                                      });
                                    } else if (val.length == 10 && val[0] == "#") {
                                      setState(() {
                                        errorText = null;
                                        valid = true;
                                        value = val.substring(1);
                                      });
                                    } else if (val.length == 9) {
                                      setState(() {
                                        errorText = null;
                                        valid = true;
                                        value = val;
                                      });
                                    } else if(UserSP.getUser().contains(value)){
                                      setState(() {
                                        errorText = "Bereits hinzugefügt";
                                        valid = false;
                                        value = null;
                                      });
                                    } else {
                                      setState(() {
                                        errorText = 'Falsches Format';
                                        valid = false;
                                        value = val;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )
                              )
                            ),
                          onPressed: () {
                            if(valid) {
                              List<String> old = UserSP.getUser();
                              if (!old.contains(value!)) {
                                old.add(value!);
                                UserSP.setUsers(old);
                                UserSP.setCurrentUser(value!);
                                Navigator.popAndPushNamed(context, "/default");
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Hinzufügen", style: const TextStyle(color: Colors.white,
                              fontFamily: "Poppins"))
                            ],
                          )
                        )
                      )
                    ],
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}