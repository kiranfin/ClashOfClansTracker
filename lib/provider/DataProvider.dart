import 'dart:convert';
import 'package:clashofclanstracker/utils/img/ShortAsset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../utils/Utils.dart' as Utils;

Future<Map<String, dynamic>> awaitPlayerData(String tag) async {
  final url = Uri.parse('${Utils.getBaseUrl()}players/$tag');
  final res = await http.get(url);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> awaitPlayerClan(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return {};
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('${Utils.getBaseUrl()}clans/$clantag');
  final res = await http.get(url);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> awaitMaxBuildings() async {
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

Image awaitBuilderLeagueIcon(Map<String, dynamic> userdata) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  final league = userdata["builderBaseLeague"]["name"];
  if (league == "Wood League V") return Image.asset(wood, scale: 4);
  if (league == "Wood League IV") return Image.asset(wood, scale: 4);
  if (league == "Wood League III") return Image.asset(wood, scale: 4);
  if (league == "Wood League II") return Image.asset(wood, scale: 4);
  if (league == "Wood League I") return Image.asset(wood, scale: 4);
  if (league == "Clay League V") return Image.asset(clay, scale: 4);
  if (league == "Clay League IV") return Image.asset(clay, scale: 4);
  if (league == "Clay League III") return Image.asset(clay, scale: 4);
  if (league == "Clay League II") return Image.asset(clay, scale: 4);
  if (league == "Clay League I") return Image.asset(clay, scale: 4);
  if (league == "Stone League V") return Image.asset(stone, scale: 4);
  if (league == "Stone League IV") return Image.asset(stone, scale: 4);
  if (league == "Stone League III") return Image.asset(stone, scale: 4);
  if (league == "Stone League II") return Image.asset(stone, scale: 4);
  if (league == "Stone League I") return Image.asset(stone, scale: 4);
  if (league == "Copper League V") return Image.asset(copper, scale: 4);
  if (league == "Copper League IV") return Image.asset(copper, scale: 4);
  if (league == "Copper League III") return Image.asset(copper, scale: 4);
  if (league == "Copper League II") return Image.asset(copper, scale: 4);
  if (league == "Copper League I") return Image.asset(copper, scale: 4);
  if (league == "Brass League III") return Image.asset(brass, scale: 4);
  if (league == "Brass League II") return Image.asset(brass, scale: 4);
  if (league == "Brass League I") return Image.asset(brass, scale: 4);
  if (league == "Iron League III") return Image.asset(iron, scale: 4);
  if (league == "Iron League II") return Image.asset(iron, scale: 4);
  if (league == "Iron League I") return Image.asset(iron, scale: 4);
  if (league == "Steel League III") return Image.asset(steel, scale: 4);
  if (league == "Steel League II") return Image.asset(steel, scale: 4);
  if (league == "Steel League I") return Image.asset(steel, scale: 4);
  if (league == "Titanium League III") return Image.asset(titanium, scale: 4);
  if (league == "Titanium League II") return Image.asset(titanium, scale: 4);
  if (league == "Titanium League I") return Image.asset(titanium, scale: 4);
  if (league == "Platinum League III") return Image.asset(platinum, scale: 4);
  if (league == "Platinum League II") return Image.asset(platinum, scale: 4);
  if (league == "Platinum League I") return Image.asset(platinum, scale: 4);
  if (league == "Emerald League III") return Image.asset(emerald, scale: 4);
  if (league == "Emerald League II") return Image.asset(emerald, scale: 4);
  if (league == "Emerald League I") return Image.asset(emerald, scale: 4);
  if (league == "Ruby League III") return Image.asset(ruby, scale: 4);
  if (league == "Ruby League II") return Image.asset(ruby, scale: 4);
  if (league == "Ruby League I") return Image.asset(ruby, scale: 4);
  if (league == "Diamond League I") return Image.asset(diamond, scale: 4);
  return Image.asset(wood, scale: 4);
}

Image awaitClanWarLeagueIcon(String league) {
  if(league == "Bronze League I") return Image.asset(war_bronze1, scale: 1.2);
  if(league == "Bronze League II") return Image.asset(war_bronze2, scale: 1.2);
  if(league == "Bronze League III") return Image.asset(war_bronze3, scale: 1.2);
  if(league == "Silver League I") return Image.asset(war_silver1, scale: 1.2);
  if(league == "Silver League II") return Image.asset(war_silver2, scale: 1.2);
  if(league == "Silver League III") return Image.asset(war_silver3, scale: 1.2);
  if(league == "Gold League I") return Image.asset(war_gold1, scale: 1.2);
  if(league == "Gold League II") return Image.asset(war_gold2, scale: 1.2);
  if(league == "Gold League III") return Image.asset(war_gold3, scale: 1.2);
  if(league == "Crystal League I") return Image.asset(war_crystal1, scale: 1.2);
  if(league == "Crystal League II") return Image.asset(war_crystal2, scale: 1.2);
  if(league == "Crystal League III") return Image.asset(war_crystal3, scale: 1.2);
  if(league == "Master League I") return Image.asset(war_master1, scale: 1.2);
  if(league == "Master League II") return Image.asset(war_master2, scale: 1.2);
  if(league == "Master League III") return Image.asset(war_master3, scale: 1.2);
  if(league == "Champion League I") return Image.asset(war_champion1, scale: 1.2);
  if(league == "Champion League II") return Image.asset(war_champion2, scale: 1.2);
  if(league == "Champion League III") return Image.asset(war_champion3, scale: 1.2);
  return Image.asset(war_bronze1, scale: 1);
}

Text awaitPlayerName(Map<String, dynamic> userdata) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  return Text(userdata["name"], style: TextStyle(color: Colors.white, fontSize: 25));
}

Text awaitPlayerTrophies(Map<String, dynamic> userdata) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  return Text((userdata["trophies"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

Text awaitPlayerLegendTrophies(Map<String, dynamic> userdata) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  return Text((userdata["legendStatistics"] != null? userdata["legendStatistics"]["legendTrophies"] : 0).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

Text awaitPlayerBuilderTrophies(Map<String, dynamic> userdata) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  return Text((userdata["builderBaseTrophies"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
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
  return 0.5;
}

double awaitTroopsPercent(Map<String, dynamic> userdata, Map<String, dynamic> maxdata) {
  final troops = userdata["troops"];
  num max = 0;
  final maxtroops = maxdata["troops"];
  final maxbhtroops = maxdata["bhtroops"];
  final maxsiegemachines = maxdata["siege_machines"];
  Map finalmap = {};
  finalmap.addAll(maxtroops);
  finalmap.addAll(maxbhtroops);
  finalmap.addAll(maxsiegemachines);
  finalmap.forEach((key, val) {
    max += val;
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
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  final spells = userdata["spells"];
  num max = 0;
  final maxspells = maxdata["spells"];
  maxspells.forEach((key, val) {
    max += val;
  });
  num sum = 0;
  for (var spell in spells) {
    sum += spell["level"];
  }
  double res = max == 0? 0.0 : sum / max;
  return res;
}

double awaitHeroesPercent(Map<String, dynamic> userdata, Map<String, dynamic> maxdata) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
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
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
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
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
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