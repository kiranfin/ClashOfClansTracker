import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  late List<dynamic> asyncData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      fetchData();
    });
  }

  void fetchData() async {
    try {
      print("lol");
      asyncData = await Future.wait([DataProvider.awaitLeagueIcon("P9V29R8RJ"), DataProvider.awaitPlayerName("P9V29R8RJ"),
        DataProvider.awaitPlayerTrophies("P9V29R8RJ"), DataProvider.awaitPlayerLegendTrophies("P9V29R8RJ"),
        DataProvider.awaitBuilderLeagueIcon("P9V29R8RJ"), DataProvider.awaitPlayerBuilderTrophies("P9V29R8RJ"),
        DataProvider.awaitClanIcon("P9V29R8RJ"), DataProvider.awaitClanTroopsOut("P9V29R8RJ"),
        DataProvider.awaitClanTroopsIn("P9V29R8RJ"), DataProvider.awaitOverallPercent("P9V29R8RJ"),
        DataProvider.awaitBuildingsPercent("P9V29R8RJ"), DataProvider.awaitTroopsPercent("P9V29R8RJ"),
        DataProvider.awaitSpellsPercent("P9V29R8RJ"), DataProvider.awaitHeroesPercent("P9V29R8RJ"),
        DataProvider.awaitEquipmentPercent("P9V29R8RJ"), DataProvider.awaitQuestsPercent("P9V29R8RJ")]);
      print(asyncData.length);
    } catch(error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 120.0,
                  width: MediaQuery.of(context).size.width - 2 * 20,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black12),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FutureBuilder<Image>(
                                  future: asyncData[0],
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data;
                                    } else {
                                      return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 45, height: 45, color: Colors.black45)));
                                    }
                                  }
                                ),
                                SizedBox(width: 5),
                                FutureBuilder<Text>(
                                    future: asyncData[1],
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        return snapshot.data;
                                      } else {
                                        return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 100, height: 20, color: Colors.black45)));
                                      }
                                    }
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('lib/utils/img/Trophy.png', fit: BoxFit.cover, scale: 1.5),
                                SizedBox(width: 7),
                                FutureBuilder<Text>(
                                    future: asyncData[2],
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        return snapshot.data;
                                      } else {
                                        return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 40, height: 20, color: Colors.black45)));
                                      }
                                    }
                                ),
                                SizedBox(width: 7),
                                Image.asset(legendTrophy, scale: 14),
                                SizedBox(width: 7),
                                FutureBuilder<Text>(
                                    future: asyncData[3],
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        return snapshot.data;
                                      } else {
                                        return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 40, height: 20, color: Colors.black45)));
                                      }
                                    }
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FutureBuilder<Image>(
                                    future: asyncData[4],
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        return snapshot.data;
                                      } else {
                                        return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 20, height: 20, color: Colors.black45)));
                                      }
                                    }
                                ),
                                SizedBox(width: 7),
                                FutureBuilder<Text>(
                                    future: asyncData[5],
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        return snapshot.data;
                                      } else {
                                        return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 40, height: 20, color: Colors.black45)));
                                      }
                                    }
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            FutureBuilder<Image>(
                                future: asyncData[6],
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return snapshot.data;
                                  } else {
                                    return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 45, height: 45, color: Colors.black45)));
                                  }
                                }
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Troops", style: TextStyle(color: Colors.white, fontSize: 15)),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text("Out", style: TextStyle(color: Colors.white, fontSize: 8)),
                                        FutureBuilder<Text>(
                                            future: asyncData[7],
                                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                                              if (snapshot.hasData) {
                                                return snapshot.data;
                                              } else {
                                                return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 40, height: 15, color: Colors.black45)));
                                              }
                                            }
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      children: [
                                        Text("In", style: TextStyle(color: Colors.white, fontSize: 8)),
                                        FutureBuilder<Text>(
                                            future: asyncData[8],
                                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                                              if (snapshot.hasData) {
                                                return snapshot.data;
                                              } else {
                                                return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 40, height: 15, color: Colors.black45)));
                                              }
                                            }
                                        ),
                                      ],
                                    ),
                                  ],
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
                    FutureBuilder<double>(
                      future: asyncData[9],
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return CircularPercentIndicator(
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Overall", style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontSize: 25)),
                                Text("${(snapshot.data * 100).toStringAsFixed(1)}%",
                                    style: const TextStyle(color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontSize: 15)),
                              ],
                            ),
                            radius: 80,
                            lineWidth: 25,
                            percent: snapshot.data,
                            circularStrokeCap: CircularStrokeCap.round,
                            backgroundColor: Colors.white10,
                            rotateLinearGradient: true,
                            linearGradient: LinearGradient(
                                colors: [Colors.indigoAccent, Colors.purple]
                            ),
                          );
                        } else {
                          return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 150, height: 150, color: Colors.black45)));
                        }
                      }
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
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )
                            )
                        ),
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              'Buildings',
                              style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
                              maxLines: 1
                            ),
                            SizedBox(height: 5),
                            FutureBuilder<double>(
                              future: asyncData[10],
                              builder: (context, AsyncSnapshot snapshot) {
                                if(snapshot.hasData) {
                                  return CircularPercentIndicator(
                                    center: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text("${(snapshot.data * 100).toStringAsFixed(
                                            1)}%", style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 15)),
                                      ],
                                    ),
                                    radius: 40,
                                    lineWidth: 12,
                                    percent: snapshot.data,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: Colors.white10,
                                    rotateLinearGradient: true,
                                    linearGradient: LinearGradient(
                                        colors: [
                                          Colors.indigoAccent,
                                          Colors.purple
                                        ]
                                    ),
                                  );
                                } else {
                                  return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 110, height: 80, color: Colors.black45)));
                                }
                              }
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
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )
                            )
                        ),
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                                'Troops',
                                style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
                                maxLines: 1
                            ),
                            SizedBox(height: 5),
                            FutureBuilder<double>(
                              future: asyncData[11],
                              builder: (context, AsyncSnapshot snapshot) {
                                  if(snapshot.hasData) {
                                    return CircularPercentIndicator(
                                      center: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("${(snapshot.data * 100).toStringAsFixed(1)}%", style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 15)),
                                        ],
                                      ),
                                      radius: 40,
                                      lineWidth: 12,
                                      percent: snapshot.data,
                                      circularStrokeCap: CircularStrokeCap.round,
                                      backgroundColor: Colors.white10,
                                      rotateLinearGradient: true,
                                      linearGradient: LinearGradient(
                                          colors: [Colors.indigoAccent, Colors.purple]
                                      ),
                                    );
                                  } else {
                                    return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 110, height: 80, color: Colors.black45)));
                                  }
                              }
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
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )
                            )
                        ),
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                                'Spells',
                                style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
                                maxLines: 1
                            ),
                            SizedBox(height: 5),
                            FutureBuilder<double>(
                              future: asyncData[12],
                              builder: (context, AsyncSnapshot snapshot) {
                                if(snapshot.hasData) {
                                  return CircularPercentIndicator(
                                    center: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${(snapshot.data * 100).toStringAsFixed(1)}%", style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 15)),
                                      ],
                                    ),
                                    radius: 40,
                                    lineWidth: 12,
                                    percent: snapshot.data,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: Colors.white10,
                                    rotateLinearGradient: true,
                                    linearGradient: LinearGradient(
                                        colors: [Colors.indigoAccent, Colors.purple]
                                    ),
                                  );
                                } else {
                                  return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 110, height: 80, color: Colors.black45)));
                                }
                              }
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
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )
                            )
                        ),
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                                'Heros',
                                style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
                                maxLines: 1
                            ),
                            SizedBox(height: 5),
                            FutureBuilder<double>(
                              future: asyncData[13],
                              builder: (context, AsyncSnapshot snapshot) {
                                if(snapshot.hasData) {
                                  return CircularPercentIndicator(
                                    center: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${(snapshot.data * 100).toStringAsFixed(1)}%", style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 15)),
                                      ],
                                    ),
                                    radius: 40,
                                    lineWidth: 12,
                                    percent: snapshot.data,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: Colors.white10,
                                    rotateLinearGradient: true,
                                    linearGradient: LinearGradient(
                                        colors: [Colors.indigoAccent, Colors.purple]
                                    ),
                                  );
                                } else {
                                  return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 110, height: 80, color: Colors.black45)));
                                }
                              }
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
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )
                            )
                        ),
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                                'Equipment',
                                style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
                                maxLines: 1
                            ),
                            SizedBox(height: 5),
                            FutureBuilder<double>(
                              future: asyncData[14],
                              builder: (context, AsyncSnapshot snapshot) {
                                if(snapshot.hasData) {
                                  return CircularPercentIndicator(
                                    center: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${(snapshot.data * 100).toStringAsFixed(1)}%", style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 15)),
                                      ],
                                    ),
                                    radius: 40,
                                    lineWidth: 12,
                                    percent: snapshot.data,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: Colors.white10,
                                    rotateLinearGradient: true,
                                    linearGradient: LinearGradient(
                                        colors: [Colors.indigoAccent, Colors.purple]
                                    ),
                                  );
                                } else {
                                  return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 110, height: 80, color: Colors.black45)));
                                }
                              }
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
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )
                            )
                        ),
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                                'Quests',
                                style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
                                maxLines: 1
                            ),
                            SizedBox(height: 5),
                            FutureBuilder<double>(
                              future: asyncData[15],
                              builder: (context, AsyncSnapshot snapshot) {
                                if(snapshot.hasData) {
                                  return CircularPercentIndicator(
                                    center: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${(snapshot.data * 100).toStringAsFixed(1)}%", style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 15)),
                                      ],
                                    ),
                                    radius: 40,
                                    lineWidth: 12,
                                    percent: snapshot.data,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: Colors.white10,
                                    rotateLinearGradient: true,
                                    linearGradient: LinearGradient(
                                        colors: [Colors.indigoAccent, Colors.purple]
                                    ),
                                  );
                                } else {
                                  return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 110, height: 80, color: Colors.black45)));
                                }
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}