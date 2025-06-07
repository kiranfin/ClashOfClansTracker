import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashofclanstracker/utils/UserSP.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../provider/DataProvider.dart' as DataProvider;
import '../utils/img/ShortAsset.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String userTag = UserSP.getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: FutureBuilder(
                future: DataProvider.awaitPlayerData(userTag),
                builder: (context, AsyncSnapshot ovsnap) {
                  if(ovsnap.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 120.0,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 2 * 20,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.black),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    )
                                )
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        DataProvider.awaitLeagueIcon(ovsnap.data),
                                        SizedBox(width: 5),
                                        DataProvider.awaitPlayerName(ovsnap.data)
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Image.asset('lib/utils/img/Trophy.png',
                                            fit: BoxFit.cover, scale: 1.5),
                                        SizedBox(width: 7),
                                        DataProvider.awaitPlayerTrophies(ovsnap.data),
                                        SizedBox(width: 7),
                                        Image.asset(legendTrophy, scale: 14),
                                        SizedBox(width: 7),
                                        DataProvider.awaitPlayerLegendTrophies(ovsnap.data),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        DataProvider.awaitBuilderLeagueIcon(ovsnap.data),
                                        SizedBox(width: 7),
                                        DataProvider.awaitPlayerBuilderTrophies(ovsnap.data),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    DataProvider.awaitClanIcon(ovsnap.data),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        DataProvider.awaitTownHallIcon(ovsnap.data),
                                        SizedBox(width: 10),
                                        DataProvider.awaitBuilderHallIcon(ovsnap.data),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularPercentIndicator(
                              center: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center,
                                children: [
                                  Text(
                                      "Overall", style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 25)),
                                  Text("${(DataProvider.awaitOverallPercent(
                                      ovsnap.data) * 100)
                                      .toStringAsFixed(1)}%",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontSize: 15)),
                                ],
                              ),
                              radius: 80,
                              lineWidth: 25,
                              percent: DataProvider.awaitOverallPercent(
                                  ovsnap.data),
                              circularStrokeCap: CircularStrokeCap
                                  .round,
                              backgroundColor: Colors.white10,
                              rotateLinearGradient: true,
                              linearGradient: LinearGradient(
                                  colors: [
                                    Colors.indigoAccent,
                                    Colors.purple
                                  ]
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        //1st row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 120.0,
                              width: 110.0,
                              child: ElevatedButton(
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
                                onPressed: () {

                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                        'Buildings',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                        maxLines: 1
                                    ),
                                    SizedBox(height: 5),
                                    CircularPercentIndicator(
                                      center: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text("${(DataProvider.awaitBuildingsPercent(ovsnap.data) * 100)
                                              .toStringAsFixed(
                                              1)}%",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15)),
                                        ],
                                      ),
                                      radius: 40,
                                      lineWidth: 12,
                                      percent: DataProvider.awaitBuildingsPercent(ovsnap.data),
                                      circularStrokeCap: CircularStrokeCap
                                          .round,
                                      backgroundColor: Colors.white10,
                                      rotateLinearGradient: true,
                                      linearGradient: LinearGradient(
                                          colors: [
                                            Colors.orange,
                                            Colors.deepOrangeAccent
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 120.0,
                              width: 110.0,
                              child: ElevatedButton(
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
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/detail", arguments: "troops");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                        'Troops',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                        maxLines: 1
                                    ),
                                    SizedBox(height: 5),
                                    CircularPercentIndicator(
                                      center: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text("${(DataProvider.awaitTroopsPercent(ovsnap.data) * 100)
                                              .toStringAsFixed(1)}%",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15)),
                                        ],
                                      ),
                                      radius: 40,
                                      lineWidth: 12,
                                      percent: DataProvider.awaitTroopsPercent(ovsnap.data),
                                      circularStrokeCap: CircularStrokeCap
                                          .round,
                                      backgroundColor: Colors.white10,
                                      rotateLinearGradient: true,
                                      linearGradient: LinearGradient(
                                          colors: [
                                            Colors.lightGreen,
                                            Colors.green
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 120.0,
                              width: 110.0,
                              child: ElevatedButton(
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
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/detail", arguments: "spells");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                        'Spells',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                        maxLines: 1
                                    ),
                                    SizedBox(height: 5),
                                    CircularPercentIndicator(
                                      center: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text("${(DataProvider.awaitSpellsPercent(ovsnap.data) * 100)
                                              .toStringAsFixed(1)}%",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15)),
                                        ],
                                      ),
                                      radius: 40,
                                      lineWidth: 12,
                                      percent: DataProvider.awaitSpellsPercent(ovsnap.data),
                                      circularStrokeCap: CircularStrokeCap
                                          .round,
                                      backgroundColor: Colors.white10,
                                      rotateLinearGradient: true,
                                      linearGradient: LinearGradient(
                                          colors: [
                                            Colors.pinkAccent,
                                            Colors.purple
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        //2nd Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 120.0,
                              width: 110.0,
                              child: ElevatedButton(
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
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/detail", arguments: "heroes");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                        'Heros',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                        maxLines: 1
                                    ),
                                    SizedBox(height: 5),
                                    CircularPercentIndicator(
                                      center: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text("${(DataProvider.awaitHeroesPercent(ovsnap.data) * 100)
                                              .toStringAsFixed(1)}%",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15)),
                                        ],
                                      ),
                                      radius: 40,
                                      lineWidth: 12,
                                      percent: DataProvider.awaitHeroesPercent(ovsnap.data),
                                      circularStrokeCap: CircularStrokeCap
                                          .round,
                                      backgroundColor: Colors.white10,
                                      rotateLinearGradient: true,
                                      linearGradient: LinearGradient(
                                          colors: [
                                            Colors.cyan,
                                            Colors.blueAccent
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 120.0,
                              width: 110.0,
                              child: ElevatedButton(
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
                                onPressed: () {
                                  Navigator.pushNamed(context, "/detail",
                                      arguments: "equipment");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                        'Equipment',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                        maxLines: 1
                                    ),
                                    SizedBox(height: 5),
                                    CircularPercentIndicator(
                                      center: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text("${(DataProvider.awaitEquipmentPercent(ovsnap.data) * 100)
                                              .toStringAsFixed(1)}%",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15)),
                                        ],
                                      ),
                                      radius: 40,
                                      lineWidth: 12,
                                      percent: DataProvider.awaitEquipmentPercent(ovsnap.data),
                                      circularStrokeCap: CircularStrokeCap
                                          .round,
                                      backgroundColor: Colors.white10,
                                      rotateLinearGradient: true,
                                      linearGradient: LinearGradient(
                                          colors: [
                                            Colors.blueGrey,
                                            Colors.teal
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 120.0,
                              width: 110.0,
                              child: ElevatedButton(
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
                                onPressed: () {
                                  Navigator.pushNamed(context, "/detail",
                                      arguments: "achievements");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                        'Achievem.',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                        maxLines: 1
                                    ),
                                    SizedBox(height: 5),
                                    CircularPercentIndicator(
                                      center: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text("${(DataProvider.awaitAchievementsPercent(ovsnap.data) * 100)
                                              .toStringAsFixed(1)}%",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Poppins",
                                                  fontSize: 15)),
                                        ],
                                      ),
                                      radius: 40,
                                      lineWidth: 12,
                                      percent: DataProvider.awaitAchievementsPercent(ovsnap.data),
                                      circularStrokeCap: CircularStrokeCap
                                          .round,
                                      backgroundColor: Colors.white10,
                                      rotateLinearGradient: true,
                                      linearGradient: LinearGradient(
                                          colors: [
                                            Colors.yellow,
                                            Colors.orange
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 120.0,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 2 * 20,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.black),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    )
                                )
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Shimmer(
                                                child: Container(width: 45, height: 45, color: Colors.black45))
                                        ),
                                        SizedBox(width: 5),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Shimmer(
                                                child: Container(
                                                    width: 100,
                                                    height: 20,
                                                    color: Colors.black45))
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Image.asset('lib/utils/img/Trophy.png',
                                            fit: BoxFit.cover, scale: 1.5),
                                        SizedBox(width: 7),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Shimmer(
                                                child: Container(
                                                    width: 40,
                                                    height: 20,
                                                    color: Colors.black45))
                                        ),
                                        SizedBox(width: 7),
                                        Image.asset(legendTrophy, scale: 14),
                                        SizedBox(width: 7),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Shimmer(
                                                child: Container(
                                                    width: 40,
                                                    height: 20,
                                                    color: Colors.black45))
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Shimmer(
                                                child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    color: Colors.black45))
                                        ),
                                        SizedBox(width: 7),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Shimmer(
                                                child: Container(
                                                    width: 40,
                                                    height: 20,
                                                    color: Colors.black45))
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Shimmer(child: Container(
                                            width: 45,
                                            height: 45,
                                            color: Colors.black45))
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Shimmer(
                                                child: Container(
                                                    width: 45,
                                                    height: 45,
                                                    color: Colors.black45))
                                        ),
                                        SizedBox(width: 10),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Shimmer(
                                                child: Container(
                                                    width: 45,
                                                    height: 45,
                                                    color: Colors.black45))
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Shimmer(child: Container(
                                    width: 150,
                                    height: 150,
                                    color: Colors.black45))
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        //1st row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 120.0,
                              width: 110.0,
                              child: ElevatedButton(
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
                                onPressed: () {

                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                        'Buildings',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                        maxLines: 1
                                    ),
                                    SizedBox(height: 5),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Shimmer(child: Container(
                                            width: 110,
                                            height: 80,
                                            color: Colors.black45))),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 120.0,
                              width: 110.0,
                              child: ElevatedButton(
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
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/detail", arguments: "troops");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                        'Troops',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                        maxLines: 1
                                    ),
                                    SizedBox(height: 5),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Shimmer(child: Container(
                                            width: 110,
                                            height: 80,
                                            color: Colors.black45))
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 120.0,
                              width: 110.0,
                              child: ElevatedButton(
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
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/detail", arguments: "spells");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                        'Spells',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                        maxLines: 1
                                    ),
                                    SizedBox(height: 5),
                                    ClipRRect(
                                        borderRadius: BorderRadius
                                            .circular(10),
                                        child: Shimmer(child: Container(
                                            width: 110,
                                            height: 80,
                                            color: Colors.black45))
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        //2nd Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 120.0,
                              width: 110.0,
                              child: ElevatedButton(
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
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/detail", arguments: "heroes");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                        'Heros',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                        maxLines: 1
                                    ),
                                    SizedBox(height: 5),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Shimmer(child: Container(
                                            width: 110,
                                            height: 80,
                                            color: Colors.black45))
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 120.0,
                              width: 110.0,
                              child: ElevatedButton(
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
                                onPressed: () {
                                  Navigator.pushNamed(context, "/detail",
                                      arguments: "equipment");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                        'Equipment',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                        maxLines: 1
                                    ),
                                    SizedBox(height: 5),
                                    ClipRRect(
                                        borderRadius: BorderRadius
                                            .circular(10),
                                        child: Shimmer(child: Container(
                                            width: 110,
                                            height: 80,
                                            color: Colors.black45))
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              height: 120.0,
                              width: 110.0,
                              child: ElevatedButton(
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
                                onPressed: () {
                                  Navigator.pushNamed(context, "/detail",
                                      arguments: "achievements");
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                        'Achievem.',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins"),
                                        maxLines: 1
                                    ),
                                    SizedBox(height: 5),
                                    ClipRRect(
                                        borderRadius: BorderRadius
                                            .circular(10),
                                        child: Shimmer(child: Container(
                                            width: 110,
                                            height: 80,
                                            color: Colors.black45))
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                }
              ),
            )
        ),
      ),
    );
  }
}