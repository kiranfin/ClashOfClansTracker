import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashofclanstracker/utils/ArgumentClass.dart';
import 'package:date_count_down/date_count_down.dart';
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
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary]
          )
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 25.0,
              ),
              child: FutureBuilder(
                future: Future.wait([DataProvider.awaitPlayerData(userTag), DataProvider.awaitClanWarLeague(userTag), DataProvider.awaitCurrentClanWarLeagueWar(userTag), DataProvider.awaitCurrentClanWar(userTag), DataProvider.awaitNextClanWarLeagueWar(userTag), DataProvider.awaitClanWarLog(userTag)]),
                builder: (context, AsyncSnapshot snapshot) {
                  snapshot.hasError? print(snapshot.error): null;
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).colorScheme.primary),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.secondaryContainer],
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
                                    children: [
                                      DataProvider.awaitLeagueIcon(snapshot.data[0]),
                                      SizedBox(width: 5),
                                      AutoSizeText(snapshot.data[0]["league"] != null? snapshot.data[0]["league"]["name"] : "Unranked",
                                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                              Image.asset(swords, scale: 2.5),
                                              SizedBox(width: 5),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Attack Wins: ${snapshot.data[0]["attackWins"]}",
                                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "Defense Wins: ${snapshot.data[0]["defenseWins"]}",
                                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                                  ),
                                                ],
                                              ),
                                            ],
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
                                              DataProvider.awaitPlayerTrophies(snapshot.data[0], 20, context),
                                            ],
                                          ),
                                          ?snapshot.data[0]["legendStatistics"] !=null? Row(
                                            children: [
                                              Image.asset(
                                                legendTrophy,
                                                scale: 14,
                                              ),
                                              SizedBox(width: 7),
                                              DataProvider.awaitPlayerLegendTrophies(snapshot.data[0], 20, context),
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
                        ?snapshot.data[0]["legendStatistics"] != null? SizedBox(height: 20): null,
                        ?snapshot.data[0]["legendStatistics"] != null? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(int index = 0; index < 3; index++) Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Theme.of(context).colorScheme.primary),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.secondaryContainer],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                      child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(index == 0? "Current" : index == 1? "Previous" : "Best",
                                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                            maxLines: 1,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.access_time_outlined, color: Theme.of(context).colorScheme.onSurface, size: 20),
                                              SizedBox(width: 5),
                                              Text("${index == 0? "${DateTime.now().year}-${(DateTime.now().month).toString().padLeft(2, "0")}" : index == 1? (snapshot.data[0]["legendStatistics"]["previousSeason"]!=null? snapshot.data[0]["legendStatistics"]["previousSeason"]["id"] : "-") : (snapshot.data[0]["legendStatistics"]["bestSeason"]!=null? snapshot.data[0]["legendStatistics"]["bestSeason"]["id"] : "-")}",
                                                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(Icons.tag, color: Theme.of(context).colorScheme.onSurface, size: 20),
                                              SizedBox(width: 5),
                                              Text("${index == 0? (snapshot.data[0]["legendStatistics"]["currentSeason"]!=null?snapshot.data[0]["legendStatistics"]["currentSeason"]["rank"]: "-") : index == 1? (snapshot.data[0]["legendStatistics"]["previousSeason"]!=null? snapshot.data[0]["legendStatistics"]["previousSeason"]["rank"] : "-") : (snapshot.data[0]["legendStatistics"]["bestSeason"]!=null? snapshot.data[0]["legendStatistics"]["bestSeason"]["rank"]: "-")}",
                                                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Image.asset(
                                                'lib/utils/img/Trophy.png',
                                                fit: BoxFit.cover,
                                                scale: 1.5,
                                              ),
                                              SizedBox(width: 5),
                                              Text("${index == 0? (snapshot.data[0]["legendStatistics"]["currentSeason"]!=null?snapshot.data[0]["legendStatistics"]["currentSeason"]["trophies"] : "-") : index == 1? (snapshot.data[0]["legendStatistics"]["previousSeason"]!=null? snapshot.data[0]["legendStatistics"]["previousSeason"]["trophies"] : "-") : (snapshot.data[0]["legendStatistics"]["bestSeason"]!=null? snapshot.data[0]["legendStatistics"]["bestSeason"]["trophies"]: "-")}",
                                                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ) : null,
                        ?snapshot.data[0]["builderBaseLeague"] != null? SizedBox(height: 20): null,
                        ?snapshot.data[0]["builderBaseLeague"] != null? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).colorScheme.primary),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.secondaryContainer],
                                ),
                              borderRadius: BorderRadius.circular(30),
                            ),
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
                                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
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
                                      DataProvider.awaitPlayerBuilderTrophies(snapshot.data[0], 20, context),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ) : null,
                        ?snapshot.data[2]["state"] != null? SizedBox(height: 20): null,
                        ?snapshot.data[2]["state"] != null? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).colorScheme.primary),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.secondaryContainer],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/detail", arguments: ArgumentClass("cwl", {}));
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Current CWL",
                                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Utils.getStateText(snapshot.data[2]["state"], context),
                                        SizedBox(width: 5),
                                        (snapshot.data[2]["state"] == "preparation" || snapshot.data[2]["state"] == "inWar" || snapshot.data[2]["state"] == "warEnded") && (snapshot.data[4].isNotEmpty)? CountDownText(
                                          due: snapshot.data[2]["state"] == "preparation"? DateTime.parse(snapshot.data[2]["startTime"]) : snapshot.data[2]["state"] == "inWar"? DateTime.parse(snapshot.data[2]["endTime"]) : DateTime.parse(snapshot.data[4]["startTime"]),
                                          finishedText: "-",
                                          showLabel: true,
                                          longDateName: true,
                                          hoursTextLong: ":",
                                          minutesTextLong: ":",
                                          secondsTextLong: "",
                                          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                        ) : Text("-",
                                          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(flex: 5, child: Utils.getFirstClan(snapshot.data[2], context)),
                                        Flexible(
                                          flex: 2,
                                          child: Image.asset(
                                            'lib/utils/img/CWLIcon.png',
                                            fit: BoxFit.cover,
                                            scale: 2.5,
                                          ),
                                        ),
                                        Flexible(flex: 5, child: Utils.getOpponentClan(snapshot.data[2], context)),
                                      ]
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ) : null,
                        ?snapshot.data[3]["state"] != null? SizedBox(height: 20) : null,
                        ?snapshot.data[3]["state"] != null? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).colorScheme.primary),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.secondaryContainer],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "/detail", arguments: ArgumentClass("clanwar", snapshot.data[3]));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text("Current Clan War",
                                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            snapshot.data[3].isEmpty? Text("Clan Log private",
                                                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                            ) : Utils.getClanWarStateText(snapshot.data[3]["state"], context),
                                            SizedBox(width: 5),
                                            ?snapshot.data[3]["state"] == "preparation" || snapshot.data[3]["state"] == "inWar"? CountDownText(
                                            due: DateTime.parse(snapshot.data[3]["state"] == "preparation"? snapshot.data[3]["startTime"] : snapshot.data[3]["endTime"]),
                                            finishedText: "War vorbei!",
                                            showLabel: true,
                                            longDateName: true,
                                            hoursTextLong: ":",
                                            minutesTextLong: ":",
                                            secondsTextLong: "",
                                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                            ) : null,
                                          ],
                                        ),
                                        ?snapshot.data[3]["state"] != "notInWar"? Row(
                                          children: [
                                            Text("${snapshot.data[3]["teamSize"]} vs. ${snapshot.data[3]["teamSize"]}",
                                              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                            ),
                                          ],
                                        ) : null,
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Flexible(flex: 5, child: Utils.getFirstClan(snapshot.data[3], context)),
                                        Flexible(flex: 2, child: Image.asset(
                                        'lib/utils/img/CWLIcon.png',
                                        fit: BoxFit.cover,
                                        scale: 2.5,
                                        )),
                                        Flexible(flex: 5, child: Utils.getOpponentClan(snapshot.data[3], context)),
                                      ]
                                    ),
                                  ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ) : null,
                        ?snapshot.data[5]["items"].isNotEmpty? SizedBox(height: 20) : null,
                        ?snapshot.data[5]["items"].isNotEmpty? ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).colorScheme.primary),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.secondaryContainer],
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Clan War Log",
                                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                                    ),
                                    SizedBox(height: 5),
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 4,
                                      itemBuilder: (BuildContext context, int index) {
                                        List<dynamic> clanwars = Utils.filterClanWars(snapshot.data[5]["items"]);
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(vertical: 2),
                                            width: MediaQuery.of(context).size.width - 2 * 20,
                                            color: clanwars[index]["result"] == "win"? Colors.transparent.withValues(alpha: 0.2, green: 0.7) : clanwars[index]["result"] == "lose"? Colors.transparent.withValues(alpha: 0.2, red: 0.7) : Theme.of(context).colorScheme.surface.withValues(alpha: 0.2),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("${clanwars[index]["teamSize"]} vs. ${clanwars[index]["teamSize"]}", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
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
                                                                AutoSizeText(clanwars[index]["clan"]["name"], style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                                                  maxLines: 1,
                                                                ),
                                                                SizedBox(width: 5),
                                                                Image.network(clanwars[index]["clan"]["badgeUrls"]["small"], scale: 2),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Text("${clanwars[index]["clan"]["stars"]}", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.surface)
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
                                                                AutoSizeText(clanwars[index]["opponent"]["name"], style: TextStyle(
                                                                  color: Theme.of(context).colorScheme.surface,
                                                                  fontSize: 12),
                                                                  maxLines: 1,
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Image.asset(whitestar, scale: 6),
                                                                SizedBox(width: 2),
                                                                Text("${clanwars[index]["opponent"]["stars"]}", style: TextStyle(
                                                                  color: Theme.of(context).colorScheme.surface,
                                                                  fontSize: 15)
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            )
                                          )
                                        );
                                      }
                                    ),
                                    SizedBox(height: 5),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3),
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(context, "/detail", arguments: ArgumentClass("clanwarlog", {}));
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("See all", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.tertiary),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                              ),
                          ),
                        ) : null,
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Theme.of(context).colorScheme.surfaceContainer,
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
                                              ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 50, height: 50))),
                                              SizedBox(width: 5),
                                              ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 80, height: 30))),
                                            ],
                                          ),
                                          ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 120, height: 20))),
                                          SizedBox(height: 5),
                                          ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 120, height: 20))),
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
                                              ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 20, height: 20))),
                                              SizedBox(width: 7),
                                              ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 50, height: 20))),
                                            ],
                                          )
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 50, height: 50))),
                                    SizedBox(width: 7),
                                    ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 100, height: 30))),
                                  ]
                                ),
                                Row(
                                  children: [
                                    ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 20, height: 20))),
                                    SizedBox(width: 5),
                                    ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 50, height: 20))),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.primary),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.secondaryContainer],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {

                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Current CWL",
                                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                                  ),
                                  SizedBox(height: 5),
                                  ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 150, height: 20))),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Flexible(
                                      flex: 5,
                                        child: Column(
                                          children: [
                                            ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 60, height: 60))),
                                            SizedBox(height: 5),
                                            ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 120, height: 20))),
                                          ],
                                        ),
                                      ),
                                      Flexible(flex: 2, child: Image.asset(
                                        'lib/utils/img/CWLIcon.png',
                                        fit: BoxFit.cover,
                                        scale: 2.5,
                                      )),
                                      Flexible(
                                        flex: 5,
                                        child: Column(
                                          children: [
                                            ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 60, height: 60))),
                                            SizedBox(height: 5),
                                            ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 120, height: 20))),
                                          ],
                                        ),
                                      ),
                                    ]
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.primary),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.secondaryContainer],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Current Clan War",
                                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                                ),
                                SizedBox(height: 5),
                                ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 150, height: 20))),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      flex: 5,
                                      child: Column(
                                        children: [
                                          ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 60, height: 60))),
                                          SizedBox(height: 5),
                                          ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 120, height: 20))),
                                        ],
                                      ),
                                    ),
                                    Flexible(flex: 2, child: Image.asset(
                                      'lib/utils/img/CWLIcon.png',
                                      fit: BoxFit.cover,
                                      scale: 2.5,
                                    )),
                                    Flexible(
                                      flex: 5,
                                      child: Column(
                                        children: [
                                          ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 60, height: 60))),
                                          SizedBox(height: 5),
                                          ClipRRect(borderRadius: BorderRadius.circular(10),child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 120, height: 20))),
                                        ],
                                      ),
                                    ),
                                  ]
                                ),
                              ],
                            ),
                            ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).colorScheme.primary),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.secondaryContainer],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Clan War Log",
                                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
                                ),
                                SizedBox(height: 5),
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 4,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                      title: ClipRRect(borderRadius: BorderRadius.circular(10), child: Shimmer(color: Theme.of(context).colorScheme.surface, child: SizedBox(width: 50, height: 15))),
                                    );
                                  }
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.3),
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: () {

                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("See all", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.tertiary)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
