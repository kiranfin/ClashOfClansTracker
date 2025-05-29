import 'dart:convert';
import 'dart:convert' as convert;
import 'package:clashofclanstracker/utils/img/ShortAsset.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/Utils.dart' as Utils;

Future<Map<String, dynamic>> awaitPlayerData(String tag) async {
  final headers = {
    "Accept": "application/json",
    'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjdmNTE5ODZjLTA3NjQtNGY1NC04ZGQyLTAzMDI4ODM2ZTRhOCIsImlhdCI6MTc0ODUyMTg1MSwic3ViIjoiZGV2ZWxvcGVyLzA3NzdmM2RmLTUzYWMtMjI1Zi1kNTdjLWMwNGIxZjA4NjY5MyIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjg5LjI0Ni45Ni4xMTYiXSwidHlwZSI6ImNsaWVudCJ9XX0.adUEU5AN1KpWxDIcxDoMqxt8QP62IRhUQ2G2wP9tb4gxxSTnOi5Alsy2dTup-CAPgj4TpgX3fb-_SZzEOlGI2A',
  };

  final url = Uri.parse('${Utils.getBaseUrl()}v1/players/%23$tag');
  final res = await http.get(url, headers: headers);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Image> awaitTownHallIcon(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  if(userdata["townHallLevel"] == 1) return Image.asset(th1, scale: 3);
  if(userdata["townHallLevel"] == 2) return Image.asset(th2, scale: 3);
  if(userdata["townHallLevel"] == 3) return Image.asset(th3, scale: 3);
  if(userdata["townHallLevel"] == 4) return Image.asset(th4, scale: 3);
  if(userdata["townHallLevel"] == 5) return Image.asset(th5, scale: 3);
  if(userdata["townHallLevel"] == 6) return Image.asset(th6, scale: 3);
  if(userdata["townHallLevel"] == 7) return Image.asset(th7, scale: 3);
  if(userdata["townHallLevel"] == 8) return Image.asset(th8, scale: 3);
  if(userdata["townHallLevel"] == 9) return Image.asset(th9, scale: 3);
  if(userdata["townHallLevel"] == 10) return Image.asset(th10, scale: 3);
  if(userdata["townHallLevel"] == 11) return Image.asset(th11, scale: 3);
  if(userdata["townHallLevel"] == 12) return Image.asset(th12, scale: 3);
  if(userdata["townHallLevel"] == 13) return Image.asset(th13, scale: 3);
  if(userdata["townHallLevel"] == 14) return Image.asset(th14, scale: 3);
  if(userdata["townHallLevel"] == 15) return Image.asset(th15, scale: 3);
  if(userdata["townHallLevel"] == 16) return Image.asset(th16, scale: 3);
  if(userdata["townHallLevel"] == 17) return Image.asset(th17, scale: 3);
  return Image.asset(th1, scale: 2.5);
}

Future<Image> awaitBuilderHallIcon(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  if(userdata["builderHallLevel"] == 1) return Image.asset(bh1, scale: 2.5);
  if(userdata["builderHallLevel"] == 2) return Image.asset(bh2, scale: 2.5);
  if(userdata["builderHallLevel"] == 3) return Image.asset(bh3, scale: 2.5);
  if(userdata["builderHallLevel"] == 4) return Image.asset(bh4, scale: 2.5);
  if(userdata["builderHallLevel"] == 5) return Image.asset(bh5, scale: 2.5);
  if(userdata["builderHallLevel"] == 6) return Image.asset(bh6, scale: 2.5);
  if(userdata["builderHallLevel"] == 7) return Image.asset(bh7, scale: 2.5);
  if(userdata["builderHallLevel"] == 8) return Image.asset(bh8, scale: 2.5);
  if(userdata["builderHallLevel"] == 9) return Image.asset(bh9, scale: 2.5);
  if(userdata["builderHallLevel"] == 10) return Image.asset(bh10, scale: 2.5);
  return Image.asset(bh1, scale: 2.5);
}

Future<Image> awaitLeagueIcon(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  return Image.network(userdata["league"]["iconUrls"]["small"], scale: 1.5);
}

Future<Image> awaitBuilderLeagueIcon(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
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

Future<Text> awaitPlayerName(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  return Text(userdata["name"], style: TextStyle(color: Colors.white, fontSize: 25));
}

Future<Text> awaitPlayerTrophies(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  return Text((userdata["trophies"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

Future<Text> awaitPlayerLegendTrophies(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  return Text((userdata["legendStatistics"]["legendTrophies"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

Future<Text> awaitPlayerBuilderTrophies(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  return Text((userdata["builderBaseTrophies"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

Future<Image> awaitClanIcon(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  return Image.network(userdata["clan"]["badgeUrls"]["small"], scale: 1.2);
}

Future<Text> awaitClanTroopsOut(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  return Text((userdata["donations"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

Future<Text> awaitClanTroopsIn(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  return Text((userdata["donationsReceived"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

Future<double> awaitOverallPercent(String tag) async {
  double building = await awaitBuildingsPercent(tag);
  double troops = await awaitTroopsPercent(tag);
  double spells = await awaitSpellsPercent(tag);
  double heroes = await awaitHeroesPercent(tag);
  double equipment = await awaitEquipmentPercent(tag);
  return (building + troops + spells + heroes + equipment) / 5;
}

Future<double> awaitBuildingsPercent(String tag) async {
  return 0.5;
}

Future<double> awaitTroopsPercent(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  final troops = userdata["troops"];
  num max = 0;
  num sum = 0;
  for (var troop in troops) {
    if(!Utils.isPet(troop["name"]) && !Utils.isSuperTroop(troop["name"])) {
      max += troop["maxLevel"];
      sum += troop["level"];
    }
  }
  double res = sum / max;
  return res;
}

Future<double> awaitSpellsPercent(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  final spells = userdata["spells"];
  num max = 0;
  num sum = 0;
  for (var spell in spells) {
    max += spell["maxLevel"];
    sum += spell["level"];
  }
  double res = sum / max;
  return res;
}

Future<double> awaitHeroesPercent(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  final heroes = userdata["heroes"];
  num max = 0;
  num sum = 0;
  for (var hero in heroes) {
    max += hero["maxLevel"];
    sum += hero["level"];
  }
  double res = sum / max;
  return res;
}

Future<double> awaitEquipmentPercent(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  final equi = userdata["heroEquipment"];
  final troops = userdata["troops"];
  num max = 0;
  num sum = 0;
  for (var equ in equi) {
    max += equ["maxLevel"];
    sum += equ["level"];
  }
  for(var troop in troops) {
    if(Utils.isPet(troop["name"])) {
      max += troop["maxLevel"];
      sum += troop["level"];
    }
  }
  double res = sum / max;
  return res;
}

Future<double> awaitQuestsPercent(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  final quests = userdata["achievements"];
  num max = 0;
  num sum = 0;
  for (var quest in quests) {
    max += 3;
    sum += quest["stars"];
  }
  double res = sum / max;
  return res;
}

Future<List<dynamic>> awaitTroops(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  final troops = userdata["troops"];
  return troops;
}

Future<List<dynamic>> awaitSpells(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  final troops = userdata["spells"];
  return troops;
}

Future<List<dynamic>> awaitHeroes(String tag) async {
  final data = awaitPlayerData(tag);
  final userdata = await data;
  final troops = userdata["heroes"];
  return troops;
}