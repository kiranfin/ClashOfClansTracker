import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashofclanstracker/utils/img/ShortAsset.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import '../provider/DataProvider.dart' as DataProvider;
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: category == "troops" ? getTroopDetail() : category == "spells"?
            getSpellDetail() : category == "heroes"? getHeroesDetail() : category == "equipment"? getEquipmentDetail() : getAchievementDetails(),
          ),
        ),
      ),
    );
  }


  Widget getTroopDetail() {
    return FutureBuilder(
      future: DataProvider.awaitTroops(userTag),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          List finallist = [];
          finallist.addAll(Utils.getNormalTroops(snapshot.data));
          finallist.addAll(Utils.getPets(snapshot.data));
          finallist.addAll(Utils.getSuperTroops(snapshot.data));
          finallist.addAll(Utils.getBuilderTroops(snapshot.data));
          finallist.addAll(Utils.getSiegeMachines(snapshot.data));
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
              itemCount: 3,
              itemBuilder: (context, ind) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titles[ind], style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 30)),
                    Container(
                      child: GridView.builder(
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
                                  child: Utils.isPet(finallist[ind][index]["name"])?
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
                                  : GridTile(
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
                                                Column(
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
            List finallist = Utils.getEquipment(snapshot.data);
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
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Max: ${finallist[index]["maxLevel"]}", style: const TextStyle(color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontSize: 10)),
                                      Row(
                                        children: [
                                          Image.asset(shiny_ore, scale: 10),
                                          SizedBox(width: 2),
                                          Text(Utils.getNextShiny(finallist[index]).toString(), style: const TextStyle(color: Colors.white,
                                              fontFamily: "Poppins",
                                              fontSize: 10)),
                                          SizedBox(width: 3),
                                          Image.asset(glowy_ore, scale: 10),
                                          SizedBox(width: 2),
                                          Text(Utils.getNextGlowy(finallist[index]).toString(), style: const TextStyle(color: Colors.white,
                                              fontFamily: "Poppins",
                                              fontSize: 10)),
                                          SizedBox(width: 3),
                                          Image.asset(starry_ore, scale: 10),
                                          SizedBox(width: 2),
                                          Text(Utils.getNextStarry(finallist[index]).toString(), style: const TextStyle(color: Colors.white,
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
            List finallist = Utils.filterAchievements(Utils.getAchievements(snapshot.data));
            return ListView.builder(
                itemCount: finallist.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: finallist[index]["value"] >= finallist[index]["target"]? Color(
                            0xFF532D1F): Colors.black,
                        child: GridTile(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AutoSizeText(
                                        finallist[index]["name"],
                                        style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20),
                                        maxLines: 1
                                    ),
                                    SizedBox(width: 30),
                                    finallist[index]["stars"] == 3? Image.asset(three_star) : finallist[index]["stars"] == 2? Image.asset(two_star) : Image.asset(one_star)
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    AutoSizeText(
                                        finallist[index]["info"],
                                        style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 12),
                                        maxLines: 1
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SimpleAnimationProgressBar(
                                        ratio: finallist[index]["value"] / finallist[index]["target"],
                                        width: 150,
                                        height: 10,
                                        direction: Axis.horizontal,
                                        backgroundColor: Colors.grey.shade800,
                                        foregroundColor: Colors.purple,
                                        duration: const Duration(seconds: 3),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        borderRadius: BorderRadius.circular(10),
                                        gradientColor: LinearGradient(
                                            colors: [Colors.greenAccent, Colors.lightGreen]),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.lightGreen,
                                            blurRadius: 2.5,
                                            spreadRadius: 2.0,
                                          ),
                                        ],
                                    ),
                                    SizedBox(width: 10),
                                    finallist[index]["value"] >= finallist[index]["target"]? SizedBox() : AutoSizeText(((finallist[index]["value"] / finallist[index]["target"]) * 100).toStringAsFixed(2) + "%",
                                        style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 12),
                                        maxLines: 1
                                    ),
                                  ],
                                ),
                                AutoSizeText("${finallist[index]["value"]}/${finallist[index]["target"]}",
                                    style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 12),
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