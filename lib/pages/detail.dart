import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashofclanstracker/utils/img/ShortAsset.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import '../provider/DataProvider.dart' as DataProvider;
import '../utils/ArgumentClass.dart';
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
  late ArgumentClass arguments = ModalRoute.of(context)!.settings.arguments as ArgumentClass;
  late String category = arguments.page;
  late Map<String, dynamic> war = arguments.war;

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

  void importJSONString(String json, Map<String, dynamic> gamedata){
    Map<String, dynamic> decodedJson = jsonDecode(json);
    Map<String, dynamic> tempwalls = {};
    Map<String, dynamic> tempdefenses = {};
    Map<String, dynamic> temptraps = {};
    Map<String, dynamic> temparmy = {};
    Map<String, dynamic> tempresources = {};

    //buildings
    Map<int, List<int>> bmap = {};
    for(var element in decodedJson["buildings"]) {
      //walls
      if(element["data"] == 1000010) {
        tempwalls["wall-${element["lvl"]}"] = element["cnt"];
      } else {
        //buildings
        List<int> blist = bmap[element["data"]] ?? [];
        if(element["cnt"] != null) {
          for (int i = 0; i < element["cnt"]; i++) {
            blist.add(element["lvl"]);
          }
        }
        if(element["gear_up"] != null) {
          for (int i = 0; i < element["gear_up"]; i++) {
            blist.add(element["lvl"]);
          }
        }
        if(element["timer"] != null) {
          blist.add(element["lvl"]);
        }
        bmap[element["data"]] = blist;
      }
    }

    Map<int, List<int>> tmap = {};
    for(var element in decodedJson["traps"]) {
      //traps
      List<int> tlist = tmap[element["data"]] ?? [];
      if(element["cnt"] != null) {
        for (int i = 0; i < element["cnt"]; i++) {
          tlist.add(element["lvl"]);
        }
      }
      if(element["gear_up"] != null) {
        for (int i = 0; i < element["gear_up"]; i++) {
          tlist.add(element["lvl"]);
        }
      }
      if(element["timer"] != null) {
        tlist.add(element["lvl"]);
      }
      tmap[element["data"]] = tlist;
    }

    bmap.forEach((gamedataid, list) {
      if(Utils.isGameDataDefenses(gamedataid)) {
        for(int i = 0; i < list.length; i++) {
          tempdefenses["${gamedata.keys.firstWhere((k) => gamedata[k] == gamedataid)}-$i"] = list[i];
        }
      } else if(Utils.isGameDataArmyBuilding(gamedataid)) {
        for(int i = 0; i < list.length; i++) {
          temparmy["${gamedata.keys.firstWhere((k) => gamedata[k] == gamedataid)}-$i"] = list[i];
        }
      } else if(Utils.isGameDataResource(gamedataid)) {
        for(int i = 0; i < list.length; i++) {
          tempresources["${gamedata.keys.firstWhere((k) => gamedata[k] == gamedataid)}-$i"] = list[i];
        }
      }
    });

    tmap.forEach((gamedataid, list) {
      for(int i = 0; i < list.length; i++) {
        temptraps["${gamedata.keys.firstWhere((k) => gamedata[k] == gamedataid)}-$i"] = list[i];
      }
    });
    updateWalls(tempwalls);
    updateDefenses(tempdefenses);
    updateArmyBuildings(temparmy);
    updateResources(tempresources);
    updateTraps(temptraps);
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
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.tertiary)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: category == "buildings"? getBuildingDetail() : category == "troops" ? getTroopDetail() : category == "spells"?
            getSpellDetail() : category == "heroes"? getHeroesDetail() : category == "equipment"?
            getEquipmentDetail() : category == "achievements"? getAchievementDetails() : category == "profile"? getProfileDetails() :
            category == "cwl"? getClanWarLeagueDetails() : category == "clanwar"? getClanWarDetails(war) : category == "clanwarlog"? getClanWarLogDetails() : null,
          ),
        ),
      ),
    );
  }

  Widget getBuildingDetail() {
    return FutureBuilder(
        future: Future.wait([DataProvider.awaitPlayerData(userTag), DataProvider.awaitBuildings(), DataProvider.awaitGameData()]),
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
                      ?ind == 0? Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              color: Theme.of(context).colorScheme.surfaceContainer,
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
                                          Text("Townhall ${snapshot.data[0]["townHallLevel"]}", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.surface)),
                                          ?snapshot.data[0]["townHallWeaponLevel"] != null? Text("Level ${snapshot.data[0]["townHallWeaponLevel"]}", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface)) : null,
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Theme.of(context).colorScheme.surfaceContainer,
                              child: GridTile(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.code, size: 20, color: Colors.deepOrangeAccent),
                                          SizedBox(width: 5),
                                          Text("Import Json", style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.surface),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3),
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        onPressed: () async {
                                          String newval = await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Presets.getImportJSONDialog(context, "");
                                              }
                                          );
                                          importJSONString(newval, snapshot.data[2]);
                                        },
                                        icon: Icon(Icons.upload, color: Theme.of(context).colorScheme.surface),
                                        label: Text("Import", style: TextStyle(
                                            color: Theme.of(context).colorScheme.surface,
                                            fontSize: 18)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ) : null,
                      ?ind == 0? const SizedBox(height: 20) : null,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.secondaryContainer],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(titles[ind], style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                      ),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3),
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
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
                                        label: Text("Max", style: TextStyle(
                                            color: Theme.of(context).colorScheme.surface,
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
                                                color: Theme.of(context).colorScheme.surfaceContainer,
                                                child: GridTile(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          flex: 3,
                                                          child: Row(
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
                                                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                                                                      maxLines: 1
                                                                  ),
                                                                  AutoSizeText(
                                                                      "${Utils.getTownHallWeapon(snapshot.data[0]["townHallLevel"]) != finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))? finalmaplist[ind].values.elementAt(index) : snapshot.data[0]["townHallWeaponLevel"]}",
                                                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                                                      maxLines: 1
                                                                  )
                                                                ],
                                                              ) : Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    AutoSizeText(
                                                                      finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-')),
                                                                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                                                                    ),
                                                                    ClipRRect(
                                                                      borderRadius: BorderRadius.circular(20),
                                                                      child: Container(
                                                                      color: Colors.deepOrangeAccent.withValues(alpha: 0.3),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                                                                          child: AutoSizeText(
                                                                            "Lvl ${Utils.getTownHallWeapon(snapshot.data[0]["townHallLevel"]) != finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))? finalmaplist[ind].values.elementAt(index) : snapshot.data[0]["townHallWeaponLevel"]}",
                                                                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Utils.getTownHallWeapon(snapshot.data[0]["townHallLevel"]) != finalmaplist[ind].keys.elementAt(index).substring(0, finalmaplist[ind].keys.elementAt(index).lastIndexOf('-'))? Row(
                                                          children: [
                                                            ?ind == 0? IconButton(
                                                                style: ButtonStyle(
                                                                    backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3)),
                                                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(15.0),
                                                                            side: BorderSide(color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3))
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
                                                            ) : null,
                                                            IconButton(
                                                                style: ButtonStyle(
                                                                    backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3)),
                                                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(15.0),
                                                                            side: BorderSide(color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3))
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
                                                                    backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3)),
                                                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(15.0),
                                                                            side: BorderSide(color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3))
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
                                                                    backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3)),
                                                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(15.0),
                                                                            side: BorderSide(color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3))
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
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10)
                    ],
                  );
                }
            );
          } else {
            return ListView.builder(
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 50, height: 15))),
                  );
                }
            );
          }
        }
    );
  }


  Widget getTroopDetail() {
    return FutureBuilder(
      future: Future.wait([DataProvider.awaitTroops(userTag), DataProvider.awaitMaxTroops()]),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          List finallist = [];
          List titles = ["Troops", "Siege Machines", "Super Troops", "Builder Hall Troops"];
          List normaltroops = Utils.getNormalTroops(snapshot.data[0]);
          finallist.add(normaltroops);
          List siegemachines = Utils.getSiegeMachines(snapshot.data[0]);
          finallist.add(siegemachines);
          List supertroops = Utils.getSuperTroops(snapshot.data[0]);
          finallist.add(supertroops);
          List buildertroops = Utils.getBuilderTroops(snapshot.data[0]);
          finallist.add(buildertroops);
          return ListView.builder(
            itemCount: titles.length,
            itemBuilder: (context, ind) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ind == 0 && normaltroops.isNotEmpty || ind == 1 && siegemachines.isNotEmpty || ind == 2 && supertroops.isNotEmpty || ind == 3 && buildertroops.isNotEmpty? Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                            child: Text(titles[ind], style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.surface)
                            ),
                          ) : SizedBox(width: 5),
                          Container(
                            child: Wrap(
                                spacing: 5.0,
                                runSpacing: 5.0,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: List.generate(finallist[ind].length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surfaceContainer,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        width: 110,
                                        height: 125,
                                        child: GridTile(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                AutoSizeText(
                                                    finallist[ind][index]["name"],
                                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                                                    maxLines: 1
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Utils.getTroopImage(
                                                        finallist[ind][index]["name"],
                                                        finallist[ind][index]["village"]),
                                                    finallist[ind][index]["level"] !=
                                                        finallist[ind][index]["maxLevel"]? ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.white10, width: 2),
                                                          borderRadius: BorderRadius.circular(8),
                                                          color: Colors.black,
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                          child: Text(
                                                              (finallist[ind][index]["level"])
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 25)),
                                                        ),
                                                      ),
                                                    ) : ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: const Color(0xffD7993E), width: 2),
                                                          borderRadius: BorderRadius.circular(8),
                                                          color: const Color(0xffFABD51),
                                                        ),
                                                        child: Shimmer(
                                                          color: Colors.white,
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                            child: Text(
                                                                (finallist[ind][index]["level"])
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors.white,
                                                                    shadows: [Shadow(color: Colors.black, offset: Offset(0, 1.5))],
                                                                    fontSize: 25)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          ?finallist[ind][index]["maxLevel"] != finallist[ind][index]["level"]? SizedBox(height: 5) : null,
                                                          ?finallist[ind][index]["maxLevel"] != finallist[ind][index]["level"]? Utils.getTroopCosts(Utils.isSiegeMachine(finallist[ind][index]["name"])? snapshot.data[1]["siege_machines"] : Utils.isBuilderTroop(finallist[ind][index]["name"])? snapshot.data[1]["bhtroops"] : snapshot.data[1]["troops"], Utils.isSuperTroop(finallist[ind][index]["name"])? Utils.mapSuperTroopToTroop(finallist[ind][index]["name"]) : finallist[ind][index]["name"], finallist[ind][index]["level"]) : null,
                                                          ?finallist[ind][index]["maxLevel"] != finallist[ind][index]["level"]? SizedBox(height: 5) : null,
                                                          ?finallist[ind][index]["maxLevel"] != finallist[ind][index]["level"]? Utils.getTroopTime(Utils.isSiegeMachine(finallist[ind][index]["name"])? snapshot.data[1]["siege_machines"] : Utils.isBuilderTroop(finallist[ind][index]["name"])? snapshot.data[1]["bhtroops"] : snapshot.data[1]["troops"], Utils.isSuperTroop(finallist[ind][index]["name"])? Utils.mapSuperTroopToTroop(finallist[ind][index]["name"]) : finallist[ind][index]["name"], finallist[ind][index]["level"]) : null
                                                        ],
                                                      ),
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
                          ),
                        ],
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
                  title: ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 50, height: 15))),
                );
              }
          );
        }
      }
    );
  }


  Widget getSpellDetail() {
    return FutureBuilder(
        future: Future.wait([DataProvider.awaitSpells(userTag), DataProvider.awaitMaxTroops()]),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            List finallist = Utils.getSpells(snapshot.data[0]);
            return SingleChildScrollView(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                            child: Text("Spells", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.surface)
                            ),
                          ),
                          Wrap(
                              spacing: 5.0,
                              runSpacing: 5.0,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: List.generate(finallist.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: 110,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surfaceContainer,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: GridTile(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              AutoSizeText(
                                                  finallist[index]["name"],
                                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                                                  maxLines: 1
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Utils.getTroopImage(finallist[index]["name"], finallist[index]["village"]),
                                                  finallist[index]["level"] != finallist[index]["maxLevel"]? ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.white10, width: 2),
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: Colors.black,
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                        child: Text(
                                                            (finallist[index]["level"])
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 25)),
                                                      ),
                                                    ),
                                                  ) : ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: const Color(0xffD7993E), width: 2),
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: const Color(0xffFABD51),
                                                      ),
                                                      child: Shimmer(
                                                        color: Colors.white,
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                          child: Text(
                                                              (finallist[index]["level"])
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors.white,
                                                                  shadows: [Shadow(color: Colors.black, offset: Offset(0, 1.5))],
                                                                  fontSize: 25)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10.0),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        ?finallist[index]["level"] != finallist[index]["maxLevel"]? SizedBox(height: 5) : null,
                                                        ?finallist[index]["level"] != finallist[index]["maxLevel"]? Utils.getSpellCosts(snapshot.data[1]["spells"], finallist[index]["name"], finallist[index]["level"]) : null,
                                                        ?finallist[index]["level"] != finallist[index]["maxLevel"]? SizedBox(height: 5) : null,
                                                        ?finallist[index]["level"] != finallist[index]["maxLevel"]? Utils.getSpellTime(snapshot.data[1]["spells"], finallist[index]["name"], finallist[index]["level"]) : null,
                                                      ],
                                                    ),
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
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 50, height: 15))),
                  );
                }
            );
          }
        }
    );
  }


  Widget getHeroesDetail() {
    return FutureBuilder(
        future: Future.wait([DataProvider.awaitHeroes(userTag), DataProvider.awaitTroops(userTag), DataProvider.awaitMaxTroops()]),
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
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.secondaryContainer],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ind == 0 && heroes.isNotEmpty || ind == 1 && bhheroes.isNotEmpty || ind == 2 && pets.isNotEmpty? Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                              child: Text(titles[ind], style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.surface)),
                            ) : SizedBox(width: 5),
                                Wrap(
                                spacing: 5.0,
                                runSpacing: 5.0,
                                children: List.generate(finallist[ind].length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Utils.isPet(finallist[ind][index]["name"]) && pets.isNotEmpty?
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 110,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surfaceContainer,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: GridTile(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                AutoSizeText(
                                                    finallist[ind][index]["name"],
                                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                                                    maxLines: 1
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Utils.getTroopImage(finallist[ind][index]["name"], finallist[ind][index]["village"]),
                                                    finallist[ind][index]["level"] != finallist[ind][index]["maxLevel"]? ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.white10, width: 2),
                                                          borderRadius: BorderRadius.circular(8),
                                                          color: Colors.black,
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                          child: Text(
                                                              (finallist[ind][index]["level"])
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 25)),
                                                        ),
                                                      ),
                                                    ) : ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: const Color(0xffD7993E), width: 2),
                                                          borderRadius: BorderRadius.circular(8),
                                                          color: const Color(0xffFABD51),
                                                        ),
                                                        child: Shimmer(
                                                          color: Colors.white,
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                            child: Text(
                                                                (finallist[ind][index]["level"])
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors.white,
                                                                    shadows: [Shadow(color: Colors.black, offset: Offset(0, 1.5))],
                                                                    fontSize: 25)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          ?finallist[ind][index]["level"] != finallist[ind][index]["maxLevel"]? SizedBox(height: 5) : null,
                                                          ?finallist[ind][index]["level"] != finallist[ind][index]["maxLevel"]? Utils.getTroopCosts(snapshot.data[2]["pets"], finallist[ind][index]["name"], finallist[ind][index]["level"]) : null,
                                                          ?finallist[ind][index]["level"] != finallist[ind][index]["maxLevel"]? SizedBox(height: 5) : null,
                                                          ?finallist[ind][index]["level"] != finallist[ind][index]["maxLevel"]? Utils.getTroopTime(snapshot.data[2]["pets"], finallist[ind][index]["name"], finallist[ind][index]["level"]) : null,
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    : ind == 0 && heroes.isNotEmpty || ind == 1 && bhheroes.isNotEmpty? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 170,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surfaceContainer,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: GridTile(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                    finallist[ind][index]["name"],
                                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                                                    maxLines: 1
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Utils.getTroopImage(
                                                        finallist[ind][index]["name"],
                                                        finallist[ind][index]["village"]),
                                                    Column(
                                                      children: [
                                                        finallist[ind][index]["level"] != finallist[ind][index]["maxLevel"]? ClipRRect(
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.white10, width: 2),
                                                              borderRadius: BorderRadius.circular(8),
                                                              color: Colors.black,
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                              child: Text(
                                                                  (finallist[ind][index]["level"])
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 25)),
                                                            ),
                                                          ),
                                                        ) : ClipRRect(
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: const Color(0xffD7993E), width: 2),
                                                              borderRadius: BorderRadius.circular(8),
                                                              color: const Color(0xffFABD51),
                                                            ),
                                                            child: Shimmer(
                                                              color: Colors.white,
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                child: Text(
                                                                    (finallist[ind][index]["level"])
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors.white,
                                                                        shadows: [Shadow(color: Colors.black, offset: Offset(0, 1.5))],
                                                                        fontSize: 25)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        ?finallist[ind][index]["equipment"] != null? Column(
                                                          mainAxisAlignment: MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .end,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Utils.isNormalHero(
                                                                finallist[ind][index]["name"]) ? Utils.getTroopImage(
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
                                                        ) : null
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          ?finallist[ind][index]["level"] != finallist[ind][index]["maxLevel"]? SizedBox(height: 5) : null,
                                                          ?finallist[ind][index]["level"] != finallist[ind][index]["maxLevel"]? Utils.getTroopCosts(Utils.isNormalHero(finallist[ind][index]["name"])? snapshot.data[2]["heroes"] : snapshot.data[2]["bhheroes"], finallist[ind][index]["name"], finallist[ind][index]["level"]) : null,
                                                          ?finallist[ind][index]["level"] != finallist[ind][index]["maxLevel"]? SizedBox(height: 5) : null,
                                                          ?finallist[ind][index]["level"] != finallist[ind][index]["maxLevel"]? Utils.getTroopTime(Utils.isNormalHero(finallist[ind][index]["name"])? snapshot.data[2]["heroes"] : snapshot.data[2]["bhheroes"], finallist[ind][index]["name"], finallist[ind][index]["level"]) : null,
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ) : SizedBox(height: 5),
                                  );
                                }
                              ),
                            ),
                          ]
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
                    title: ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 50, height: 15))),
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
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.black.withValues(alpha: 0.8), Colors.black.withValues(alpha: 0.6)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                              child: Text(titles[ind], style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30)
                              ),
                            ),
                            Container(
                              child: Wrap(
                                  spacing: 5.0,
                                  runSpacing: 5.0,
                                  children: List.generate(finallist[ind].length, (index) {
                                    int shiny = Utils.getNextShiny(finallist[ind][index]);
                                    int glowy = Utils.getNextGlowy(finallist[ind][index]);
                                    int starry = Utils.getNextStarry(finallist[ind][index]);
                                    return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          width: 110,
                                          height: 125,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff101010),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: GridTile(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Center(
                                                    child: AutoSizeText(
                                                        finallist[ind][index]["name"],
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                        maxLines: 1
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      Utils.getTroopImage(
                                                          finallist[ind][index]["name"],
                                                          finallist[ind][index]["village"]),
                                                      finallist[ind][index]["level"] != finallist[ind][index]["maxLevel"]? ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.white10, width: 2),
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: Colors.black,
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                            child: Text(
                                                                (finallist[ind][index]["level"])
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 25)),
                                                          ),
                                                        ),
                                                      ) : ClipRRect(
                                                        borderRadius: BorderRadius.circular(8),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: const Color(0xffD7993E), width: 2),
                                                            borderRadius: BorderRadius.circular(8),
                                                            color: const Color(0xffFABD51),
                                                          ),
                                                          child: Shimmer(
                                                            color: Colors.white,
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                              child: Text(
                                                                  (finallist[ind][index]["level"])
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors.white,
                                                                      shadows: [Shadow(color: Colors.black, offset: Offset(0, 1.5))],
                                                                      fontSize: 25)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                  Wrap(
                                                    spacing: 2,
                                                    runSpacing: 5,
                                                    children: [
                                                      ?shiny != 0? ClipRRect(
                                                        borderRadius: BorderRadius.circular(20),
                                                        child: Container(
                                                          color: const Color(
                                                              0xff134365),
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Image.asset(
                                                                    shiny_ore, scale: 10),
                                                                SizedBox(width: 2),
                                                                Text(shiny.toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 10)),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ) : null,
                                                      ?glowy != 0? SizedBox(height: 3) : null,
                                                      ?glowy != 0? ClipRRect(
                                                        borderRadius: BorderRadius.circular(20),
                                                        child: Container(
                                                          color: const Color(0xff65135e),
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Image.asset(
                                                                    glowy_ore, scale: 10),
                                                                SizedBox(width: 2),
                                                                Text(glowy
                                                                    .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 10)),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ) : null,
                                                      ?starry != 0? SizedBox(height: 3) : null,
                                                      ?starry != 0? ClipRRect(
                                                        borderRadius: BorderRadius.circular(20),
                                                        child: Container(
                                                          color: const Color(0xff9e6b0d),
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Image.asset(
                                                                    starry_ore, scale: 10),
                                                                SizedBox(width: 2),
                                                                Text(starry.toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 10)),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ) : null
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                )
                              ),
                            ),
                          ],
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
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.black.withValues(alpha: 0.8), Colors.black.withValues(alpha: 0.6)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                              child: Text(titles[ind], style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30)
                              ),
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
                                          decoration: BoxDecoration(
                                            color: const Color(0xff101010),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
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
                                                      SizedBox(
                                                        width: 250,
                                                        child: AutoSizeText(
                                                            finallist[ind][index]["name"],
                                                            style: const TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 20),
                                                            maxLines: 1
                                                        ),
                                                      ),
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
                                                      SizedBox(
                                                        width: 300,
                                                        child: AutoSizeText(
                                                            finallist[ind][index]["info"],
                                                            style: const TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 12),
                                                            maxLines: 3
                                                        ),
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
                                                              fontSize: 12),
                                                          maxLines: 1
                                                      ),
                                                    ],
                                                  ),
                                                  AutoSizeText(
                                                      "${finallist[ind][index]["value"]}/${finallist[ind][index]["target"]}",
                                                      style: const TextStyle(
                                                          color: Colors.white,
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
                          ],
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.black.withValues(alpha: 0.8), Colors.black.withValues(alpha: 0.6)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
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
                                              fontSize: 15)
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          DataProvider.awaitBuilderLeagueIcon(snapshot.data[0], 4),
                                          SizedBox(width: 7),
                                          Text("Best: ${snapshot.data[0]["bestBuilderBaseTrophies"]}", style: const TextStyle(
                                              color: Colors.white,
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
                                              fontSize: 15)
                                          ),
                                          SizedBox(width: 25),
                                          Text(snapshot.data[0]["builderHallLevel"].toString(), style: const TextStyle(
                                              color: Colors.white,
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
                  ),
                  ?snapshot.data[0]["clan"] != null? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.black.withValues(alpha: 0.8), Colors.black.withValues(alpha: 0.6)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                                child: Text("Clan", style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30)
                                ),
                              ),
                              Padding(
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
                                                  fontSize: 30)
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Icon(Icons.language, color: Colors.white),
                                                  SizedBox(width: 5),
                                                  Text(snapshot.data[1]["location"]["name"], style: const TextStyle(
                                                      color: Colors.white54,
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
                                                      color: Colors.white54,
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
                                          SizedBox(width: 280,
                                              child: Text(
                                                  textWidthBasis: TextWidthBasis.parent, "${snapshot.data[1]["description"]}", style: const TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 11)
                                              )
                                          )
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
                                              color: Colors.white54,
                                              fontSize: 15)
                                          ),
                                          SizedBox(width: 10),
                                          Image.asset('lib/utils/img/BuilderHallTrophy.png',
                                              fit: BoxFit.cover, scale: 11.5),
                                          SizedBox(width: 7),
                                          Text("${snapshot.data[1]["clanBuilderBasePoints"]}", style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 15)
                                          ),
                                          SizedBox(width: 10),
                                          Image.asset('lib/utils/img/TrophyC.webp',
                                              fit: BoxFit.cover, scale: 1.5),
                                          SizedBox(width: 7),
                                          Text("${snapshot.data[1]["clanCapitalPoints"]}", style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 15)
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          DataProvider.awaitClanWarLeagueIcon(snapshot.data[1]["warLeague"]["name"], 1.2),
                                          SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Wins: ${snapshot.data[1]["warWins"]} / Ties: ${snapshot.data[1]["warTies"]} / Losses: ${snapshot.data[1]["warLosses"]}", style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.local_fire_department, color: Colors.deepOrange),
                                                  Text("Streak: ${snapshot.data[1]["warWinStreak"]}", style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15)
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ]
                                ),
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
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("${snapshot.data[1]["clanCapital"]["districts"][index]["name"]}", style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15)
                                                        ),
                                                        Text("Lvl: ${snapshot.data[1]["clanCapital"]["districts"][index]["districtHallLevel"]}", style: const TextStyle(
                                                            color: Colors.white54,
                                                            fontSize: 15)
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                            )
                                        )
                                    );
                                  }
                                  )
                              ),
                              SizedBox(height: 5),
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
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text("${snapshot.data[1]["memberList"][index]["clanRank"]}.", style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 25)
                                                          ),
                                                          SizedBox(width: 5),
                                                          Image.network(snapshot.data[1]["memberList"][index]["league"]["iconUrls"]["small"], scale: 2.5),
                                                          SizedBox(width: 10),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text("${snapshot.data[1]["memberList"][index]["name"]}", style: const TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 15)
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(Icons.arrow_upward, size: 20, color: Colors.white),
                                                                  SizedBox(width: 3),
                                                                  Text("${snapshot.data[1]["memberList"][index]["donations"]}", style: const TextStyle(
                                                                      color: Colors.white54,
                                                                      fontSize: 15)
                                                                  ),
                                                                  SizedBox(width: 10),
                                                                  Icon(Icons.arrow_downward, size: 20, color: Colors.white),
                                                                  SizedBox(width: 3),
                                                                  Text("${snapshot.data[1]["memberList"][index]["donationsReceived"]}", style: const TextStyle(
                                                                      color: Colors.white54,
                                                                      fontSize: 15)
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset('lib/utils/img/Trophy.png',
                                                              fit: BoxFit.cover, scale: 2),
                                                          SizedBox(width: 5),
                                                          Text("${snapshot.data[1]["memberList"][index]["trophies"]}", style: const TextStyle(
                                                              color: Colors.white54,
                                                              fontSize: 15)
                                                          ),
                                                          SizedBox(width: 5),
                                                          DataProvider.awaitTownHallIcon(snapshot.data[1]["memberList"][index]["townHallLevel"], 4),
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
                          ),
                        ),
                      ),
                    ),
                  ) : null
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

  Widget getClanWarLeagueDetails() {
    return FutureBuilder(
        future: Future.wait([DataProvider.awaitAllClanWarLeagueRounds(userTag), DataProvider.awaitPlayerClan(userTag)]),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            List ranking = Utils.getClanWarRanking(snapshot.data[0]).values.toList();
            return SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 2 * 10,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                DataProvider.awaitClanWarLeagueIcon(snapshot.data[1]["warLeague"]["name"], 1),
                                SizedBox(width: 5),
                                Text(snapshot.data[1]["warLeague"]["name"], style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30)
                                ),
                              ],
                            ),
                            Text("${snapshot.data[0]["round1"][0]["teamSize"]} vs. ${snapshot.data[0]["round1"][0]["teamSize"]}", style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ranking.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                  color: Colors.black,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${index + 1}. ${ranking[index]["name"]}", style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(star, scale: 1.5),
                                              SizedBox(width: 5),
                                              Text("${ranking[index]["stars"]}", style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)
                                              ),
                                              SizedBox(width: 15),
                                              Text("${ranking[index]["percentage"].toStringAsFixed(0)}%", style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                  )
                              )
                          ),
                        );
                      }
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data[0].length,
                      itemBuilder: (context, ind) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ?snapshot.data[0]["round${ind + 1}"].length != 0? Text("Round ${ind + 1}", style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30)
                            ) : null,
                            SizedBox(height: 10),
                            for(var element in snapshot.data[0]["round${ind + 1}"]) Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Flexible(flex: 5, child: Utils.getFirstClan(element, context)),
                                            Flexible(
                                              flex: 2,
                                              child: Image.asset(
                                                'lib/utils/img/CWLIcon.png',
                                                fit: BoxFit.cover,
                                                scale: 2.5,
                                              ),
                                            ),
                                            Flexible(flex: 5, child: Utils.getOpponentClan(element, context)),
                                          ]
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                  ),
                ],
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

  Widget getClanWarDetails(Map<String, dynamic> war) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.black,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children: [
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Utils.getClanWarStateText(war["state"], context),
                        SizedBox(width: 5),
                        ?war["state"] == "preparation" || war["state"] == "inWar"? CountDownText(
                          due: DateTime.parse(war["state"] == "preparation"? war["startTime"] : war["endTime"]),
                          finishedText: "War over!",
                          showLabel: true,
                          longDateName: true,
                          hoursTextLong: ":",
                          minutesTextLong: ":",
                          secondsTextLong: "",
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                        ) : null,
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Utils.getFirstClan(war, context),
                        Image.asset(
                          'lib/utils/img/CWLIcon.png',
                          fit: BoxFit.cover,
                          scale: 2.5,
                        ),
                        Utils.getOpponentClan(war, context),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ? war["state"] != "notInWar"? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for(var member in Utils.sortClanWarMembers(war["clan"]["members"])) Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Utils.getClanWarStars(member),
                                      Container(
                                        height: 70,
                                        child: DataProvider.awaitTownHallIcon(member["townhallLevel"], 2),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Attacks",
                                      style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15
                                      ),
                                      ),
                                      for(var attack in member["attacks"]?? []) Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("${war["opponent"]["members"].where((m) => m['tag'] == attack["defenderTag"]).toList()[0]["mapPosition"]}.",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            for(int i = 0; i < attack["stars"]; i++) Image.asset(whitestar, scale: 6),
                                            for(int j = 0; j < (3 - attack["stars"]); j++) Image.asset(whitestarempty, scale: 6),
                                          ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(width: 15),
                                              Text("${attack["destructionPercentage"]}%",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              AutoSizeText("${member["mapPosition"]}. ${member["name"]}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                                ),
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for(var member in Utils.sortClanWarMembers(war["opponent"]["members"])) Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Attacks",
                                      style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15
                                      ),
                                      ),
                                      for(var attack in (member["attacks"] ?? [])) Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("${war["clan"]["members"].where((m) => m['tag'] == attack["defenderTag"]).toList()[0]["mapPosition"]}.",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15
                                                ),
                                              ),
                                              SizedBox(width: 2),
                                              for(int i = 0; i < attack["stars"]; i++) Image.asset(whitestar, scale: 6),
                                              for(int j = 0; j < (3 - attack["stars"]); j++) Image.asset(whitestarempty, scale: 6),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(width: 15),
                                              Text("${attack["destructionPercentage"]}%",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Utils.getClanWarStars(member),
                                      Container(
                                        height: 70,
                                        child: DataProvider.awaitTownHallIcon(member["townhallLevel"], 2),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              AutoSizeText("${member["mapPosition"]}. ${member["name"]}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                                ),
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ) : null,
        ]
      ),
    );
  }

  Widget getClanWarLogDetails() {
    return FutureBuilder(
        future: Future.wait([DataProvider.awaitClanWarLog(userTag)/*, DataProvider.awaitExtClanWarLog(userTag)*/]),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            List<dynamic> clanwars = Utils.filterClanWars(snapshot.data[0]["items"]);
            //List<dynamic> clanwarsext = Utils.filterClanWars(snapshot.data[1]["items"]);
            return SingleChildScrollView(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: clanwars.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            margin: EdgeInsets.symmetric(vertical: 2),
                            width: MediaQuery.of(context).size.width - 2 * 20,
                            color: clanwars[index]["result"] == "win"? const Color(0xff1b3317) : clanwars[index]["result"] == "lose"? const Color(0xff2b0e0e) : const Color(0xff494949),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${clanwars[index]["teamSize"]} vs. ${clanwars[index]["teamSize"]}", style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15)
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 5,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  AutoSizeText(clanwars[index]["clan"]["name"], style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                    maxLines: 1,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Image.network(clanwars[index]["clan"]["badgeUrls"]["small"], scale: 2),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text("${clanwars[index]["clan"]["stars"]}", style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15)
                                                  ),
                                                  SizedBox(width: 2),
                                                  Image.asset(whitestar, scale: 6),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Image.asset(
                                            'lib/utils/img/CWLIcon.png',
                                            fit: BoxFit.cover,
                                            scale: 4,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 5,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.network(clanwars[index]["opponent"]["badgeUrls"]["small"], scale: 2),
                                                  SizedBox(width: 5),
                                                  AutoSizeText(clanwars[index]["opponent"]["name"], style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                    maxLines: 1,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(whitestar, scale: 6),
                                                  SizedBox(width: 2),
                                                  Text("${clanwars[index]["opponent"]["stars"]}", style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15)
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    /*?(index < 10 && clanwarsext[index]["clan"]["members"] != null)? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(
                                                  Colors.black),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                        30.0),
                                                  )
                                              )
                                          ),
                                          onPressed: (){
                                            Navigator.pushNamed(context, "/detail", arguments: ArgumentClass("clanwar", clanwarsext[index]));
                                          },
                                          child: Text("Details", style: const TextStyle(
                                            color: Colors.white,

                                            fontSize: 15)
                                          )
                                        )
                                      ],
                                    ) : null,*/
                                  ],
                                )
                            )
                        )
                    );
                  }),
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