import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../provider/DataProvider.dart' as DataProvider;
import '../utils/UserSP.dart';
import '../utils/Utils.dart' as Utils;
import '../utils/img/ShortAsset.dart';

class LeaguePage extends StatefulWidget {
  const LeaguePage({super.key});

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  String userTag = UserSP.getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 15.0,
            ),
            child: FutureBuilder(
              future: Future.wait([DataProvider.awaitPlayerData(userTag)]),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            DataProvider.awaitLeagueIcon(snapshot.data[0]),
                                            SizedBox(width: 5),
                                            AutoSizeText(snapshot.data[0]["league"] != null? snapshot.data[0]["league"]["name"] : "Unranked",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 30,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Attack Wins: ${snapshot.data[0]["attackWins"]}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Defense Wins: ${snapshot.data[0]["defenseWins"]}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'lib/utils/img/Trophy.png',
                                              fit: BoxFit.cover,
                                              scale: 1.5,
                                            ),
                                            SizedBox(width: 7),
                                            DataProvider.awaitPlayerTrophies(
                                              snapshot.data[0],
                                              20,
                                            ),
                                          ],
                                        ),
                                        ?snapshot.data[0]["legendStatistics"] !=null? Row(
                                          children: [
                                            Image.asset(
                                              legendTrophy,
                                              scale: 14,
                                            ),
                                            SizedBox(width: 7),
                                            DataProvider.awaitPlayerLegendTrophies(snapshot.data[0], 20),
                                          ],
                                        ) : null,
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ?snapshot.data[0]["legendStatistics"] != null? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for(int index = 0; index < 3; index++) ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 3 * 95,
                              color: Colors.black,
                                child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(index == 0? "Current" : index == 1? "Previous" : "Best",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontSize: 20,
                                      ),
                                      maxLines: 1,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time_outlined, color: Colors.white, size: 20),
                                        SizedBox(width: 5),
                                        Text("${index == 0? "${DateTime.parse(snapshot.data[0]["legendStatistics"]["previousSeason"]["id"] + "-01").year}-${(DateTime.parse(snapshot.data[0]["legendStatistics"]["previousSeason"]["id"] + "-01").month + 1).toString().padLeft(2, "0")}" : index == 1? (snapshot.data[0]["legendStatistics"]["previousSeason"]!=null? snapshot.data[0]["legendStatistics"]["previousSeason"]["id"] : "-") : (snapshot.data[0]["legendStatistics"]["bestSeason"]!=null? snapshot.data[0]["legendStatistics"]["bestSeason"]["id"] : "-")}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.tag, color: Colors.white, size: 20),
                                        SizedBox(width: 5),
                                        Text("${index == 0? (snapshot.data[0]["legendStatistics"]["currentSeason"]!=null?snapshot.data[0]["legendStatistics"]["currentSeason"]["rank"]: "-") : index == 1? (snapshot.data[0]["legendStatistics"]["previousSeason"]!=null? snapshot.data[0]["legendStatistics"]["previousSeason"]["rank"] : "-") : (snapshot.data[0]["legendStatistics"]["bestSeason"]!=null? snapshot.data[0]["legendStatistics"]["bestSeason"]["rank"]: "-")}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'lib/utils/img/Trophy.png',
                                          fit: BoxFit.cover,
                                          scale: 1.5,
                                        ),
                                        SizedBox(width: 5),
                                        Text("${index == 0? (snapshot.data[0]["legendStatistics"]["currentSeason"]!=null?snapshot.data[0]["legendStatistics"]["currentSeason"]["trophies"] : "-") : index == 1? (snapshot.data[0]["legendStatistics"]["previousSeason"]!=null? snapshot.data[0]["legendStatistics"]["previousSeason"]["trophies"] : "-") : (snapshot.data[0]["legendStatistics"]["bestSeason"]!=null? snapshot.data[0]["legendStatistics"]["bestSeason"]["trophies"]: "-")}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ) : null,
                      ?snapshot.data[0]["legendStatistics"] != null? SizedBox(height: 20): null,
                      ?snapshot.data[0]["builderBaseLeague"] != null? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    DataProvider.awaitBuilderLeagueIcon(snapshot.data[0], 2.5),
                                    SizedBox(width: 7),
                                    AutoSizeText(snapshot.data[0]["builderBaseLeague"] != null? snapshot.data[0]["builderBaseLeague"]["name"] : "Unranked",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontSize: 25,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ]
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'lib/utils/img/BuilderHallTrophy.png',
                                      fit: BoxFit.cover,
                                      scale: 12,
                                    ),
                                    SizedBox(width: 5),
                                    DataProvider.awaitPlayerBuilderTrophies(snapshot.data[0], 20),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ) : null,
                      ?snapshot.data[0]["builderBaseLeague"] != null? SizedBox(height: 20): null,
                      Text("Current CWL",
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 25,
                        ),
                      ),
                      ClipRRect(
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
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("-",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                      'lib/utils/img/CWLIcon.png',
                                      fit: BoxFit.cover,
                                      scale: 2.5,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("-",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 150,
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Row(children: [])],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
