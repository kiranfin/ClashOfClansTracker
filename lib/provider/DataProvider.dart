import 'dart:convert';
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

Future<Map<String, dynamic>> awaitClanWarLeague(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return {};
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('${Utils.getBaseUrl()}clanwarleague/current/$clantag');
  final res = await http.get(url);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>?> awaitCurrentClanWarLeagueWar(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return {};
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('${Utils.getBaseUrl()}clanwarleague/currentday/$clantag');
  final res = await http.get(url);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> awaitClanWarLeagueWar(String tag) async {
  final url = Uri.parse('${Utils.getBaseUrl()}clanwarleague/war/$tag');
  final res = await http.get(url);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String,dynamic>> awaitAllClanWarLeagueRounds(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return {};
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('${Utils.getBaseUrl()}clanwarleague/rounds/$clantag');
  final res = await http.get(url);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  return jsonDecode(res.body) as Map<String, dynamic>;
}

Future<Map<String,dynamic>> awaitCurrentClanWar(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return {};
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('${Utils.getBaseUrl()}clanwar/current/$clantag');
  final res = await http.get(url);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
  //return jsonDecode(res.body) as Map<String, dynamic>;
  return {
    "state": "warEnded",
    "teamSize": 5,
    "attacksPerMember": 2,
    "battleModifier": "none",
    "preparationStartTime": "20250630T202521.000Z",
    "startTime": "20250701T192521.000Z",
    "endTime": "20250702T192521.000Z",
    "clan": {
      "tag": "#2JC9C9UVR",
      "name": "ADL",
      "badgeUrls": {
        "small": "https://api-assets.clashofclans.com/badges/70/-PQg5hdYr5VYxDgB0XHbTYs_qthHRPSZWOqWKa4Z4cc.png",
        "large": "https://api-assets.clashofclans.com/badges/512/-PQg5hdYr5VYxDgB0XHbTYs_qthHRPSZWOqWKa4Z4cc.png",
        "medium": "https://api-assets.clashofclans.com/badges/200/-PQg5hdYr5VYxDgB0XHbTYs_qthHRPSZWOqWKa4Z4cc.png"
      },
      "clanLevel": 2,
      "attacks": 8,
      "stars": 14,
      "destructionPercentage": 98.6,
      "members": [
        {
          "tag": "#GJP99GYU8",
          "name": "akash",
          "townhallLevel": 11,
          "mapPosition": 3,
          "attacks": [
            {
              "attackerTag": "#GJP99GYU8",
              "defenderTag": "#QYUG988LC",
              "stars": 3,
              "destructionPercentage": 100,
              "order": 9,
              "duration": 120
            },
            {
              "attackerTag": "#GJP99GYU8",
              "defenderTag": "#9V9JUC800",
              "stars": 3,
              "destructionPercentage": 100,
              "order": 10,
              "duration": 112
            }
          ],
          "opponentAttacks": 1,
          "bestOpponentAttack": {
            "attackerTag": "#QYUG988LC",
            "defenderTag": "#GJP99GYU8",
            "stars": 3,
            "destructionPercentage": 100,
            "order": 6,
            "duration": 97
          }
        },
        {
          "tag": "#Y80G9UQ0P",
          "name": "Harman_Chohan",
          "townhallLevel": 12,
          "mapPosition": 2,
          "attacks": [
            {
              "attackerTag": "#Y80G9UQ0P",
              "defenderTag": "#QQ02UQJL2",
              "stars": 1,
              "destructionPercentage": 70,
              "order": 12,
              "duration": 135
            },
            {
              "attackerTag": "#Y80G9UQ0P",
              "defenderTag": "#QYUG988LC",
              "stars": 3,
              "destructionPercentage": 100,
              "order": 13,
              "duration": 85
            }
          ],
          "opponentAttacks": 1,
          "bestOpponentAttack": {
            "attackerTag": "#QQ02UQJL2",
            "defenderTag": "#Y80G9UQ0P",
            "stars": 3,
            "destructionPercentage": 100,
            "order": 2,
            "duration": 79
          }
        },
        {
          "tag": "#GCP092QQJ",
          "name": "cash",
          "townhallLevel": 9,
          "mapPosition": 4,
          "attacks": [
            {
              "attackerTag": "#GCP092QQJ",
              "defenderTag": "#G9JPG2L0U",
              "stars": 3,
              "destructionPercentage": 100,
              "order": 7,
              "duration": 81
            },
            {
              "attackerTag": "#GCP092QQJ",
              "defenderTag": "#GR00CYYVR",
              "stars": 3,
              "destructionPercentage": 100,
              "order": 11,
              "duration": 75
            }
          ],
          "opponentAttacks": 2,
          "bestOpponentAttack": {
            "attackerTag": "#9V9JUC800",
            "defenderTag": "#GCP092QQJ",
            "stars": 3,
            "destructionPercentage": 100,
            "order": 5,
            "duration": 84
          }
        },
        {
          "tag": "#QL9G0RY9Q",
          "name": "harsh virk",
          "townhallLevel": 7,
          "mapPosition": 5,
          "opponentAttacks": 3,
          "bestOpponentAttack": {
            "attackerTag": "#9V9JUC800",
            "defenderTag": "#QL9G0RY9Q",
            "stars": 3,
            "destructionPercentage": 100,
            "order": 14,
            "duration": 48
          }
        },
        {
          "tag": "#YG9QUUJLP",
          "name": "harry virk",
          "townhallLevel": 13,
          "mapPosition": 1,
          "attacks": [
            {
              "attackerTag": "#YG9QUUJLP",
              "defenderTag": "#QQ02UQJL2",
              "stars": 2,
              "destructionPercentage": 93,
              "order": 17,
              "duration": 149
            },
            {
              "attackerTag": "#YG9QUUJLP",
              "defenderTag": "#QYUG988LC",
              "stars": 3,
              "destructionPercentage": 100,
              "order": 18,
              "duration": 126
            }
          ],
          "opponentAttacks": 3,
          "bestOpponentAttack": {
            "attackerTag": "#QYUG988LC",
            "defenderTag": "#YG9QUUJLP",
            "stars": 2,
            "destructionPercentage": 77,
            "order": 8,
            "duration": 107
          }
        }
      ]
    },
    "opponent": {
      "tag": "#2JJ8YV2GP",
      "name": "EL-TURCO",
      "badgeUrls": {
        "small": "https://api-assets.clashofclans.com/badges/70/DcHcgP14dK0OPmf_G77JtangGL7_5u6oAOWUbbXP8Yw.png",
        "large": "https://api-assets.clashofclans.com/badges/512/DcHcgP14dK0OPmf_G77JtangGL7_5u6oAOWUbbXP8Yw.png",
        "medium": "https://api-assets.clashofclans.com/badges/200/DcHcgP14dK0OPmf_G77JtangGL7_5u6oAOWUbbXP8Yw.png"
      },
      "clanLevel": 1,
      "attacks": 10,
      "stars": 14,
      "destructionPercentage": 95.4,
      "members": [
        {
          "tag": "#QYUG988LC",
          "name": "enesw",
          "townhallLevel": 12,
          "mapPosition": 2,
          "attacks": [
            {
              "attackerTag": "#QYUG988LC",
              "defenderTag": "#GJP99GYU8",
              "stars": 3,
              "destructionPercentage": 100,
              "order": 6,
              "duration": 97
            },
            {
              "attackerTag": "#QYUG988LC",
              "defenderTag": "#YG9QUUJLP",
              "stars": 2,
              "destructionPercentage": 77,
              "order": 8,
              "duration": 107
            }
          ],
          "opponentAttacks": 3,
          "bestOpponentAttack": {
            "attackerTag": "#GJP99GYU8",
            "defenderTag": "#QYUG988LC",
            "stars": 3,
            "destructionPercentage": 100,
            "order": 9,
            "duration": 120
          }
        },
        {
          "tag": "#QQ02UQJL2",
          "name": "crewHERKÜL",
          "townhallLevel": 13,
          "mapPosition": 1,
          "attacks": [
            {
              "attackerTag": "#QQ02UQJL2",
              "defenderTag": "#Y80G9UQ0P",
              "stars": 3,
              "destructionPercentage": 100,
              "order": 2,
              "duration": 79
            },
            {
              "attackerTag": "#QQ02UQJL2",
              "defenderTag": "#YG9QUUJLP",
              "stars": 1,
              "destructionPercentage": 72,
              "order": 4,
              "duration": 94
            }
          ],
          "opponentAttacks": 2,
          "bestOpponentAttack": {
            "attackerTag": "#YG9QUUJLP",
            "defenderTag": "#QQ02UQJL2",
            "stars": 2,
            "destructionPercentage": 93,
            "order": 17,
            "duration": 149
          }
        },
        {
          "tag": "#9V9JUC800",
          "name": "Ethem kisacik",
          "townhallLevel": 11,
          "mapPosition": 3,
          "attacks": [
            {
              "attackerTag": "#9V9JUC800",
              "defenderTag": "#GCP092QQJ",
              "stars": 3,
              "destructionPercentage": 100,
              "order": 5,
              "duration": 84
            },
            {
              "attackerTag": "#9V9JUC800",
              "defenderTag": "#QL9G0RY9Q",
              "stars": 3,
              "destructionPercentage": 100,
              "order": 14,
              "duration": 48
            }
          ],
          "opponentAttacks": 1,
          "bestOpponentAttack": {
            "attackerTag": "#GJP99GYU8",
            "defenderTag": "#9V9JUC800",
            "stars": 3,
            "destructionPercentage": 100,
            "order": 10,
            "duration": 112
          }
        },
        {
          "tag": "#GR00CYYVR",
          "name": "GÖKBEY",
          "townhallLevel": 7,
          "mapPosition": 5,
          "attacks": [
            {
              "attackerTag": "#GR00CYYVR",
              "defenderTag": "#YG9QUUJLP",
              "stars": 0,
              "destructionPercentage": 16,
              "order": 15,
              "duration": 47
            },
            {
              "attackerTag": "#GR00CYYVR",
              "defenderTag": "#QL9G0RY9Q",
              "stars": 1,
              "destructionPercentage": 52,
              "order": 16,
              "duration": 71
            }
          ],
          "opponentAttacks": 1,
          "bestOpponentAttack": {
            "attackerTag": "#GCP092QQJ",
            "defenderTag": "#GR00CYYVR",
            "stars": 3,
            "destructionPercentage": 100,
            "order": 11,
            "duration": 75
          }
        },
        {
          "tag": "#G9JPG2L0U",
          "name": "ÜVEYİK",
          "townhallLevel": 7,
          "mapPosition": 4,
          "attacks": [
            {
              "attackerTag": "#G9JPG2L0U",
              "defenderTag": "#QL9G0RY9Q",
              "stars": 2,
              "destructionPercentage": 87,
              "order": 1,
              "duration": 88
            },
            {
              "attackerTag": "#G9JPG2L0U",
              "defenderTag": "#GCP092QQJ",
              "stars": 0,
              "destructionPercentage": 37,
              "order": 3,
              "duration": 74
            }
          ],
          "opponentAttacks": 1,
          "bestOpponentAttack": {
            "attackerTag": "#GCP092QQJ",
            "defenderTag": "#G9JPG2L0U",
            "stars": 3,
            "destructionPercentage": 100,
            "order": 7,
            "duration": 81
          }
        }
      ]
    }
  };
}

Future<Map<String,dynamic>> awaitClanWarLog(String tag) async {
  var player = await awaitPlayerData(tag);
  if(player["clan"] == null) return {};
  String clantag = player["clan"]["tag"].substring(1);
  final url = Uri.parse('${Utils.getBaseUrl()}clanwar/warlog/$clantag');
  final res = await http.get(url);
  final status = res.statusCode;
  if (status != 200) throw Exception('http.get error: statusCode= $status');
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

Text awaitPlayerTrophies(Map<String, dynamic> userdata, double size) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  return Text((userdata["trophies"]).toString(), style: TextStyle(color: Colors.white, fontSize: size));
}

Text awaitPlayerLegendTrophies(Map<String, dynamic> userdata, double size) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  return Text((userdata["legendStatistics"] != null? userdata["legendStatistics"]["legendTrophies"] : 0).toString(), style: TextStyle(color: Colors.white, fontSize: size));
}

Text awaitPlayerBuilderTrophies(Map<String, dynamic> userdata, double size) {
  //final data = awaitPlayerData(tag);
  //final userdata = await data;
  return Text((userdata["builderBaseTrophies"]).toString(), style: TextStyle(color: Colors.white, fontSize: size));
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
    for(int i = 0; i < val; i++) {
      sum += add;
    }
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
  for(int i = 0; i < maxwallscount; i++) {
    max += maxwallslevel;
  }
  maxdefensescount.forEach((key, val){
    for(int i = 0; i < val; i++) {
      max += maxdefenseslevel[key];
    }
  });
  maxtrapscount.forEach((key, val){
    for(int i = 0; i < val; i++) {
      max += maxtrapslevel[key];
    }
  });
  maxarmyscount.forEach((key, val){
    for(int i = 0; i < val; i++) {
      max += maxarmyslevel[key];
    }
  });
  maxresourcescount.forEach((key, val){
    for(int i = 0; i < val; i++) {
      max += maxresourceslevel[key];
    }
  });
  double res = max == 0? 0.0 : (sum / max) > 1? 1 : sum / max;
  return res;
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