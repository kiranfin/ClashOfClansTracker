import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashofclanstracker/utils/img/ShortAsset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import '../provider/DataProvider.dart' as DataProvider;
import '../utils/Presets.dart' as Presets;
import '../utils/UserSP.dart';
import '../utils/Utils.dart' as Utils;

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  String userTag = UserSP.getCurrentUser();
  late String category = ModalRoute.of(context)!.settings.arguments as String;

  late Map<String, dynamic> walls = {};
  late Map<String, dynamic> defenses = {};
  late Map<String, dynamic> traps = {};
  late Map<String, dynamic> armybuildings = {};
  late Map<String, dynamic> resources = {};

  void loadData(int thlevel, Map<String, dynamic> buildings) {
    var wallsString = UserSP.getUserWalls(userTag);
    walls = wallsString != null? Map<String, dynamic>.from(jsonDecode(wallsString)) : Utils.getDefaultWalls(thlevel, buildings);
    var defensesString = UserSP.getUserDefenses(userTag);
    defenses = defensesString != null? Map<String, dynamic>.from(jsonDecode(defensesString)) : Utils.getDefaultDefenses(thlevel, buildings);
    var trapsString = UserSP.getUserTraps(userTag);
    traps = trapsString != null? Map<String, dynamic>.from(jsonDecode(trapsString)) : Utils.getDefaultTraps(thlevel, buildings);
    var armyString = UserSP.getUserArmyBuildings(userTag);
    armybuildings = armyString != null? Map<String, dynamic>.from(jsonDecode(armyString)) : Utils.getDefaultArmyBuildings(thlevel, buildings);
    var resourcesString = UserSP.getUserResourceBuildings(userTag);
    resources = resourcesString != null? Map<String, dynamic>.from(jsonDecode(resourcesString)) : Utils.getDefaultResources(thlevel, buildings);
  }

  void updateWalls(Map<String, dynamic> newdata) async {
    setState(() {
      walls = newdata;
    });
    UserSP.setUserWalls(userTag, jsonEncode(newdata));
  }

  void updateDefenses(Map<String, dynamic> newdata) async {
    setState(() {
      defenses = newdata;
    });
    UserSP.setUserDefenses(userTag, jsonEncode(newdata));
  }

  void updateTraps(Map<String, dynamic> newdata) async {
    setState(() {
      traps = newdata;
    });
    UserSP.setUserTraps(userTag, jsonEncode(newdata));
  }

  void updateArmyBuildings(Map<String, dynamic> newdata) async {
    setState(() {
      armybuildings = newdata;
    });
    UserSP.setUserArmyBuildings(userTag, jsonEncode(newdata));
  }

  void updateResources(Map<String, dynamic> newdata) async {
    setState(() {
      resources = newdata;

    });
    UserSP.setUserResourceBuildings(userTag, jsonEncode(newdata));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: category == "buildings"? getBuildingDetail() : category == "troops" ? getTroopDetail() : category == "spells"?
          getSpellDetail() : category == "heroes"? getHeroesDetail() : category == "equipment"?
          getEquipmentDetail() : category == "achievements"? getAchievementDetails() : category == "profile"? getProfileDetails() : null,
        ),
      ),
    );
  }

  Widget getBuildingDetail() {
    return FutureBuilder(
        future: Future.wait([DataProvider.awaitPlayerData(userTag), DataProvider.awaitBuildings()]),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            List titles = ["Walls", "Defense", "Traps", "Army", "Resources"];
            loadData(snapshot.data[0]["townHallLevel"], snapshot.data[1]);
            List<Map<String, dynamic>> finalmaplist = [];
            finalmaplist.add(walls);
            Map<String, dynamic> copymap = {};
            snapshot.data[0]["townHallWeaponLevel"] != null? copymap["${Utils.getTownHallWeapon(snapshot.data[0]["townHallLevel"])}-0"] = snapshot.data[0]["townHallWeaponLevel"] : null;
            copymap.addAll(defenses);
            snapshot.data[0]["townHallWeaponLevel"] != null?defenses["${Utils.getTownHallWeapon(snapshot.data[0]["townHallLevel"])}-0"] = snapshot.data[0]["townHallWeaponLevel"] : null;
            finalmaplist.add(copymap);
            finalmaplist.add(traps);
            finalmaplist.add(armybuildings);
            finalmaplist.add(resources);
            return ListView.builder(
              itemCount: titles.length,
                itemBuilder: (BuildContext context, int ind) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ind == 0? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          color: Colors.black,
                          child: GridTile(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DataProvider.awaitTownHallIcon(snapshot.data[0]["townHallLevel"], 1.5),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Townhall ${snapshot.data[0]["townHallLevel"]}", style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontSize: 30)),
                                      snapshot.data[0]["townHallWeaponLevel"] != null? Text("Level ${snapshot.data[0]["townHallWeaponLevel"]}", style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontSize: 18)) : SizedBox(height: 5),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ) : const SizedBox(height: 1),
                      ind == 0? const SizedBox(height: 20) : const SizedBox(height: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(titles[ind], style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 30)
                          ),
                          ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(Colors.white24),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        side: BorderSide(color: Colors.white24)
                                    )
                                )
                            ),
                            onPressed: () {
                              Map<String, dynamic> newdata = finalmaplist[ind];
                              if(ind == 0) {
                                newdata.clear();
                                newdata["wall-${Utils.getMaxWallsMaxLevel(snapshot.data[0]["townHallLevel"], snapshot.data[1])}"] = Utils.getMaxWalls(snapshot.data[0]["townHallLevel"], snapshot.data[1]);
                                updateWalls(newdata);
                              } else if(ind == 1) {
                                newdata.forEach((key, val) {
                                  newdata[key] = Utils.getMaxDefensesAndMaxLevel(snapshot.data[0]["townHallLevel"], snapshot.data[1])[key.substring(0, key.length - 2)];
                                });
                                updateDefenses(newdata);
                              } else if(ind == 2) {
                                newdata.forEach((key, val) {
                                  newdata[key] = Utils.getMaxTrapsAndMaxLevel(snapshot.data[0]["townHallLevel"], snapshot.data[1])[key.substring(0, key.length - 2)];
                                });
                                updateTraps(newdata);
                              } else if(ind == 3) {
                                newdata.forEach((key, val) {
                                  newdata[key] = Utils.getMaxArmyAndMaxLevel(snapshot.data[0]["townHallLevel"], snapshot.data[1])[key.substring(0, key.length - 2)];
                                });
                                updateArmyBuildings(newdata);
                              } else if(ind == 4) {
                                newdata.forEach((key, val) {
                                  newdata[key] = Utils.getMaxResourceAndMaxLevel(snapshot.data[0]["townHallLevel"], snapshot.data[1])[key.substring(0, key.length - 2)];
                                });
                                updateResources(newdata);
                              }
                            },
                            icon: const Icon(Icons.skip_next, color: Colors.orangeAccent),
                            label: const Text("Max", style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 18)),
                          ),
                        ],
                      ),
                      Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: finalmaplist[ind].length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    color: Colors.black,
                                    child: GridTile(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  child: ind==0? Utils.getBuildingImage(snapshot.data[0]["townHallLevel"], finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-')), int.parse(finalmaplist[ind].keys.elementAt(index).substring(finalmaplist[ind].keys.elementAt(index).lastIndexOf('-') + 1, finalmaplist[ind].keys.elementAt(index).length))) : Utils.getBuildingImage(snapshot.data[0]["townHallLevel"], finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-')), finalmaplist[ind].values.elementAt(index)),
                                                ),
                                                const SizedBox(width: 5),
                                                ind == 0? Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    AutoSizeText(
                                                        "Level ${finalmaplist[ind].keys.elementAt(index).substring(5, finalmaplist[ind].keys.elementAt(index).length)}",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: "Poppins",
                                                            fontSize: 15),
                                                        maxLines: 1
                                                    ),
                                                    AutoSizeText(
                                                        "${Utils.getTownHallWeapon(snapshot.data[0]["townHallLevel"]) != finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))? finalmaplist[ind].values.elementAt(index) : snapshot.data[0]["townHallWeaponLevel"]}",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: "Poppins",
                                                            fontSize: 15),
                                                        maxLines: 1
                                                    )
                                                  ],
                                                ) : AutoSizeText(
                                                    "${finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))} | ${Utils.getTownHallWeapon(snapshot.data[0]["townHallLevel"]) != finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))? finalmaplist[ind].values.elementAt(index) : snapshot.data[0]["townHallWeaponLevel"]}",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Poppins",
                                                        fontSize: 15),
                                                    maxLines: 1
                                                ),
                                              ],
                                            ),
                                            Utils.getTownHallWeapon(snapshot.data[0]["townHallLevel"]) != finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))? Row(
                                              children: [
                                                ind == 0? IconButton(
                                                    style: ButtonStyle(
                                                        backgroundColor: WidgetStateProperty.all(Colors.white24),
                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(15.0),
                                                                side: BorderSide(color: Colors.white24)
                                                            )
                                                        )
                                                    ),
                                                    onPressed: () async {
                                                      Map<String, dynamic> newdata = finalmaplist[ind];
                                                      if(ind == 0) {
                                                        String newval = await showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return Presets.getEditWallsDialog(context, finalmaplist[ind].values.elementAt(index).toString());
                                                          }
                                                        );
                                                        int intval = int.parse(newval);
                                                        updateWalls(Utils.editWalls(snapshot.data[1], newdata, finalmaplist[ind].keys.elementAt(index), finalmaplist[ind].values.elementAt(index), intval));
                                                      }
                                                    },
                                                    icon: const Icon(Icons.edit, color: Colors.blueAccent)
                                                ) : const SizedBox(width: 1),
                                                IconButton(
                                                    style: ButtonStyle(
                                                        backgroundColor: WidgetStateProperty.all(Colors.white24),
                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(15.0),
                                                                side: BorderSide(color: Colors.white24)
                                                            )
                                                        )
                                                    ),
                                                    onPressed: () {
                                                      Map<String, dynamic> newdata = finalmaplist[ind];
                                                      if(finalmaplist[ind].values.elementAt(index) - 1 >= 0) {
                                                        if(ind == 0) {
                                                          if(Utils.canWallBeDecreased(snapshot.data[0]["townHallLevel"], snapshot.data[1], int.parse(finalmaplist[ind].keys.elementAt(index).substring(5, finalmaplist[ind].keys.elementAt(index).length)))) {
                                                            updateWalls(Utils.rearrangeWalls(newdata, finalmaplist[ind].keys.elementAt(index), finalmaplist[ind].values.elementAt(index), -1));
                                                          }
                                                        } else {
                                                          newdata[finalmaplist[ind].keys.elementAt(index)] = finalmaplist[ind].values.elementAt(index) - 1;
                                                          if (ind == 1) {
                                                            updateDefenses(newdata);
                                                          } else if (ind == 2) {
                                                            updateTraps(newdata);
                                                          } else if (ind == 3) {
                                                            updateArmyBuildings(newdata);
                                                          } else if (ind == 4) {
                                                            updateResources(newdata);
                                                          }
                                                        }
                                                      }
                                                    },
                                                    icon: const Icon(Icons.remove, color: Colors.redAccent)
                                                ),
                                                IconButton(
                                                    style: ButtonStyle(
                                                        backgroundColor: WidgetStateProperty.all(Colors.white24),
                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(15.0),
                                                                side: BorderSide(color: Colors.white24)
                                                            )
                                                        )
                                                    ),
                                                    onPressed: (){
                                                      Map<String, dynamic> newdata = finalmaplist[ind];
                                                      if(ind == 0) {
                                                        if(Utils.canWallBeIncreased(snapshot.data[0]["townHallLevel"], snapshot.data[1], int.parse(finalmaplist[ind].keys.elementAt(index).substring(5, finalmaplist[ind].keys.elementAt(index).length)))) {
                                                          updateWalls(Utils.rearrangeWalls(newdata, finalmaplist[ind].keys.elementAt(index), finalmaplist[ind].values.elementAt(index), 1));
                                                        }
                                                      } else if (ind == 1) {
                                                        if(finalmaplist[ind].values.elementAt(index) + 1 <= Utils.getMaxDefensesAndMaxLevel(snapshot.data[0]["townHallLevel"], snapshot.data[1])[finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))]) {
                                                          newdata[finalmaplist[ind].keys.elementAt(index)] = finalmaplist[ind].values.elementAt(index) + 1;
                                                          updateDefenses(newdata);
                                                        }
                                                      } else if (ind == 2) {
                                                        if(finalmaplist[ind].values.elementAt(index) + 1 <= Utils.getMaxTrapsAndMaxLevel(snapshot.data[0]["townHallLevel"], snapshot.data[1])[finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))]) {
                                                          newdata[finalmaplist[ind].keys.elementAt(index)] = finalmaplist[ind].values.elementAt(index) + 1;
                                                          updateTraps(newdata);
                                                        }
                                                      } else if (ind == 3) {
                                                        if(finalmaplist[ind].values.elementAt(index) + 1 <= Utils.getMaxArmyAndMaxLevel(snapshot.data[0]["townHallLevel"], snapshot.data[1])[finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))]) {
                                                          newdata[finalmaplist[ind].keys.elementAt(index)] = finalmaplist[ind].values.elementAt(index) + 1;
                                                          updateArmyBuildings(newdata);
                                                        }
                                                      } else if (ind == 4) {
                                                        if(finalmaplist[ind].values.elementAt(index) + 1 <= Utils.getMaxResourceAndMaxLevel(snapshot.data[0]["townHallLevel"], snapshot.data[1])[finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))]) {
                                                          newdata[finalmaplist[ind].keys.elementAt(index)] = finalmaplist[ind].values.elementAt(index) + 1;
                                                          updateResources(newdata);
                                                        }
                                                      }
                                                    },
                                                    icon: const Icon(Icons.add, color: Colors.lightGreen)
                                                ),
                                                IconButton(
                                                    style: ButtonStyle(
                                                        backgroundColor: WidgetStateProperty.all(Colors.white24),
                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(15.0),
                                                                side: BorderSide(color: Colors.white24)
                                                            )
                                                        )
                                                    ),
                                                    onPressed: (){
                                                      Map<String, dynamic> newdata = finalmaplist[ind];
                                                      if(ind == 0) {
                                                        if(Utils.canWallBeIncreased(snapshot.data[0]["townHallLevel"], snapshot.data[1], int.parse(finalmaplist[ind].keys.elementAt(index).substring(5, finalmaplist[ind].keys.elementAt(index).length)))) {
                                                          updateWalls(Utils.rearrangeWalls(newdata, finalmaplist[ind].keys.elementAt(index), finalmaplist[ind].values.elementAt(index), finalmaplist[ind].values.elementAt(index)));
                                                        }
                                                      } else if (ind == 1) {
                                                        newdata[finalmaplist[ind].keys.elementAt(index)] = Utils.getMaxDefensesAndMaxLevel(snapshot.data[0]["townHallLevel"], snapshot.data[1])[finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))];
                                                        updateDefenses(newdata);
                                                      } else if (ind == 2) {
                                                        newdata[finalmaplist[ind].keys.elementAt(index)] = Utils.getMaxTrapsAndMaxLevel(snapshot.data[0]["townHallLevel"], snapshot.data[1])[finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))];
                                                        updateTraps(newdata);
                                                      } else if (ind == 3) {
                                                        newdata[finalmaplist[ind].keys.elementAt(index)] = Utils.getMaxArmyAndMaxLevel(snapshot.data[0]["townHallLevel"], snapshot.data[1])[finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))];
                                                        updateArmyBuildings(newdata);
                                                      } else if (ind == 4) {
                                                        newdata[finalmaplist[ind].keys.elementAt(index)] = Utils.getMaxResourceAndMaxLevel(snapshot.data[0]["townHallLevel"], snapshot.data[1])[finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))];
                                                        updateResources(newdata);
                                                      }
                                                    },
                                                    icon: const Icon(Icons.double_arrow, color: Colors.orangeAccent)
                                                )
                                              ],
                                            ) : const SizedBox(width: 50),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                      const SizedBox(height: 20)
                    ],
                  );
                }
            );
          } else {
            return ListView.builder(
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Shimmer(child: Container(width: 50, height: 15, color: Colors.black45)),
                  );
                }
            );
          }
        }
    );
  }


  Widget getTroopDetail() {
    return FutureBuilder(
      future: DataProvider.awaitTroops(userTag),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          List finallist = [];
          List titles = ["Troops", "Siege Machines", "Super Troops", "Builder Hall Troops"];
          List normaltroops = Utils.getNormalTroops(snapshot.data);
          finallist.add(normaltroops);
          List siegemachines = Utils.getSiegeMachines(snapshot.data);
          finallist.add(siegemachines);
          List supertroops = Utils.getSuperTroops(snapshot.data);
          finallist.add(supertroops);
          List buildertroops = Utils.getBuilderTroops(snapshot.data);
          finallist.add(buildertroops);
          return ListView.builder(
            itemCount: titles.length,
            itemBuilder: (context, ind) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ind == 0 && normaltroops.isNotEmpty || ind == 1 && siegemachines.isNotEmpty || ind == 2 && supertroops.isNotEmpty || ind == 3 && buildertroops.isNotEmpty? Text(titles[ind], style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: 30)
                  ) : SizedBox(width: 5),
                  Container(
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: finallist[ind].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: finallist[ind][index]["level"] ==
                                    finallist[ind][index]["maxLevel"] ? Color(
                                    0xFF532D1F) : Colors.black,
                                child: GridTile(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        AutoSizeText(
                                            finallist[ind][index]["name"],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 15),
                                            maxLines: 1
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceEvenly,
                                          children: [
                                            Utils.getTroopImage(
                                                finallist[ind][index]["name"],
                                                finallist[ind][index]["village"]),
                                            Text(
                                                (finallist[ind][index]["level"])
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins",
                                                    fontSize: 35)),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                  "Max: ${finallist[ind][index]["maxLevel"]}",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontSize: 10)),
                                              Row(
                                                children: [
                                                  Icon(Icons.access_time,
                                                      color: Colors.white,
                                                      size: 14),
                                                  SizedBox(width: 5),
                                                  Text("1d 12h",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Poppins",
                                                          fontSize: 10)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              );
            }
          );
        } else {
          return ListView.builder(
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Shimmer(child: Container(width: 50, height: 15, color: Colors.black45)),
                );
              }
          );
        }
      }
    );
  }


  Widget getSpellDetail() {
    return FutureBuilder(
        future: DataProvider.awaitSpells(userTag),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            List finallist = Utils.getSpells(snapshot.data);
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: finallist.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: finallist[index]["level"] == finallist[index]["maxLevel"]? Color(
                            0xFF532D1F): Colors.black,
                        child: GridTile(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                    finallist[index]["name"],
                                    style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 15),
                                    maxLines: 1
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Utils.getTroopImage(finallist[index]["name"], finallist[index]["village"]),
                                    Text((finallist[index]["level"]).toString(), style: const TextStyle(color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontSize: 35)),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Max: ${finallist[index]["maxLevel"]}", style: const TextStyle(color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontSize: 10)),
                                      Row(
                                        children: [
                                          Icon(Icons.access_time, color: Colors.white, size: 14),
                                          SizedBox(width: 5),
                                          Text("1d 12h", style: const TextStyle(color: Colors.white,
                                              fontFamily: "Poppins",
                                              fontSize: 10)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
            );
          } else {
            return ListView.builder(
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Shimmer(child: Container(width: 50, height: 15, color: Colors.black45)),
                  );
                }
            );
          }
        }
    );
  }


  Widget getHeroesDetail() {
    return FutureBuilder(
        future: Future.wait([DataProvider.awaitHeroes(userTag), DataProvider.awaitTroops(userTag)]),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            List titles = ["Heroes", "Builder Hall Heroes", "Pets"];
            List heroes = Utils.getNormalHeroes(snapshot.data[0]);
            List bhheroes = Utils.getBuilderHeroes(snapshot.data[0]);
            List pets = Utils.getPets(snapshot.data[1]);
            List finallist = [];
            finallist.add(heroes);
            finallist.add(bhheroes);
            finallist.add(pets);
            return ListView.builder(
              itemCount: titles.length,
              itemBuilder: (context, ind) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ind == 0 && heroes.isNotEmpty || ind == 1 && bhheroes.isNotEmpty || ind == 2 && pets.isNotEmpty? Text(titles[ind], style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 30)) : SizedBox(width: 5),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: ind == 2? 3 : 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: finallist[ind].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: finallist[ind][index]["level"] ==
                                    finallist[ind][index]["maxLevel"] ? Color(
                                    0xFF532D1F) : Colors.black,
                                child: Utils.isPet(finallist[ind][index]["name"]) && pets.isNotEmpty?
                                GridTile(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                            finallist[ind][index]["name"],
                                            style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 15),
                                            maxLines: 1
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Utils.getTroopImage(finallist[ind][index]["name"], finallist[ind][index]["village"]),
                                            Text((finallist[ind][index]["level"]).toString(), style: const TextStyle(color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 35)),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Max: ${finallist[ind][index]["maxLevel"]}", style: const TextStyle(color: Colors.white,
                                                  fontFamily: "Poppins",
                                                  fontSize: 10)),
                                              Row(
                                                children: [
                                                  Icon(Icons.access_time, color: Colors.white, size: 14),
                                                  SizedBox(width: 5),
                                                  Text("1d 12h", style: const TextStyle(color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontSize: 10)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                : ind == 0 && heroes.isNotEmpty || ind == 1 && bhheroes.isNotEmpty? GridTile(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        AutoSizeText(
                                            finallist[ind][index]["name"],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 20),
                                            maxLines: 1
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceEvenly,
                                          children: [
                                            Utils.getTroopImage(
                                                finallist[ind][index]["name"],
                                                finallist[ind][index]["village"]),
                                            Text((finallist[ind][index]["level"])
                                                .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins",
                                                    fontSize: 35)),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                      "Max: ${finallist[ind][index]["maxLevel"]}",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Poppins",
                                                          fontSize: 15)),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.access_time,
                                                          color: Colors.white,
                                                          size: 14),
                                                      SizedBox(width: 5),
                                                      Text("1d 12h",
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontFamily: "Poppins",
                                                              fontSize: 15)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              finallist[ind][index]["equipment"] != null? Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Utils.isNormalHero(
                                                          finallist[ind][index]["name"])
                                                          ? Utils.getTroopImage(
                                                          finallist[ind][index]["equipment"][0]["name"],
                                                          finallist[ind][index]["equipment"][0]["village"])
                                                          : Container(),
                                                      Utils.isNormalHero(
                                                          finallist[ind][index]["name"])
                                                          ? Utils.getTroopImage(
                                                          finallist[ind][index]["equipment"][1]["name"],
                                                          finallist[ind][index]["equipment"][1]["village"])
                                                          : Container(),
                                                    ],
                                                  ),
                                                ],
                                              ) : SizedBox(width: 5)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ) : SizedBox(height: 5),
                              ),
                            ),
                          );
                        }
                    ),
                    SizedBox(height: 20)
                  ]
                );
              }
            );
          } else {
            return ListView.builder(
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Shimmer(child: Container(width: 50, height: 15, color: Colors.black45)),
                  );
                }
            );
          }
        }
    );
  }

  Widget getEquipmentDetail() {
    return FutureBuilder(
        future: DataProvider.awaitEquipment(userTag),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            List finallist = [];
            List titles = ["King", "Queen", "Minion Prince", "Warden", "Royal Champion"];
            finallist.add(Utils.getKingEquipment(snapshot.data));
            finallist.add(Utils.getQueenEquipment(snapshot.data));
            finallist.add(Utils.getMinionPrinceEquipment(snapshot.data));
            finallist.add(Utils.getWardenEquipment(snapshot.data));
            finallist.add(Utils.getRoyalChampEquipment(snapshot.data));
            return ListView.builder(
              itemCount: titles.length,
              itemBuilder: (context, ind) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titles[ind], style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 30)
                    ),
                    Container(
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemCount: finallist[ind].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: finallist[ind][index]["level"] ==
                                      finallist[ind][index]["maxLevel"] ? Color(
                                      0xFF532D1F) : Colors.black,
                                  child: GridTile(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          AutoSizeText(
                                              finallist[ind][index]["name"],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15),
                                              maxLines: 1
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              Utils.getTroopImage(
                                                  finallist[ind][index]["name"],
                                                  finallist[ind][index]["village"]),
                                              Text((finallist[ind][index]["level"])
                                                  .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontSize: 35)),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                    "Max: ${finallist[ind][index]["maxLevel"]}",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Poppins",
                                                        fontSize: 10)),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                        shiny_ore, scale: 10),
                                                    SizedBox(width: 2),
                                                    Text(Utils
                                                        .getNextShiny(
                                                        finallist[ind][index])
                                                        .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: "Poppins",
                                                            fontSize: 10)),
                                                    SizedBox(width: 3),
                                                    Image.asset(
                                                        glowy_ore, scale: 10),
                                                    SizedBox(width: 2),
                                                    Text(Utils
                                                        .getNextGlowy(
                                                        finallist[ind][index])
                                                        .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: "Poppins",
                                                            fontSize: 10)),
                                                    SizedBox(width: 3),
                                                    Image.asset(
                                                        starry_ore, scale: 10),
                                                    SizedBox(width: 2),
                                                    Text(Utils
                                                        .getNextStarry(
                                                        finallist[ind][index])
                                                        .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: "Poppins",
                                                            fontSize: 10)),
                                                    SizedBox(width: 3),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                    SizedBox(height: 20)
                  ],
                );
              }
            );
          } else {
            return ListView.builder(
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Shimmer(child: Container(width: 50, height: 15, color: Colors.black45)),
                  );
                }
            );
          }
        }
    );
  }


  Widget getAchievementDetails() {
    return FutureBuilder(
        future: DataProvider.awaitAchievements(userTag),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            List finallist = [];
            List titles = ["Home", "Builder Hall", "Clan Captial"];
            finallist.add(Utils.filterAchievements(Utils.getHomeAchievements(snapshot.data)));
            finallist.add(Utils.getBuilderHallAchievements(snapshot.data));
            finallist.add(Utils.getCapitalAchievements(snapshot.data));
            return ListView.builder(
              itemCount: titles.length,
              itemBuilder: (context, ind) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titles[ind], style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 30)
                    ),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: finallist[ind].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: finallist[ind][index]["value"] >=
                                      finallist[ind][index]["target"] ? Color(
                                      0xFF532D1F) : Colors.black,
                                  child: GridTile(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              AutoSizeText(
                                                  finallist[ind][index]["name"],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontSize: 20),
                                                  maxLines: 1
                                              ),
                                              SizedBox(width: 30),
                                              finallist[ind][index]["stars"] == 3
                                                  ? Image.asset(three_star)
                                                  : finallist[ind][index]["stars"] ==
                                                  2
                                                  ? Image.asset(two_star)
                                                  : Image.asset(one_star)
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              AutoSizeText(
                                                  finallist[ind][index]["info"],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontSize: 12),
                                                  maxLines: 1
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              SimpleAnimationProgressBar(
                                                ratio: finallist[ind][index]["value"] /
                                                    finallist[ind][index]["target"],
                                                width: 150,
                                                height: 10,
                                                direction: Axis.horizontal,
                                                backgroundColor: Colors.grey
                                                    .shade800,
                                                foregroundColor: Colors.purple,
                                                duration: const Duration(
                                                    seconds: 3),
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn,
                                                borderRadius: BorderRadius
                                                    .circular(10),
                                                gradientColor: LinearGradient(
                                                    colors: [
                                                      Colors.greenAccent,
                                                      Colors.lightGreen
                                                    ]),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.lightGreen,
                                                    blurRadius: 2.5,
                                                    spreadRadius: 2.0,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 10),
                                              finallist[ind][index]["value"] >=
                                                  finallist[ind][index]["target"]
                                                  ? SizedBox()
                                                  : AutoSizeText(
                                                  ((finallist[ind][index]["value"] /
                                                      finallist[ind][index]["target"]) *
                                                      100).toStringAsFixed(2) +
                                                      "%",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontSize: 12),
                                                  maxLines: 1
                                              ),
                                            ],
                                          ),
                                          AutoSizeText(
                                              "${finallist[ind][index]["value"]}/${finallist[ind][index]["target"]}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Poppins",
                                                  fontSize: 12),
                                              maxLines: 1
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                    SizedBox(height: 20)
                  ],
                );
              }
            );
          } else {
            return ListView.builder(
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Shimmer(child: Container(width: 50, height: 15, color: Colors.black45)),
                  );
                }
            );
          }
        }
    );
  }


  Widget getProfileDetails() {
    return FutureBuilder(
        future: Future.wait([DataProvider.awaitPlayerData(userTag), DataProvider.awaitPlayerClan(userTag)]),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Allgemein", style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: 25)
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot.data[0]["name"], style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 30)
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Image.asset(exp),
                                        SizedBox(width: 5),
                                        Text("Exp: ${snapshot.data[0]["expLevel"]}", style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 15)
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Image.asset('lib/utils/img/Trophy.png',
                                            fit: BoxFit.cover, scale: 1.5),
                                        SizedBox(width: 7),
                                        Text("Best: ${snapshot.data[0]["bestTrophies"]}", style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 15)
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        DataProvider.awaitBuilderLeagueIcon(snapshot.data[0]),
                                        SizedBox(width: 7),
                                        Text("Best: ${snapshot.data[0]["bestBuilderBaseTrophies"]}", style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 15)
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Image.asset(star, scale: 1.2),
                                        SizedBox(width: 7),
                                        Text("War Stars: ${snapshot.data[0]["warStars"]}", style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 15)
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Image.asset(capital_gold, scale: 3.5),
                                        SizedBox(width: 7),
                                        Text("Clan Capital: ${snapshot.data[0]["clanCapitalContributions"]}", style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 15)
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(snapshot.data[0]["tag"], style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontSize: 15)
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        DataProvider.awaitTownHallIcon(snapshot.data[0]["townHallLevel"], 3),
                                        SizedBox(width: 5),
                                        DataProvider.awaitBuilderHallIcon(snapshot.data[0]["builderHallLevel"], 2.5)
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot.data[0]["townHallLevel"].toString(), style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 15)
                                        ),
                                        SizedBox(width: 25),
                                        Text(snapshot.data[0]["builderHallLevel"].toString(), style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 15)
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  snapshot.data[0]["clan"] != null? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text("Clan", style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 25)
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                              color: Colors.black,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(snapshot.data[0]["clan"]["name"], style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins",
                                                    fontSize: 30)
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Icon(Icons.language, color: Colors.white),
                                                    SizedBox(width: 5),
                                                    Text(snapshot.data[1]["location"]["name"], style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Poppins",
                                                        fontSize: 15)
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Icon(Icons.person, color: Colors.white),
                                                    SizedBox(width: 5),
                                                    Text("Mitglieder: ${snapshot.data[1]["members"]}", style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Poppins",
                                                        fontSize: 15)
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.sell, color: Colors.white),
                                                    SizedBox(width: 5),
                                                    snapshot.data[1]["labels"].length >= 1? Image.network(snapshot.data[1]["labels"][0]["iconUrls"]["small"], scale: 2) : Container(),
                                                    snapshot.data[1]["labels"].length >= 2? Image.network(snapshot.data[1]["labels"][1]["iconUrls"]["small"], scale: 2) : Container(),
                                                    snapshot.data[1]["labels"].length >= 3? Image.network(snapshot.data[1]["labels"][2]["iconUrls"]["small"], scale: 2) : Container(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(snapshot.data[0]["clan"]["tag"], style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Poppins",
                                                    fontSize: 15)
                                                ),
                                                Image.network(snapshot.data[0]["clan"]["badgeUrls"]["medium"], scale: 2),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.edit, color: Colors.white),
                                            SizedBox(width: 5),
                                            Container(
                                              width: MediaQuery.of(context).size.width - 2 * 40,
                                              child: Text(textWidthBasis: TextWidthBasis.parent, "${snapshot.data[1]["description"]}", style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Poppins",
                                                  fontSize: 11)
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(Icons.key, color: Colors.white),
                                            SizedBox(width: 5),
                                            Utils.getRole(snapshot.data[0]["role"])
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Image.asset('lib/utils/img/Trophy.png',
                                                fit: BoxFit.cover, scale: 1.5),
                                            SizedBox(width: 7),
                                            Text("${snapshot.data[1]["clanPoints"]}", style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 15)
                                            ),
                                            SizedBox(width: 10),
                                            Image.asset('lib/utils/img/BuilderHallTrophy.png',
                                                fit: BoxFit.cover, scale: 11.5),
                                            SizedBox(width: 7),
                                            Text("${snapshot.data[1]["clanBuilderBasePoints"]}", style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 15)
                                            ),
                                            SizedBox(width: 10),
                                            Image.asset('lib/utils/img/TrophyC.webp',
                                                fit: BoxFit.cover, scale: 1.5),
                                            SizedBox(width: 7),
                                            Text("${snapshot.data[1]["clanCapitalPoints"]}", style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 15)
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            DataProvider.awaitClanWarLeagueIcon(snapshot.data[1]["warLeague"]["name"]),
                                            SizedBox(width: 5),
                                            Text("Wins: ${snapshot.data[1]["warWins"]} / Ties: ${snapshot.data[1]["warTies"]} / Losses: ${snapshot.data[1]["warLosses"]}", style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 15)
                                            ),
                                            SizedBox(width: 10),
                                            Icon(Icons.local_fire_department, color: Colors.white),
                                            Text("Streak: ${snapshot.data[1]["warWinStreak"]}", style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 15)
                                            ),
                                          ],
                                        ),
                                      ]
                                  )
                              )
                          )
                      ),
                      SizedBox(height: 10),
                      Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          children: List.generate(snapshot.data[1]["clanCapital"]["districts"].length, (index) {
                            return ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                    color: Colors.black,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            index == 0? Utils.getCapitalHallImage(snapshot.data[1]["clanCapital"]["districts"][index]["districtHallLevel"]) : Utils.getDistrictHallImage(snapshot.data[1]["clanCapital"]["districts"][index]["districtHallLevel"]),
                                            SizedBox(width: 5),
                                            Text("${snapshot.data[1]["clanCapital"]["districts"][index]["name"]}: ${snapshot.data[1]["clanCapital"]["districts"][index]["districtHallLevel"]}", style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 15)
                                            ),
                                          ],
                                        )
                                    )
                                )
                            );
                          }
                          )
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Donations: In | Out", style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 15)
                          ),
                        ],
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data[1]["memberList"].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                      color: snapshot.data[1]["memberList"][index]["tag"] == snapshot.data[0]["tag"]? Colors.green.shade800 : Colors.black,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("${snapshot.data[1]["memberList"][index]["clanRank"]}.", style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontSize: 15)
                                                  ),
                                                  SizedBox(width: 5),
                                                  Image.network(snapshot.data[1]["memberList"][index]["league"]["iconUrls"]["small"], scale: 3),
                                                  SizedBox(width: 5),
                                                  DataProvider.awaitTownHallIcon(snapshot.data[1]["memberList"][index]["townHallLevel"], 5),
                                                  SizedBox(width: 5),
                                                  Text("${snapshot.data[1]["memberList"][index]["trophies"]}", style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontSize: 15)
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text("| ${snapshot.data[1]["memberList"][index]["name"]}", style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontSize: 15)
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("${snapshot.data[1]["memberList"][index]["donationsReceived"]} | ${snapshot.data[1]["memberList"][index]["donations"]}", style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Poppins",
                                                      fontSize: 15)
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                      )
                                  )
                              ),
                            );
                          }
                      )
                    ],
                  ) : SizedBox(height: 5)
                ]
              ),
            );
          } else {
            return ListView.builder(
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Shimmer(child: Container(width: 50, height: 15, color: Colors.black45)),
                  );
                }
            );
          }
        }
    );
  }
}