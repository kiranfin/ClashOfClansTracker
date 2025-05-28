import 'dart:convert';
import 'dart:convert' as convert;
import 'package:clashofclanstracker/utils/img/ShortAsset.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/Utils.dart' as Utils;

String tag = '';
Map<String, dynamic> userdata = {};

DataProvider(String tag) async {
  tag = tag;
  userdata = await awaitPlayerData();
}

Future<Map<String, dynamic>> awaitPlayerData() async {
  final headers = {
    "Accept": "application/json",
    'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6ImEyNmE4ZTk4LWM5ZmItNDA1My1hZTMxLWFjNzZiNGI5OGVjZSIsImlhdCI6MTc0ODQyOTk5OSwic3ViIjoiZGV2ZWxvcGVyLzA3NzdmM2RmLTUzYWMtMjI1Zi1kNTdjLWMwNGIxZjA4NjY5MyIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjg5LjI0Ni4xMDMuMTE0Il0sInR5cGUiOiJjbGllbnQifV19.wiOBGB9rEqQGrYrDcwrVorEay2wpjIoxLDdcn8qc7QfIxSmv9ceO2xHavIjPn192rSDI-aKb_FA9uHXGa6hIJA',
  };

  final url = Uri.parse('${Utils.getBaseUrl()}v1/players/%23$tag');

  final res = await http.get(url, headers: headers);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Image> awaitLeagueIcon() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  return Image.network(datamap["league"]["iconUrls"]["small"], scale: 1.5);
}

Future<Image> awaitBuilderLeagueIcon() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  final league = datamap["builderBaseLeague"]["name"];
  if(league == "Wood League V") return Image.asset(wood, scale: 4);
  if(league == "Wood League IV") return Image.asset(wood, scale: 4);
  if(league == "Wood League III") return Image.asset(wood, scale: 4);
  if(league == "Wood League II") return Image.asset(wood, scale: 4);
  if(league == "Wood League I") return Image.asset(wood, scale: 4);
  if(league == "Clay League V") return Image.asset(clay, scale: 4);
  if(league == "Clay League IV") return Image.asset(clay, scale: 4);
  if(league == "Clay League III") return Image.asset(clay, scale: 4);
  if(league == "Clay League II") return Image.asset(clay, scale: 4);
  if(league == "Clay League I") return Image.asset(clay, scale: 4);
  if(league == "Stone League V") return Image.asset(stone, scale: 4);
  if(league == "Stone League IV") return Image.asset(stone, scale: 4);
  if(league == "Stone League III") return Image.asset(stone, scale: 4);
  if(league == "Stone League II") return Image.asset(stone, scale: 4);
  if(league == "Stone League I") return Image.asset(stone, scale: 4);
  if(league == "Copper League V") return Image.asset(copper, scale: 4);
  if(league == "Copper League IV") return Image.asset(copper, scale: 4);
  if(league == "Copper League III") return Image.asset(copper, scale: 4);
  if(league == "Copper League II") return Image.asset(copper, scale: 4);
  if(league == "Copper League I") return Image.asset(copper, scale: 4);
  if(league == "Brass League III") return Image.asset(brass, scale: 4);
  if(league == "Brass League II") return Image.asset(brass, scale: 4);
  if(league == "Brass League I") return Image.asset(brass, scale: 4);
  if(league == "Iron League III") return Image.asset(iron, scale: 4);
  if(league == "Iron League II") return Image.asset(iron, scale: 4);
  if(league == "Iron League I") return Image.asset(iron, scale: 4);
  if(league == "Steel League III") return Image.asset(steel, scale: 4);
  if(league == "Steel League II") return Image.asset(steel, scale: 4);
  if(league == "Steel League I") return Image.asset(steel, scale: 4);
  if(league == "Titanium League III") return Image.asset(titanium, scale: 4);
  if(league == "Titanium League II") return Image.asset(titanium, scale: 4);
  if(league == "Titanium League I") return Image.asset(titanium, scale: 4);
  if(league == "Platinum League III") return Image.asset(platinum, scale: 4);
  if(league == "Platinum League II") return Image.asset(platinum, scale: 4);
  if(league == "Platinum League I") return Image.asset(platinum, scale: 4);
  if(league == "Emerald League III") return Image.asset(emerald, scale: 4);
  if(league == "Emerald League II") return Image.asset(emerald, scale: 4);
  if(league == "Emerald League I") return Image.asset(emerald, scale: 4);
  if(league == "Ruby League III") return Image.asset(ruby, scale: 4);
  if(league == "Ruby League II") return Image.asset(ruby, scale: 4);
  if(league == "Ruby League I") return Image.asset(ruby, scale: 4);
  if(league == "Diamond League I") return Image.asset(diamond, scale: 4);
  return Image.asset(wood, scale: 4);
}

Future<Text> awaitPlayerName() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  return Text(datamap["name"], style: TextStyle(color: Colors.white, fontSize: 25));
}

Future<Text> awaitPlayerTrophies() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  return Text((datamap["trophies"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

Future<Text> awaitPlayerLegendTrophies() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  return Text((datamap["legendStatistics"]["legendTrophies"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

Future<Text> awaitPlayerBuilderTrophies() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  return Text((datamap["builderBaseTrophies"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

Future<Image> awaitClanIcon(String tag) async {
  final data = await awaitPlayerData();
  final datamap = await data;
  return Image.network(datamap["clan"]["badgeUrls"]["small"], scale: 1.2);
}

Future<Text> awaitClanTroopsOut() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  return Text((datamap["donations"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

Future<Text> awaitClanTroopsIn() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  return Text((datamap["donationsReceived"]).toString(), style: TextStyle(color: Colors.white, fontSize: 15));
}

Future<double> awaitOverallPercent() async {
  double building = await awaitBuildingsPercent(tag);
  double troops = await awaitTroopsPercent(tag);
  double spells = await awaitSpellsPercent(tag);
  double heroes = await awaitHeroesPercent(tag);
  double equipment = await awaitEquipmentPercent(tag);
  return (building + troops + spells + heroes + equipment)/5;
}

Future<double> awaitBuildingsPercent() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  return 0.5;
}

Future<double> awaitTroopsPercent() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  final troops = datamap["troops"];
  num max = 0;
  num sum = 0;
  for(var troop in troops) {
    max += troop["maxLevel"];
    sum += troop["level"];
  }
  double res = sum / max;
  return res;
}

Future<double> awaitSpellsPercent() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  final spells = datamap["spells"];
  num max = 0;
  num sum = 0;
  for(var spell in spells) {
    max += spell["maxLevel"];
    sum += spell["level"];
  }
  double res = sum / max;
  return res;
}

Future<double> awaitHeroesPercent() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  final heroes = datamap["heroes"];
  num max = 0;
  num sum = 0;
  for(var hero in heroes) {
    max += hero["maxLevel"];
    sum += hero["level"];
  }
  double res = sum / max;
  return res;
}

Future<double> awaitEquipmentPercent() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  final equi = datamap["heroEquipment"];
  num max = 0;
  num sum = 0;
  for(var equ in equi) {
    max += equ["maxLevel"];
    sum += equ["level"];
  }
  double res = sum / max;
  return res;
}

Future<double> awaitQuestsPercent() async {
  final data = await awaitPlayerData();
  final datamap = await data;
  final quests = datamap["achievements"];
  num max = 0;
  num sum = 0;
  for(var quest in quests) {
    max += 3;
    sum += quest["stars"];
  }
  double res = sum / max;
  return res;
}