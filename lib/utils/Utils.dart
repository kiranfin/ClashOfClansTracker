import 'package:clashofclanstracker/utils/img/ShortAsset.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

String getToken() {
  final apiKey = dotenv.get('API_KEY');
  return apiKey;
}

String getBaseUrl() {
  final baseUrl = 'https://api.clashofclans.com/';
  return baseUrl;
}

Image getTroopImage(String name, String village) {
  if(name == "Barbarian") return Image.asset(barbarian, scale: 3.5);
  if(name == "Archer") return Image.asset(archer, scale: 3.5);
  if(name == "Giant") return Image.asset(giant, scale: 3.5);
  if(name == "Goblin") return Image.asset(goblin, scale: 3.5);
  if(name == "Wall Breaker") return Image.asset(wall_breaker, scale: 3.5);
  if(name == "Balloon") return Image.asset(balloon, scale: 3.5);
  if(name == "Wizard") return Image.asset(wizard, scale: 3.5);
  if(name == "Healer") return Image.asset(healer, scale: 3.5);
  if(name == "Dragon") return Image.asset(dragon, scale: 3.5);
  if(name == "P.E.K.K.A") return Image.asset(pekka, scale: 3.5);
  if(name == "Baby Dragon" && village == "home") return Image.asset(baby_dragon, scale: 3);
  if(name == "Miner") return Image.asset(miner, scale: 3.5);
  if(name == "Electro Dragon") return Image.asset(electro_dragon, scale: 3.5);
  if(name == "Yeti") return Image.asset(yeti, scale: 3.5);
  if(name == "Dragon Rider") return Image.asset(dragon_rider, scale: 3.5);
  if(name == "Electro Titan") return Image.asset(electro_titan, scale: 2.5);
  if(name == "Root Rider") return Image.asset(root_rider, scale: 2.5);
  if(name == "Thrower") return Image.asset(thrower, scale: 2.5);

  if(name == "Minion") return Image.asset(minion, scale: 3.5);
  if(name == "Hog Rider") return Image.asset(hog_rider, scale: 3.5);
  if(name == "Valkyrie") return Image.asset(valkyrie, scale: 3.5);
  if(name == "Golem") return Image.asset(golem, scale: 3.5);
  if(name == "Witch") return Image.asset(witch, scale: 3.5);
  if(name == "Lava Hound") return Image.asset(lava_hound, scale: 3.5);
  if(name == "Bowler") return Image.asset(bowler, scale: 3.5);
  if(name == "Ice Golem") return Image.asset(ice_golem, scale: 3.5);
  if(name == "Headhunter") return Image.asset(head_hunter, scale: 3.5);
  if(name == "Apprentice Warden") return Image.asset(apprentice_warden, scale: 2.5);
  if(name == "Druid") return Image.asset(druid, scale: 2.5);
  if(name == "Furnace") return Image.asset(furnace, scale: 2.5);

  if(name == "Super Barbarian") return Image.asset(super_barbarian, scale: 6.5);
  if(name == "Super Archer") return Image.asset(super_archer, scale: 6.5);
  if(name == "Super Giant") return Image.asset(super_giant, scale: 6.5);
  if(name == "Sneaky Goblin") return Image.asset(sneaky_goblin, scale: 6.5);
  if(name == "Super Wall Breaker") return Image.asset(super_wall_breaker, scale: 6.5);
  if(name == "Rocket Balloon") return Image.asset(rocket_balloon, scale: 3.5);
  if(name == "Super Wizard") return Image.asset(super_wizard, scale: 6.5);
  if(name == "Super Dragon") return Image.asset(super_dragon, scale: 5);
  if(name == "Inferno Dragon") return Image.asset(inferno_dragon, scale: 6.5);
  if(name == "Super Miner") return Image.asset(super_miner, scale: 3);
  if(name == "Super Yeti") return Image.asset(super_yeti, scale: 1);
  if(name == "Super Minion") return Image.asset(super_minion, scale: 6.5);
  if(name == "Super Hog Rider") return Image.asset(super_hog_rider, scale: 3);
  if(name == "Super Valkyrie") return Image.asset(super_valkyrie, scale: 6.5);
  if(name == "Super Witch") return Image.asset(super_witch, scale: 6.5);
  if(name == "Ice Hound") return Image.asset(ice_hound, scale: 6.5);
  if(name == "Super Bowler") return Image.asset(super_bowler, scale: 6.5);

  if(name == "Raged Barbarian") return Image.asset(raged_barbarian, scale: 2.5);
  if(name == "Sneaky Archer") return Image.asset(sneaky_archer, scale: 2.5);
  if(name == "Boxer Giant") return Image.asset(boxer_giant, scale: 2.5);
  if(name == "Beta Minion") return Image.asset(beta_minion, scale: 2.5);
  if(name == "Bomber") return Image.asset(bomber, scale: 2.5);
  if(name == "Baby Dragon" && village == "builderBase") return Image.asset(baby_dragon, scale: 3.5);
  if(name == "Cannon Cart") return Image.asset(cannon_cart, scale: 2.5);
  if(name == "Night Witch") return Image.asset(night_witch, scale: 2.5);
  if(name == "Drop Ship") return Image.asset(drop_ship, scale: 2.5);
  if(name == "Power P.E.K.K.A") return Image.asset(power_pekka, scale: 2.5);
  if(name == "Hog Glider") return Image.asset(hog_glider, scale: 2.5);
  if(name == "Electrofire Wizard") return Image.asset(electrofire_wizard, scale: 2.5);

  if(name == "Wall Wrecker") return Image.asset(wall_wrecker, scale: 2.5);
  if(name == "Battle Blimp") return Image.asset(battle_blimp, scale: 2.5);
  if(name == "Stone Slammer") return Image.asset(stone_slammer, scale: 2.5);
  if(name == "Siege Barracks") return Image.asset(siege_barracks, scale: 2.5);
  if(name == "Log Launcher") return Image.asset(log_launcher, scale: 2.5);
  if(name == "Flame Flinger") return Image.asset(flame_flinger, scale: 2.5);
  if(name == "Battle Drill") return Image.asset(battle_drill, scale: 2.5);
  if(name == "Troop Launcher") return Image.asset(troop_launcher, scale: 2.5);

  if(name == "L.A.S.S.I") return Image.asset(lassi, scale: 1);
  if(name == "Electro Owl") return Image.asset(electro_owl, scale: 1);
  if(name == "Mighty Yak") return Image.asset(mighty_yak, scale: 1);
  if(name == "Unicorn") return Image.asset(unicorn, scale: 1);
  if(name == "Frosty") return Image.asset(frosty, scale: 1);
  if(name == "Diggy") return Image.asset(diggy, scale: 1);
  if(name == "Poison Lizard") return Image.asset(poison_lizard, scale: 1);
  if(name == "Phoenix") return Image.asset(phoenix, scale: 1);
  if(name == "Spirit Fox") return Image.asset(spirit_fox, scale: 1);
  if(name == "Angry Jelly") return Image.asset(angry_jelly, scale: 1);
  if(name == "Sneezy") return Image.asset(sneezy, scale: 1);
  return Image.asset(defenseShield, scale: 3.5);
}

List<dynamic> getNormalTroops(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(isNormalTroop(element["name"]) && element["village"] == "home") result.add(element);
  }
  return result;
}

List<dynamic> getSuperTroops(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(isSuperTroop(element["name"])) result.add(element);
  }
  return result;
}

List<dynamic> getBuilderTroops(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(isBuilderTroop(element["name"]) && element["village"] == "builderBase") result.add(element);
  }
  return result;
}

List<dynamic> getPets(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(isPet(element["name"])) result.add(element);
  }
  return result;
}

List<dynamic> getSiegeMachines(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(isSiegeMachine(element["name"]) && element["village"] == "home") result.add(element);
  }
  return result;
}

bool isNormalTroop(String name) {
  return name == "Barbarian" || name == "Archer" || name == "Giant" || name == "Goblin"
      || name == "Wall Breaker" || name == "Balloon" || name == "Wizard" || name == "Healer"
      || name == "Dragon" || name == "P.E.K.K.A" || name == "Baby Dragon" || name == "Miner"
      || name == "Electro Dragon" || name == "Yeti" || name == "Dragon Rider" || name == "Electro Titan" || name == "Root Rider"
      || name == "Thrower" || name == "Minion" || name == "Hog Rider" || name == "Valkyrie"
      || name == "Golem" || name == "Witch" || name == "Lava Hound" || name == "Bowler"
      || name == "Ice Golem" || name == "Headhunter" || name == "Apprentice Warden" || name == "Druid";
}

bool isSuperTroop(String name) {
  return name == "Super Barbarian" || name == "Super Archer" || name == "Super Giant" || name == "Sneaky Goblin"
      || name == "Super Wall Breaker" || name == "Rocket Balloon" || name == "Super Wizard"
      || name == "Super Dragon" || name == "Inferno Dragon" || name == "Super Minion" || name == "Super Valkyrie"
      || name == "Super Witch" || name == "Ice Hound" || name == "Super Bowler" || name == "Super Miner"
      || name == "Super Hog Rider";
}

bool isBuilderTroop(String name) {
  return name == "Raged Barbarian" || name == "Sneaky Archer" || name == "Boxer Giant" || name == "Beta Minion"
      || name == "Bomber" || name == "Baby Dragon" || name == "Cannon Cart"
      || name == "Night Witch" || name == "Drop Ship" || name == "Power P.E.K.K.A" || name == "Hog Glider"
      || name == "Electrofire Wizard";
}

bool isPet(String name) {
  return name == "L.A.S.S.I" || name == "Electro Owl" || name == "Mighty Yak" || name == "Unicorn"
      || name == "Frosty" || name == "Diggy" || name == "Poison Lizard"
      || name == "Phoenix" || name == "Spirit Fox" || name == "Angry Jelly" || name == "Sneezy";
}

bool isSiegeMachine(String name) {
  return name == "Wall Wrecker" || name == "Battle Blimp" || name == "Stone Slammer" || name == "Siege Barracks"
      || name == "Log Launcher" || name == "Flame Flinger" || name == "Battle Drill"
      || name == "Troop Launcher";
}

bool isDifferent(String name1, String name2) {
  return isNormalTroop(name1) != isSuperTroop(name2) || isSuperTroop(name1) != isBuilderTroop(name2) ||
      isBuilderTroop(name1) != isSiegeMachine(name2);
}