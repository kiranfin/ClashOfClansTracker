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
                                            DataProvider.awaitLeagueIcon(
                                              snapshot.data[0],
                                            ),
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
                                            DataProvider.awaitPlayerLegendTrophies(
                                              snapshot.data[0],
                                              20,
                                            ),
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
                      ?snapshot.data[0]["legendStatistics"] != null? Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: List.generate(3 ,(index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [

                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ) : null,
                      ?snapshot.data[0]["legendStatistics"] != null? SizedBox(height: 20): null,
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
