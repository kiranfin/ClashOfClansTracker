import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashofclanstracker/utils/img/ShortAsset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../utils/UserSP.dart';
import '../utils/Utils.dart' as Utils;

Future<Map<String, dynamic>> awaitPlayerData(String tag) async {
  final url = Uri.parse('${Utils.getBaseUrl()}players/$tag');
  final res = await http.get(url);
  final status = res.statusCode;
  final reason = res.reasonPhrase;
  if (status != 200) throw Exception('http.get error (player data): statusCode= $status reason= $reason');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> awaitPlayerClan(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return {};
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('${Utils.getBaseUrl()}clans/$clantag');
  final res = await http.get(url);
  final status = res.statusCode;
  final reason = res.reasonPhrase;
  if (status != 200) throw Exception('http.get error (player clan): statusCode= $status reason= $reason');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> awaitClanWarLeague(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return {};
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('${Utils.getBaseUrl()}clanwarleague/current/$clantag');
  final res = await http.get(url);
  final status = res.statusCode;
  final reason = res.reasonPhrase;
  if (status != 200) throw Exception('http.get error (clan war league): statusCode= $status reason= $reason');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>?> awaitCurrentClanWarLeagueWar(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return {};
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('${Utils.getBaseUrl()}clanwarleague/currentday/$clantag');
  final res = await http.get(url);
  final status = res.statusCode;
  final reason = res.reasonPhrase;
  if (status != 200) throw Exception('http.get error (current clan war league war): statusCode= $status reason= $reason');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>?> awaitNextClanWarLeagueWar(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return {};
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('${Utils.getBaseUrl()}clanwarleague/nextday/$clantag');
  final res = await http.get(url);
  final status = res.statusCode;
  final reason = res.reasonPhrase;
  if (status != 200) throw Exception('http.get error (next clan war league war): statusCode= $status reason= $reason');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> awaitClanWarLeagueWar(String tag) async {
  final url = Uri.parse('${Utils.getBaseUrl()}clanwarleague/war/$tag');
  final res = await http.get(url);
  final status = res.statusCode;
  final reason = res.reasonPhrase;
  if (status != 200) throw Exception('http.get error (clan war league war): statusCode= $status reason= $reason');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String,dynamic>> awaitAllClanWarLeagueRounds(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return {};
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('${Utils.getBaseUrl()}clanwarleague/rounds/$clantag');
  final res = await http.get(url);
  final status = res.statusCode;
  final reason = res.reasonPhrase;
  if (status != 200) throw Exception('http.get error (all clan war league rounds): statusCode= $status reason= $reason');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String,dynamic>> awaitCurrentClanWar(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return {};
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('${Utils.getBaseUrl()}clanwar/current/$clantag');
  final res = await http.get(url);
  final status = res.statusCode;
  final reason = res.reasonPhrase;
  if (status != 200) throw Exception('http.get error (current clan war): statusCode= $status reason= $reason');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<List<dynamic>> awaitExtClanWarLog(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return [];
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('https://api.clashk.ing/war/%23$clantag/previous?timestamp_start=0&timestamp_end=9999999999&limit=20');
  final res = await http.get(url);
  final status = res.statusCode;
  final reason = res.reasonPhrase;
  if (status != 200) throw Exception('http.get error (clan war log): statusCode= $status reason= $reason');
  List<dynamic> resultList = jsonDecode(res.body) as List<dynamic>;
  List<dynamic> sortedresultList = resultList.where((o) => o['attacksPerMember'] == 2).toList();
  return sortedresultList;
}

Future<Map<String,dynamic>> awaitClanWarLog(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return {};
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('${Utils.getBaseUrl()}clanwar/warlog/$clantag');
  final res = await http.get(url);
  final status = res.statusCode;
  final reason = res.reasonPhrase;
  if (status != 200) throw Exception('http.get error (clan war log): statusCode= $status reason= $reason');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> awaitBuildings() async {
  final url = Uri.parse('${Utils.getBaseUrl()}retrieve/buildings');
  final res = await http.get(url);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> awaitMaxTroops() async {
  final url = Uri.parse('${Utils.getBaseUrl()}retrieve/troops');
  final res = await http.get(url);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> awaitMaxEquipment() async {
  final url = Uri.parse('${Utils.getBaseUrl()}retrieve/equipment');
  final res = await http.get(url);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> awaitGameData() async {
  final url = Uri.parse('${Utils.getBaseUrl()}retrieve/gamedata');
  final res = await http.get(url);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Image awaitTownHallIcon(int level, double scale) {
  if(level == 1) return Image.asset(th1, scale: scale);
  if(level == 2) return Image.asset(th2, scale: scale);
  if(level == 3) return Image.asset(th3, scale: scale);
  if(level == 4) return Image.asset(th4, scale: scale);
  if(level == 5) return Image.asset(th5, scale: scale);
  if(level == 6) return Image.asset(th6, scale: scale);
  if(level == 7) return Image.asset(th7, scale: scale);
  if(level == 8) return Image.asset(th8, scale: scale);
  if(level == 9) return Image.asset(th9, scale: scale);
  if(level == 10) return Image.asset(th10, scale: scale);
  if(level == 11) return Image.asset(th11, scale: scale);
  if(level == 12) return Image.asset(th12, scale: scale);
  if(level == 13) return Image.asset(th13, scale: scale);
  if(level == 14) return Image.asset(th14, scale: scale);
  if(level == 15) return Image.asset(th15, scale: scale);
  if(level == 16) return Image.asset(th16, scale: scale);
  if(level == 17) return Image.asset(th17, scale: scale);
  return Image.asset(th1, scale: scale);
}

Image awaitBuilderHallIcon(int level, double scale) {
  if(level == 1) return Image.asset(bh1, scale: scale);
  if(level == 2) return Image.asset(bh2, scale: scale);
  if(level == 3) return Image.asset(bh3, scale: scale);
  if(level == 4) return Image.asset(bh4, scale: scale);
  if(level == 5) return Image.asset(bh5, scale: scale);
  if(level == 6) return Image.asset(bh6, scale: scale);
  if(level == 7) return Image.asset(bh7, scale: scale);
  if(level == 8) return Image.asset(bh8, scale: scale);
  if(level == 9) return Image.asset(bh9, scale: scale);
  if(level == 10) return Image.asset(bh10, scale: scale);
  return Image.asset(bh1, scale: scale);
}

Image awaitLeagueIcon(Map<String, dynamic> userdata) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  if(userdata["league"] != null) {
    return Image.network(userdata["league"]["iconUrls"]["small"], scale: 1.5);
  } else{
    return Image.asset(unranked, scale: 2.5);
  }
}

Image awaitBuilderLeagueIcon(Map<String, dynamic> userdata, double scale) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  final league = userdata["builderBaseLeague"]["name"];
  if (league == "Wood League V") return Image.asset(wood, scale: scale);
  if (league == "Wood League IV") return Image.asset(wood, scale: scale);
  if (league == "Wood League III") return Image.asset(wood, scale: scale);
  if (league == "Wood League II") return Image.asset(wood, scale: scale);
  if (league == "Wood League I") return Image.asset(wood, scale: scale);
  if (league == "Clay League V") return Image.asset(clay, scale: scale);
  if (league == "Clay League IV") return Image.asset(clay, scale: scale);
  if (league == "Clay League III") return Image.asset(clay, scale: scale);
  if (league == "Clay League II") return Image.asset(clay, scale: scale);
  if (league == "Clay League I") return Image.asset(clay, scale: scale);
  if (league == "Stone League V") return Image.asset(stone, scale: scale);
  if (league == "Stone League IV") return Image.asset(stone, scale: scale);
  if (league == "Stone League III") return Image.asset(stone, scale: scale);
  if (league == "Stone League II") return Image.asset(stone, scale: scale);
  if (league == "Stone League I") return Image.asset(stone, scale: scale);
  if (league == "Copper League V") return Image.asset(copper, scale: scale);
  if (league == "Copper League IV") return Image.asset(copper, scale: scale);
  if (league == "Copper League III") return Image.asset(copper, scale: scale);
  if (league == "Copper League II") return Image.asset(copper, scale: scale);
  if (league == "Copper League I") return Image.asset(copper, scale: scale);
  if (league == "Brass League III") return Image.asset(brass, scale: scale);
  if (league == "Brass League II") return Image.asset(brass, scale: scale);
  if (league == "Brass League I") return Image.asset(brass, scale: scale);
  if (league == "Iron League III") return Image.asset(iron, scale: scale);
  if (league == "Iron League II") return Image.asset(iron, scale: scale);
  if (league == "Iron League I") return Image.asset(iron, scale: scale);
  if (league == "Steel League III") return Image.asset(steel, scale: scale);
  if (league == "Steel League II") return Image.asset(steel, scale: scale);
  if (league == "Steel League I") return Image.asset(steel, scale: scale);
  if (league == "Titanium League III") return Image.asset(titanium, scale: scale);
  if (league == "Titanium League II") return Image.asset(titanium, scale: scale);
  if (league == "Titanium League I") return Image.asset(titanium, scale: scale);
  if (league == "Platinum League III") return Image.asset(platinum, scale: scale);
  if (league == "Platinum League II") return Image.asset(platinum, scale: scale);
  if (league == "Platinum League I") return Image.asset(platinum, scale: scale);
  if (league == "Emerald League III") return Image.asset(emerald, scale: scale);
  if (league == "Emerald League II") return Image.asset(emerald, scale: scale);
  if (league == "Emerald League I") return Image.asset(emerald, scale: scale);
  if (league == "Ruby League III") return Image.asset(ruby, scale: scale);
  if (league == "Ruby League II") return Image.asset(ruby, scale: scale);
  if (league == "Ruby League I") return Image.asset(ruby, scale: scale);
  if (league == "Diamond League I") return Image.asset(diamond, scale: scale);
  return Image.asset(wood, scale: scale);
}

Image awaitClanWarLeagueIcon(String league, double scale) {
  if(league == "Bronze League I") return Image.asset(war_bronze1, scale: scale);
  if(league == "Bronze League II") return Image.asset(war_bronze2, scale: scale);
  if(league == "Bronze League III") return Image.asset(war_bronze3, scale: scale);
  if(league == "Silver League I") return Image.asset(war_silver1, scale: scale);
  if(league == "Silver League II") return Image.asset(war_silver2, scale: scale);
  if(league == "Silver League III") return Image.asset(war_silver3, scale: scale);
  if(league == "Gold League I") return Image.asset(war_gold1, scale: scale);
  if(league == "Gold League II") return Image.asset(war_gold2, scale: scale);
  if(league == "Gold League III") return Image.asset(war_gold3, scale: scale);
  if(league == "Crystal League I") return Image.asset(war_crystal1, scale: scale);
  if(league == "Crystal League II") return Image.asset(war_crystal2, scale: scale);
  if(league == "Crystal League III") return Image.asset(war_crystal3, scale: scale);
  if(league == "Master League I") return Image.asset(war_master1, scale: scale);
  if(league == "Master League II") return Image.asset(war_master2, scale: scale);
  if(league == "Master League III") return Image.asset(war_master3, scale: scale);
  if(league == "Champion League I") return Image.asset(war_champion1, scale: scale);
  if(league == "Champion League II") return Image.asset(war_champion2, scale: scale);
  if(league == "Champion League III") return Image.asset(war_champion3, scale: scale);
  return Image.asset(war_bronze1, scale: scale);
}

SizedBox awaitPlayerName(Map<String, dynamic> userdata) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  return SizedBox(width: 150, child: AutoSizeText(userdata["name"], style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: "Inter"), maxLines: 1));
}

Text awaitPlayerTrophies(Map<String, dynamic> userdata, double size) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  return Text((userdata["trophies"]).toString(), style: TextStyle(color: Colors.white, fontSize: size, fontFamily: "Inter"));
}

Text awaitPlayerLegendTrophies(Map<String, dynamic> userdata, double size) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  return Text((userdata["legendStatistics"] != null? userdata["legendStatistics"]["legendTrophies"] : 0).toString(), style: TextStyle(color: Colors.white, fontSize: size, fontFamily: "Inter"));
}

Text awaitPlayerBuilderTrophies(Map<String, dynamic> userdata, double size) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  return Text((userdata["builderBaseTrophies"]).toString(), style: TextStyle(color: Colors.white, fontSize: size, fontFamily: "Inter"));
}

Image awaitClanIcon(Map<String, dynamic> userdata) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  if(userdata["clan"] != null) {
    return Image.network(userdata["clan"]["badgeUrls"]["small"], scale: 1.2);
  } else {
    return Image.asset(no_clan, scale: 3);
  }
}

Text awaitClanTroopsOut(Map<String, dynamic> userdata)  {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  return Text((userdata["donations"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

Text awaitClanTroopsIn(Map<String, dynamic> userdata) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  return Text((userdata["donationsReceived"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

double awaitOverallPercent(Map<String, dynamic> userdata, Map<String, dynamic> maxdata1, Map<String, dynamic> maxdata2, Map<String, dynamic> maxdata3) {
  double building = awaitBuildingsPercent(userdata, maxdata1);
  double troops = awaitTroopsPercent(userdata, maxdata2);
  double spells = awaitSpellsPercent(userdata, maxdata2);
  double heroes = awaitHeroesPercent(userdata, maxdata2);
  double equipment = awaitEquipmentPercent(userdata, maxdata3);
  return (building + troops + spells + heroes + equipment) / 5;
}

double awaitBuildingsPercent(Map<String, dynamic> userdata, Map<String, dynamic> maxdata) {
  var wallsString = UserSP.getUserWalls(userdata["tag"].substring(1));
  Map<String, dynamic> walls = wallsString != null? Map<String, dynamic>.from(jsonDecode(wallsString)) : Utils.getDefaultWalls(userdata["townHallLevel"], maxdata);
  var defensesString = UserSP.getUserDefenses(userdata["tag"].substring(1));
  Map<String, dynamic> defenses = defensesString != null? Map<String, dynamic>.from(jsonDecode(defensesString)) : Utils.getDefaultDefenses(userdata["townHallLevel"], maxdata);
  var trapsString = UserSP.getUserTraps(userdata["tag"].substring(1));
  Map<String, dynamic> traps = trapsString != null? Map<String, dynamic>.from(jsonDecode(trapsString)) : Utils.getDefaultTraps(userdata["townHallLevel"], maxdata);
  var armyString = UserSP.getUserArmyBuildings(userdata["tag"].substring(1));
  Map<String, dynamic> armybuildings = armyString != null? Map<String, dynamic>.from(jsonDecode(armyString)) : Utils.getDefaultArmyBuildings(userdata["townHallLevel"], maxdata);
  var resourcesString = UserSP.getUserResourceBuildings(userdata["tag"].substring(1));
  Map<String, dynamic> resources = resourcesString != null? Map<String, dynamic>.from(jsonDecode(resourcesString)) : Utils.getDefaultResources(userdata["townHallLevel"], maxdata);

  num sum = 0;
  num max = 0;
  walls.forEach((key, val) {
    int add = int.parse(key.substring(key.lastIndexOf("-") + 1, key.length));
    sum += val * add;
  });
  defenses.forEach((key, val) {
    sum += val;
  });
  traps.forEach((key, val) {
    sum += val;
  });
  armybuildings.forEach((key, val) {
    sum += val;
  });
  resources.forEach((key, val) {
    sum += val;
  });

  final maxwallscount = maxdata["walls"]["counts"]["17"];
  final maxwallslevel = maxdata["walls"]["maxLevels"]["17"];
  final maxdefensescount = maxdata["defenses"]["counts"]["17"];
  final maxdefenseslevel = maxdata["defenses"]["maxLevels"]["17"];
  final maxtrapscount = maxdata["traps"]["counts"]["17"];
  final maxtrapslevel = maxdata["traps"]["maxLevels"]["17"];
  final maxarmyscount = maxdata["army"]["counts"]["17"];
  final maxarmyslevel = maxdata["army"]["maxLevels"]["17"];
  final maxresourcescount = maxdata["resources"]["counts"]["17"];
  final maxresourceslevel = maxdata["resources"]["maxLevels"]["17"];
  max += maxwallslevel * maxwallscount;
  maxdefensescount.forEach((key, val){
    max += maxdefenseslevel[key] * val;
  });
  maxtrapscount.forEach((key, val){
    max += maxtrapslevel[key] * val;
  });
  maxarmyscount.forEach((key, val){
    max += maxarmyslevel[key] * val;
  });
  maxresourcescount.forEach((key, val){
    max += maxresourceslevel[key] * val;
  });
  double res = max == 0? 0.0 : (sum / max) > 1? 1 : sum / max;
  return res;
}

double awaitTroopsPercent(Map<String, dynamic> userdata, Map<String, dynamic> maxdata) {
  final troops = userdata["troops"];
  num max = 0;
  final maxtroops = maxdata["troops"];
  maxtroops.forEach((key, val) {
    max += val["maxlevel"];
  });
  final maxbhtroops = maxdata["bhtroops"];
  maxbhtroops.forEach((key, val) {
    max += val["maxlevel"];
  });
  final maxsiegemachines = maxdata["siege_machines"];
  maxsiegemachines.forEach((key, val) {
    max += val["maxlevel"];
  });
  num sum = 0;
  for (var troop in troops) {
    if(!Utils.isPet(troop["name"]) && !Utils.isSuperTroop(troop["name"])) {
      sum += troop["level"];
    }
  }
  double res = max == 0? 0.0 : sum / max;
  return res;
}

double awaitSpellsPercent(Map<String, dynamic> userdata, Map<String, dynamic> maxdata) {
  final spells = userdata["spells"];
  num max = 0;
  final maxspells = maxdata["spells"];
  maxspells.forEach((key, val) {
    max += val["maxlevel"];
  });
  num sum = 0;
  for (var spell in spells) {
    sum += spell["level"];
  }
  double res = max == 0? 0.0 : sum / max;
  return res;
}

double awaitHeroesPercent(Map<String, dynamic> userdata, Map<String, dynamic> maxdata) {
  final heroes = userdata["heroes"];
  final troops = userdata["troops"];
  num max = 0;
  final maxheroes = maxdata["heroes"];
  maxheroes.forEach((key, val) {
    max += val;
  });
  final maxpets = maxdata["pets"];
  maxpets.forEach((key, val) {
    max += val;
  });
  num sum = 0;
  for (var hero in heroes) {
    sum += hero["level"];
  }
  for(var troop in troops) {
    if(Utils.isPet(troop["name"])) {
      sum += troop["level"];
    }
  }
  double res = max == 0? 0.0 : sum / max;
  return res;
}

double awaitEquipmentPercent(Map<String, dynamic> userdata, Map<String, dynamic> maxdata) {
  final equi = userdata["heroEquipment"];
  num max = 0;
  maxdata.forEach((key, val) {
    val.forEach((key2, val2) {
      max += val2;
    });
  });
  num sum = 0;
  for (var equ in equi) {
    sum += equ["level"];
  }
  double res = max == 0? 0.0 : sum / max;
  return res;
}

double awaitAchievementsPercent(Map<String, dynamic> userdata) {
  final quests = userdata["achievements"];
  num max = 0;
  num sum = 0;
  for (var quest in quests) {
    max += 3;
    sum += quest["stars"];
  }
  double res = max == 0? 0.0 : sum / max;
  return res;
}

Future<List> awaitTroops(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  final troops = userdata["troops"]?? [];
  return troops;
}

Future<List> awaitSpells(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  final troops = userdata["spells"]?? [];
  return troops;
}

Future<List> awaitHeroes(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  final troops = userdata["heroes"]?? [];
  return troops;
}

Future<List> awaitEquipment(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  final troops = userdata["heroEquipment"]?? [];
  return troops;
}

Future<List> awaitAchievements(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  final troops = userdata["achievements"]?? [];
  return troops;
}