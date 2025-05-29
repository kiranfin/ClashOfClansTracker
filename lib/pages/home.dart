import 'package:auto_size_text/auto_size_text.dart';
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
                                      future: DataProvider.awaitLeagueIcon("P9V29R8RJ"),
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
                                      future: DataProvider.awaitPlayerName("P9V29R8RJ"),
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
                                      future: DataProvider.awaitPlayerTrophies("P9V29R8RJ"),
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
                                      future: DataProvider.awaitPlayerLegendTrophies("P9V29R8RJ"),
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
                                      future: DataProvider.awaitBuilderLeagueIcon("P9V29R8RJ"),
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
                                      future: DataProvider.awaitPlayerBuilderTrophies("P9V29R8RJ"),
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
                                  future: DataProvider.awaitClanIcon("P9V29R8RJ"),
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data;
                                    } else {
                                      return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 45, height: 45, color: Colors.black45)));
                                    }
                                  }
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FutureBuilder<Image>(
                                      future: DataProvider.awaitTownHallIcon("P9V29R8RJ"),
                                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          return snapshot.data;
                                        } else {
                                          return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 45, height: 45, color: Colors.black45)));
                                        }
                                      }
                                  ),
                                  SizedBox(width: 10),
                                  FutureBuilder<Image>(
                                      future: DataProvider.awaitBuilderHallIcon("P9V29R8RJ"),
                                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          return snapshot.data;
                                        } else {
                                          return ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(child: Container(width: 45, height: 45, color: Colors.black45)));
                                        }
                                      }
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
                          future: DataProvider.awaitOverallPercent("P9V29R8RJ"),
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
                          onPressed: () {

                          },
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
                                  future: DataProvider.awaitBuildingsPercent("P9V29R8RJ"),
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
                          onPressed: () {
                            Navigator.pushNamed(context, "/detail", arguments: "troops");
                          },
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
                                  future: DataProvider.awaitTroopsPercent("P9V29R8RJ"),
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
                          onPressed: () {
                            Navigator.pushNamed(context, "/detail", arguments: "spells");
                          },
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
                                  future: DataProvider.awaitSpellsPercent("P9V29R8RJ"),
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
                          onPressed: () {
                            Navigator.pushNamed(context, "/detail", arguments: "heroes");
                          },
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
                                  future: DataProvider.awaitHeroesPercent("P9V29R8RJ"),
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
                                  future: DataProvider.awaitEquipmentPercent("P9V29R8RJ"),
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
                                  future: DataProvider.awaitQuestsPercent("P9V29R8RJ"),
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