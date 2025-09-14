import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashofclanstracker/pages/startscreen.dart';
import 'package:clashofclanstracker/utils/ArgumentClass.dart';
import 'package:clashofclanstracker/utils/UserSP.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../provider/DataProvider.dart' as DataProvider;
import '../utils/Utils.dart' as Utils;
import '../utils/img/ShortAsset.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String userTag = UserSP.getCurrentUser();
  Map<String, dynamic> userMap = UserSP.getDecodedUserMap();

  @override
  Widget build(BuildContext context) {
    if(UserSP.getUser().isEmpty) {
      return StartScreenPage();
    }
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: FutureBuilder(
                  future: Future.wait([DataProvider.awaitPlayerData(userTag), DataProvider.awaitBuildings(), DataProvider.awaitMaxTroops(), DataProvider.awaitMaxEquipment()]),
                  builder: (context, AsyncSnapshot ovsnap) {
                    if(ovsnap.hasData) {
                      if(userMap.containsKey(userTag)) {
                        userMap[userTag] = ovsnap.data[0]["name"];
                        UserSP.setUserMap(userMap);
                      }
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
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                Navigator.pushNamed(
                                    context, "/detail", arguments: ArgumentClass("profile", {}));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            DataProvider.awaitLeagueIcon(ovsnap.data[0]),
                                            SizedBox(width: 5),
                                            SizedBox(width: 150, child: AutoSizeText(ovsnap.data[0]["name"], style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.surface), maxLines: 1))
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
                                            DataProvider.awaitPlayerTrophies(ovsnap.data[0], 15, context),
                                            SizedBox(width: 7),
                                            Image.asset(legendTrophy, scale: 14),
                                            SizedBox(width: 7),
                                            DataProvider.awaitPlayerLegendTrophies(ovsnap.data[0], 15, context),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            DataProvider.awaitBuilderLeagueIcon(ovsnap.data[0], 4),
                                            SizedBox(width: 7),
                                            DataProvider.awaitPlayerBuilderTrophies(ovsnap.data[0], 15, context),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        DataProvider.awaitClanIcon(ovsnap.data[0]),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            DataProvider.awaitTownHallIcon(ovsnap.data[0]["townHallLevel"], 3),
                                            SizedBox(width: 10),
                                            DataProvider.awaitBuilderHallIcon(ovsnap.data[0]["builderHallLevel"], 2.5),
                                          ],
                                        )
                                      ],
                                    ),
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
                                        "Overall", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.surface)),
                                    Text("${(DataProvider.awaitOverallPercent(
                                        ovsnap.data[0], ovsnap.data[1], ovsnap.data[2], ovsnap.data[3]) * 100)
                                        .toStringAsFixed(1)}%",
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface)),
                                  ],
                                ),
                                radius: 80,
                                lineWidth: 25,
                                percent: DataProvider.awaitOverallPercent(
                                    ovsnap.data[0], ovsnap.data[1], ovsnap.data[2], ovsnap.data[3]),
                                circularStrokeCap: CircularStrokeCap
                                    .round,
                                backgroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
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
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                    onPressed: () async {
                                      await Navigator.pushNamed(
                                          context, "/detail", arguments: ArgumentClass("buildings", {}));
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                            'Buildings',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                            maxLines: 1
                                        ),
                                        SizedBox(height: 5),
                                        CircularPercentIndicator(
                                          center: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("${(DataProvider.awaitBuildingsPercent(ovsnap.data[0], ovsnap.data[1]) * 100)
                                                  .toStringAsFixed(
                                                  1)}%",
                                                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface)),
                                            ],
                                          ),
                                          radius: 40,
                                          lineWidth: 12,
                                          percent: DataProvider.awaitBuildingsPercent(ovsnap.data[0], ovsnap.data[1]),
                                          circularStrokeCap: CircularStrokeCap
                                              .round,
                                          backgroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
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
                              ),
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                    onPressed: () async {
                                      await Navigator.pushNamed(
                                          context, "/detail", arguments: ArgumentClass("troops", {}));
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                            'Troops',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                            maxLines: 1
                                        ),
                                        SizedBox(height: 5),
                                        CircularPercentIndicator(
                                          center: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              Text("${(DataProvider.awaitTroopsPercent(ovsnap.data[0], ovsnap.data[2]) * 100)
                                                  .toStringAsFixed(1)}%",
                                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface)),
                                            ],
                                          ),
                                          radius: 40,
                                          lineWidth: 12,
                                          percent: DataProvider.awaitTroopsPercent(ovsnap.data[0], ovsnap.data[2]),
                                          circularStrokeCap: CircularStrokeCap
                                              .round,
                                          backgroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
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
                              ),
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                    onPressed: () async {
                                      await Navigator.pushNamed(
                                          context, "/detail", arguments: ArgumentClass("spells", {}));
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                            'Spells',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                            maxLines: 1
                                        ),
                                        SizedBox(height: 5),
                                        CircularPercentIndicator(
                                          center: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              Text("${(DataProvider.awaitSpellsPercent(ovsnap.data[0], ovsnap.data[2]) * 100)
                                                  .toStringAsFixed(1)}%",
                                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface)),
                                            ],
                                          ),
                                          radius: 40,
                                          lineWidth: 12,
                                          percent: DataProvider.awaitSpellsPercent(ovsnap.data[0], ovsnap.data[2]),
                                          circularStrokeCap: CircularStrokeCap
                                              .round,
                                          backgroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
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
                              ),
                            ],
                          ),

                          //2nd Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                    onPressed: () async {
                                      await Navigator.pushNamed(
                                          context, "/detail", arguments: ArgumentClass("heroes", {}));
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                            'Heroes',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                            maxLines: 1
                                        ),
                                        SizedBox(height: 5),
                                        CircularPercentIndicator(
                                          center: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              Text("${(DataProvider.awaitHeroesPercent(ovsnap.data[0], ovsnap.data[2]) * 100)
                                                  .toStringAsFixed(1)}%",
                                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface)),
                                            ],
                                          ),
                                          radius: 40,
                                          lineWidth: 12,
                                          percent: DataProvider.awaitHeroesPercent(ovsnap.data[0], ovsnap.data[2]),
                                          circularStrokeCap: CircularStrokeCap
                                              .round,
                                          backgroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
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
                              ),
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                    onPressed: () async {
                                      await Navigator.pushNamed(context, "/detail",
                                          arguments: ArgumentClass("equipment", {}));
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                            'Equipment',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                            maxLines: 1
                                        ),
                                        SizedBox(height: 5),
                                        CircularPercentIndicator(
                                          center: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              Text("${(DataProvider.awaitEquipmentPercent(ovsnap.data[0], ovsnap.data[3]) * 100)
                                                  .toStringAsFixed(1)}%",
                                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface)),
                                            ],
                                          ),
                                          radius: 40,
                                          lineWidth: 12,
                                          percent: DataProvider.awaitEquipmentPercent(ovsnap.data[0], ovsnap.data[3]),
                                          circularStrokeCap: CircularStrokeCap
                                              .round,
                                          backgroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
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
                              ),
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                    onPressed: () async {
                                      await Navigator.pushNamed(context, "/detail",
                                          arguments: ArgumentClass("achievements", {}));
                                      setState(() {});
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                            'Achievem.',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                            maxLines: 1
                                        ),
                                        SizedBox(height: 5),
                                        CircularPercentIndicator(
                                          center: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              Text("${(DataProvider.awaitAchievementsPercent(ovsnap.data[0]) * 100)
                                                  .toStringAsFixed(1)}%",
                                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface)),
                                            ],
                                          ),
                                          radius: 40,
                                          lineWidth: 12,
                                          percent: DataProvider.awaitAchievementsPercent(ovsnap.data[0]),
                                          circularStrokeCap: CircularStrokeCap
                                              .round,
                                          backgroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
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
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                                  color: Theme.of(context).colorScheme.surface,
                                                  child: SizedBox(width: 45, height: 45))
                                          ),
                                          SizedBox(width: 5),
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Shimmer(
                                                  color: Theme.of(context).colorScheme.surface,
                                                  child: SizedBox(
                                                      width: 100,
                                                      height: 20))
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
                                                  color: Theme.of(context).colorScheme.surface,
                                                  child: SizedBox(
                                                      width: 40,
                                                      height: 20))
                                          ),
                                          SizedBox(width: 7),
                                          Image.asset(legendTrophy, scale: 14),
                                          SizedBox(width: 7),
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Shimmer(
                                                  color: Theme.of(context).colorScheme.surface,
                                                  child: SizedBox(
                                                      width: 40,
                                                      height: 20))
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
                                                  color: Theme.of(context).colorScheme.surface,
                                                  child: SizedBox(
                                                      width: 20,
                                                      height: 20))
                                          ),
                                          SizedBox(width: 7),
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Shimmer(
                                                  color: Theme.of(context).colorScheme.surface,
                                                  child: SizedBox(
                                                      width: 40,
                                                      height: 20))
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
                                          child: Shimmer(
                                              color: Theme.of(context).colorScheme.surface,child: SizedBox(
                                              width: 45,
                                              height: 45))
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Shimmer(
                                                  color: Theme.of(context).colorScheme.surface,
                                                  child: SizedBox(
                                                      width: 45,
                                                      height: 45))
                                          ),
                                          SizedBox(width: 10),
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Shimmer(
                                                  color: Theme.of(context).colorScheme.surface,
                                                  child: SizedBox(
                                                      width: 45,
                                                      height: 45))
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
                                  child: Shimmer(
                                      color: Theme.of(context).colorScheme.surface,
                                      child: SizedBox(
                                      width: 150,
                                      height: 150))
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          //1st row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                            'Buildings',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                            maxLines: 1
                                        ),
                                        SizedBox(height: 5),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Shimmer(
                                                color: Theme.of(context).colorScheme.surface,
                                                child: SizedBox(
                                                width: 110,
                                                height: 80)
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                            'Troops',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                            maxLines: 1
                                        ),
                                        SizedBox(height: 5),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Shimmer(
                                                color: Theme.of(context).colorScheme.surface,child: SizedBox(
                                                width: 110,
                                                height: 80))
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                            'Spells',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                            maxLines: 1
                                        ),
                                        SizedBox(height: 5),
                                        ClipRRect(
                                            borderRadius: BorderRadius
                                                .circular(10),
                                            child: Shimmer(
                                                color: Theme.of(context).colorScheme.surface,
                                                child: SizedBox(
                                                width: 110,
                                                height: 80))
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //2nd Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                            'Heros',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                            maxLines: 1
                                        ),
                                        SizedBox(height: 5),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Shimmer(
                                                color: Theme.of(context).colorScheme.surface,
                                                child: SizedBox(
                                                width: 110,
                                                height: 80))
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                            'Equipment',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                            maxLines: 1
                                        ),
                                        SizedBox(height: 5),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Shimmer(
                                                color: Theme.of(context).colorScheme.surface,
                                                child: SizedBox(
                                                width: 110,
                                                height: 80))
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).colorScheme.surfaceContainer),
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                            'Achievem.',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface),
                                            maxLines: 1
                                        ),
                                        SizedBox(height: 5),
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Shimmer(
                                            color: Theme.of(context).colorScheme.surface,
                                                child: SizedBox(
                                                width: 110,
                                                height: 80))
                                        ),
                                      ],
                                    ),
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
      ),
    );
  }
}