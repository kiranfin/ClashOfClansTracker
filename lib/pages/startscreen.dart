import 'package:flutter/material.dart';
import '../utils/UserSP.dart';

class StartScreenPage extends StatefulWidget {
  const StartScreenPage({super.key});

  @override
  State<StartScreenPage> createState() => _StartScreenPageState();
}

class _StartScreenPageState extends State<StartScreenPage> {

  final TextEditingController controller = TextEditingController();
  String? errorText;
  bool valid = false;
  String? value;

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: UserSP.getUser().isEmpty? Container() : IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiary)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Column(
                    children: [
                      UserSP.getUser().isEmpty? Text("Welcome!", style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 35)) : Text(""),
                      Text("Account hinzufügen", style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface)),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 70,
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).colorScheme.surface,
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.tag, color: Theme.of(context).colorScheme.primary),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: controller,
                                  keyboardType: TextInputType.emailAddress,
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                                  decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
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
                            backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3)),
                            shape: WidgetStateProperty.all<
                              RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )
                              )
                            ),
                          onPressed: () {
                            if(valid) {
                              List<String> old = UserSP.getUser();
                              Map<String, dynamic> oldmap = UserSP.getDecodedUserMap();
                              if (!old.contains(value!)) {
                                old.add(value!);
                                oldmap[value!] = "-";
                                UserSP.setUsers(old);
                                UserSP.setUserMap(oldmap);
                                UserSP.setCurrentUser(value!);
                                Navigator.popAndPushNamed(context, "/default");
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Hinzufügen", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface)),
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