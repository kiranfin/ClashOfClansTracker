import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../provider/DataProvider.dart' as DataProvider;
import '../utils/Utils.dart' as Utils;

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

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
            child: category == "troops" ? getTroopDetail() : category == "spells"? getSpellDetail() : getHeroesDetail(),
          ),
        ),
      ),
    );
  }


  Widget getTroopDetail() {
    return FutureBuilder(
      future: DataProvider.awaitTroops("P9V29R8RJ"),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          List finallist = [];
          finallist.addAll(Utils.getNormalTroops(snapshot.data));
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
        future: DataProvider.awaitSpells("P9V29R8RJ"),
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
        future: DataProvider.awaitHeroes("P9V29R8RJ"),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            List finallist = [];
            finallist.addAll(Utils.getNormalHeroes(snapshot.data));
            finallist.addAll(Utils.getBuilderHeroes(snapshot.data));
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
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
                                    style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20),
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
                                SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Max: ${finallist[index]["maxLevel"]}", style: const TextStyle(color: Colors.white,
                                              fontFamily: "Poppins",
                                              fontSize: 15)),
                                          Row(
                                            children: [
                                              Icon(Icons.access_time, color: Colors.white, size: 14),
                                              SizedBox(width: 5),
                                              Text("1d 12h", style: const TextStyle(color: Colors.white,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15)),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Utils.isNormalHero(finallist[index]["name"])? Utils.getTroopImage(finallist[index]["equipment"][0]["name"], finallist[index]["equipment"][0]["village"]): Container(),
                                              Utils.isNormalHero(finallist[index]["name"])? Utils.getTroopImage(finallist[index]["equipment"][1]["name"], finallist[index]["equipment"][1]["village"]) : Container(),
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