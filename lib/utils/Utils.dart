import 'dart:convert';
import 'dart:io' as io;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clashofclanstracker/utils/img/ShortAsset.dart';
import 'package:flutter/material.dart';

import 'UserSP.dart';

String getBaseUrl() {
  final baseUrl = 'http://185.239.238.224:3000/';
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

  if(name == "L.A.S.S.I") return Image.asset(lassi, scale: 2.5);
  if(name == "Electro Owl") return Image.asset(electro_owl, scale: 2.5);
  if(name == "Mighty Yak") return Image.asset(mighty_yak, scale: 2.5);
  if(name == "Unicorn") return Image.asset(unicorn, scale: 2.5);
  if(name == "Frosty") return Image.asset(frosty, scale: 2.5);
  if(name == "Diggy") return Image.asset(diggy, scale: 2.5);
  if(name == "Poison Lizard") return Image.asset(poison_lizard, scale: 2.5);
  if(name == "Phoenix") return Image.asset(phoenix, scale: 2.5);
  if(name == "Spirit Fox") return Image.asset(spirit_fox, scale: 2.5);
  if(name == "Angry Jelly") return Image.asset(angry_jelly, scale: 2.5);
  if(name == "Sneezy") return Image.asset(sneezy, scale: 2.5);

  if(name == "Lightning Spell") return Image.asset(lightning_spell, scale: 3.5);
  if(name == "Healing Spell") return Image.asset(healing_spell, scale: 3.5);
  if(name == "Rage Spell") return Image.asset(rage_spell, scale: 3.5);
  if(name == "Jump Spell") return Image.asset(jump_spell, scale: 3.5);
  if(name == "Freeze Spell") return Image.asset(freeze_spell, scale: 3.5);
  if(name == "Poison Spell") return Image.asset(poison_spell, scale: 3.5);
  if(name == "Earthquake Spell") return Image.asset(earthquake_spell, scale: 3.5);
  if(name == "Haste Spell") return Image.asset(haste_spell, scale: 3.5);
  if(name == "Clone Spell") return Image.asset(clone_spell, scale: 3.5);
  if(name == "Skeleton Spell") return Image.asset(skeleton_spell, scale: 3.5);
  if(name == "Bat Spell") return Image.asset(bat_spell, scale: 3.5);
  if(name == "Invisibility Spell") return Image.asset(invisibility_spell, scale: 3.5);
  if(name == "Recall Spell") return Image.asset(recall_spell, scale: 2.5);
  if(name == "Overgrowth Spell") return Image.asset(overgrowth_spell, scale: 2.5);
  if(name == "Revive Spell") return Image.asset(revive_spell, scale: 2.5);

  if(name == "Barbarian King") return Image.asset(barbarianKing, scale: 1.5);
  if(name == "Archer Queen") return Image.asset(archerQueen, scale: 1.5);
  if(name == "Grand Warden") return Image.asset(grandWarden, scale: 1.5);
  if(name == "Battle Machine") return Image.asset(battleMachine, scale: 1.5);
  if(name == "Royal Champion") return Image.asset(royalChampion, scale: 1.5);
  if(name == "Battle Copter") return Image.asset(battleCopter, scale: 1.5);
  if(name == "Minion Prince") return Image.asset(minionPrince, scale: 1.5);

  if(name == "Barbarian Puppet") return Image.asset(babarian_puppet, scale: 3.5);
  if(name == "Rage Vial") return Image.asset(rage_vial, scale: 3.5);
  if(name == "Earthquake Boots") return Image.asset(earthquake_boots, scale: 3.5);
  if(name == "Vampstache") return Image.asset(vampstache, scale: 3.5);
  if(name == "Giant Gauntlet") return Image.asset(giant_gauntlet, scale: 3.5);
  if(name == "Spiky Ball") return Image.asset(spiky_ball, scale: 3.5);
  if(name == "Snake Bracelet") return Image.asset(snake_bracelet, scale: 3.5);
  if(name == "Archer Puppet") return Image.asset(archer_puppet, scale: 3.5);
  if(name == "Invisibility Vial") return Image.asset(invisibility_vial, scale: 3.5);
  if(name == "Giant Arrow") return Image.asset(giant_arrow, scale: 3.5);
  if(name == "Healer Puppet") return Image.asset(healer_puppet, scale: 3.5);
  if(name == "Frozen Arrow") return Image.asset(frozen_arrow, scale: 3.5);
  if(name == "Magic Mirror") return Image.asset(magic_mirror, scale: 3.5);
  if(name == "Action Figure") return Image.asset(action_figure, scale: 3.5);
  if(name == "Henchmen Puppet") return Image.asset(henchmen_puppet, scale: 3.5);
  if(name == "Dark Orb") return Image.asset(dark_orb, scale: 3.5);
  if(name == "Metal Pants") return Image.asset(metal_pants, scale: 3.5);
  if(name == "Noble Iron") return Image.asset(noble_iron, scale: 3.5);
  if(name == "Eternal Tome") return Image.asset(eternal_tome, scale: 3.5);
  if(name == "Life Gem") return Image.asset(life_gem, scale: 3.5);
  if(name == "Rage Gem") return Image.asset(rage_gem, scale: 3.5);
  if(name == "Healing Tome") return Image.asset(healing_tome, scale: 3.5);
  if(name == "Fireball") return Image.asset(fireball, scale: 3.5);
  if(name == "Lavaloon Puppet") return Image.asset(lavaloon_puppet, scale: 3.5);
  if(name == "Royal Gem") return Image.asset(royal_gem, scale: 3.5);
  if(name == "Seeking Shield") return Image.asset(seeking_shield, scale: 3.5);
  if(name == "Hog Rider Puppet") return Image.asset(hog_rider_puppet, scale: 3.5);
  if(name == "Haste Vial") return Image.asset(haste_vial, scale: 3.5);
  if(name == "Rocket Spear") return Image.asset(rocket_spear, scale: 3.5);
  if(name == "Electro Boots") return Image.asset(electro_boots, scale: 3.5);
  if(name == "Dark Crown") return Image.asset(dark_crown, scale: 3.5);
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

List<dynamic> getSpells(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
     result.add(element);
  }
  return result;
}

List<dynamic> getKingEquipment(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(isKingEquipment(element["name"])) {
      result.add(element);
    }
  }
  return result;
}

List<dynamic> getQueenEquipment(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(isQueenEquipment(element["name"])) {
      result.add(element);
    }
  }
  return result;
}

List<dynamic> getWardenEquipment(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(isWardenEquipment(element["name"])) {
      result.add(element);
    }
  }
  return result;
}

List<dynamic> getMinionPrinceEquipment(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(isMinionPrinceEquipment(element["name"])) {
      result.add(element);
    }
  }
  return result;
}

List<dynamic> getRoyalChampEquipment(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(isRoyalChampEquipment(element["name"])) {
      result.add(element);
    }
  }
  return result;
}

List<dynamic> getHomeAchievements(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(element["village"] == "home") {
      result.add(element);
    }
  }
  return result;
}

List<dynamic> getBuilderHallAchievements(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(element["village"] == "builderBase") {
      result.add(element);
    }
  }
  return result;
}

List<dynamic> getCapitalAchievements(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(element["village"] == "clanCapital") {
      result.add(element);
    }
  }
  return result;
}

List<dynamic> getNormalHeroes(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(isNormalHero(element["name"])) result.add(element);
  }
  return result;
}

List<dynamic> getBuilderHeroes(List<dynamic> list) {
  List<dynamic> result = [];
  for(var element in list) {
    if(isBuilderHero(element["name"]))result.add(element);
  }
  return result;
}

int getNextShiny(var list) {
  if(list["level"] == 1) return 120;
  if(list["level"] == 2) return 240;
  if(list["level"] == 3) return 400;
  if(list["level"] == 4) return 600;
  if(list["level"] == 5) return 840;
  if(list["level"] == 6) return 1120;
  if(list["level"] == 7) return 1440;
  if(list["level"] == 8) return 1800;
  if(list["level"] == 9) return 1900;
  if(list["level"] == 10) return 2000;
  if(list["level"] == 11) return 2100;
  if(list["level"] == 12) return 2200;
  if(list["level"] == 13) return 2300;
  if(list["level"] == 14) return 2400;
  if(list["level"] == 15) return 2500;
  if(list["level"] == 16) return 2600;
  if(list["level"] == 17) return 2700;
  if(list["maxLevel"] == 27) {
    if (list["level"] == 18) return 2800;
    if (list["level"] == 19) return 2900;
    if (list["level"] == 20) return 3000;
    if (list["level"] == 21) return 3100;
    if (list["level"] == 22) return 3200;
    if (list["level"] == 23) return 3300;
    if (list["level"] == 24) return 3400;
    if (list["level"] == 25) return 3500;
    if (list["level"] == 26) return 3600;
  }
  return 0;
}

int getNextGlowy(var list) {
  if(list["level"] == 2) return 20;
  if(list["level"] == 5) return 100;
  if(list["level"] == 8) return 200;
  if(list["level"] == 11) return 400;
  if(list["level"] == 14) return 600;
  if(list["level"] == 17) return 600;
  if(list["maxLevel"] == 27) {
    if (list["level"] == 20) return 600;
    if (list["level"] == 23) return 600;
    if (list["level"] == 26) return 600;
  }
  return 0;
}

int getNextStarry(var list) {
  if (list["maxLevel"] == 27) {
    if (list["level"] == 8) return 10;
    if (list["level"] == 11) return 20;
    if (list["level"] == 14) return 30;
    if (list["level"] == 17) return 50;
    if (list["level"] == 20) return 100;
    if (list["level"] == 23) return 120;
    if (list["level"] == 26) return 150;
  }
  return 0;
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

bool isNormalHero(String name) {
  return name == "Barbarian King" || name == "Archer Queen" || name == "Grand Warden" || name == "Royal Champion"
      || name == "Minion Prince";
}

bool isBuilderHero(String name) {
  return name == "Battle Machine" || name == "Battle Copter";
}

List<dynamic> filterAchievements(List<dynamic> list) {
  List res = [];
  for(var el in list) {
    if(el["name"] != "Keep Your Account Safe!") {
      res.add(el);
    }
  }
  return res;
}

bool isKingEquipment(String name) {
  return name == "Barbarian Puppet" || name == "Rage Vial" || name == "Earthquake Boots" || name == "Vampstache" || name == "Giant Gauntlet" || name == "Spiky Ball" || name == "Snake Bracelet";
}

bool isQueenEquipment(String name) {
  return name == "Archer Puppet" || name == "Invisibility Vial" || name == "Giant Arrow" || name == "Healer Puppet" || name == "Frozen Arrow" || name == "Magic Mirror" || name == "Action Figure";
}

bool isMinionPrinceEquipment(String name) {
  return name == "Henchmen Puppet" || name == "Dark Orb" || name == "Metal Pants" || name == "Noble Iron" || name == "Dark Crown";
}

bool isWardenEquipment(String name) {
  return name == "Eternal Tome" || name == "Life Gem" || name == "Rage Gem" || name == "Healing Tome" || name == "Fireball" || name == "Lavaloon Puppet";
}

bool isRoyalChampEquipment(String name) {
  return name == "Royal Gem" || name == "Seeking Shield" || name == "Hog Rider Puppet" || name == "Haste Vial" || name == "Rocket Spear" || name == "Electro Boots";
}

Text getRole(String role) {
  return Text(role == "coLeader"? "Co-Leader" : role == "leader"? "Leader" : role == "elder"? "Elder" : "Member", style: const TextStyle(
      color: Colors.white,
      fontFamily: "Poppins",
      fontSize: 15));
}

Image getDistrictHallImage(int level) {
  if(level == 1) return Image.asset(district_hall1, scale: 3);
  if(level == 2) return Image.asset(district_hall2, scale: 3);
  if(level == 3) return Image.asset(district_hall3, scale: 3);
  if(level == 4) return Image.asset(district_hall4, scale: 3);
  if(level == 5) return Image.asset(district_hall5, scale: 3);
  return Image.asset(district_hall1, scale: 3);
}

Image getCapitalHallImage(int level) {
  if(level == 1) return Image.asset(capital_hall1, scale: 3);
  if(level == 2) return Image.asset(capital_hall2, scale: 3);
  if(level == 3) return Image.asset(capital_hall3, scale: 3);
  if(level == 4) return Image.asset(capital_hall4, scale: 3);
  if(level == 5) return Image.asset(capital_hall5, scale: 3);
  if(level == 6) return Image.asset(capital_hall6, scale: 3);
  if(level == 7) return Image.asset(capital_hall7, scale: 3);
  return Image.asset(capital_hall1, scale: 3);
}

Map<String, dynamic> getDefensesAndCount(int thlevel, Map<String, dynamic> map) {
  return map["defenses"]["minCounts"]["$thlevel"] ?? {};
}

Map<String, dynamic> getMaxDefensesAndCount(int thlevel, Map<String, dynamic> map) {
  return map["defenses"]["counts"]["$thlevel"] ?? {};
}

Map<String, dynamic> getDefensesAndMaxLevel(int thlevel, Map<String, dynamic> map) {
  return map["defenses"]["minmaxLevels"]["$thlevel"] ?? {};
}

Map<String, dynamic> getMaxDefensesAndMaxLevel(int thlevel, Map<String, dynamic> map) {
  return map["defenses"]["maxLevels"]["$thlevel"] ?? {};
}

Map<String, dynamic> getTrapsAndCount(int thlevel, Map<String, dynamic> map) {
  return map["traps"]["minCounts"]["$thlevel"] ?? {};
}

Map<String, dynamic> getMaxTrapsAndCount(int thlevel, Map<String, dynamic> map) {
  return map["traps"]["counts"]["$thlevel"] ?? {};
}

Map<String, dynamic> getTrapsAndMaxLevel(int thlevel, Map<String, dynamic> map) {
  return map["traps"]["minmaxLevels"]["$thlevel"] ?? {};
}

Map<String, dynamic> getMaxTrapsAndMaxLevel(int thlevel, Map<String, dynamic> map) {
  return map["traps"]["maxLevels"]["$thlevel"] ?? {};
}

Map<String, dynamic> getArmyAndCount(int thlevel, Map<String, dynamic> map) {
  return map["army"]["minCounts"]["$thlevel"] ?? {};
}

Map<String, dynamic> getMaxArmyAndCount(int thlevel, Map<String, dynamic> map) {
  return map["army"]["counts"]["$thlevel"] ?? {};
}

Map<String, dynamic> getArmyAndMaxLevel(int thlevel, Map<String, dynamic> map) {
  return map["army"]["minmaxLevels"]["$thlevel"] ?? {};
}

Map<String, dynamic> getMaxArmyAndMaxLevel(int thlevel, Map<String, dynamic> map) {
  return map["army"]["maxLevels"]["$thlevel"] ?? {};
}

Map<String, dynamic> getResourceAndCount(int thlevel, Map<String, dynamic> map) {
  return map["resources"]["minCounts"]["$thlevel"] ?? {};
}

Map<String, dynamic> getMaxResourceAndCount(int thlevel, Map<String, dynamic> map) {
  return map["resources"]["counts"]["$thlevel"] ?? {};
}

Map<String, dynamic> getResourceAndMaxLevel(int thlevel, Map<String, dynamic> map) {
  return map["resources"]["minmaxLevels"]["$thlevel"] ?? {};
}

Map<String, dynamic> getMaxResourceAndMaxLevel(int thlevel, Map<String, dynamic> map) {
  return map["resources"]["maxLevels"]["$thlevel"] ?? {};
}

int getWalls(int thlevel, Map<String, dynamic> map) {
  return map["walls"]["minCounts"]["$thlevel"] ?? 0;
}

int getMaxWalls(int thlevel, Map<String, dynamic> map) {
  return map["walls"]["counts"]["$thlevel"] ?? 0;
}

int getWallsMaxLevel(int thlevel, Map<String, dynamic> map) {
  return map["walls"]["minmaxLevels"]["$thlevel"] ?? 0;
}

int getMaxWallsMaxLevel(int thlevel, Map<String, dynamic> map) {
  return map["walls"]["maxLevels"]["$thlevel"] ?? 0;
}

int getWallOverallMaxLevel(Map<String, dynamic> map) {
  int max = 0;
  map["walls"]["maxLevels"].forEach((key, val) {
    if(val > max) {
      max = val;
    }
  });
  return max;
}

Image getBuildingImage(int thlevel, String name, int level) {
  if(name == "wall") name = "Wall";
  String pathname = 'lib/utils/img/buildings/$name$level.webp';
  if(getTownHallWeapon(thlevel) == name) {
    pathname = 'lib/utils/img/buildings/$thlevel$name$level.webp';
  }
  return Image.asset(pathname, scale: 2, errorBuilder: (ctx, error, stackTrace) {
    if(level == 0) {
      return Opacity(opacity: 0.2, child: Image.asset('lib/utils/img/buildings/$name${level + 1}.webp', scale: 2));
    } else {
      return Image.asset(defenseShield, scale: 1);
    }
  });
}

String getTownHallWeapon(int thlevel) {
  if(thlevel == 12) return "Giga Tesla";
  if(thlevel == 13 || thlevel == 14 || thlevel == 15 || thlevel == 16) return "Giga Inferno";
  if(thlevel == 17) return "Inferno Artillery";
  return "Inferno Artillery";
}

Map<String, dynamic> getDefaultWalls(int thlevel, Map<String, dynamic> buildings) {
  Map<String, int> wallsmap = {};
  int wmincount = getWalls(thlevel, buildings);
  int wmaxcount = getMaxWalls(thlevel, buildings);
  int wmaxlevel = getMaxWallsMaxLevel(thlevel, buildings);
  int wminlevel = getWallsMaxLevel(thlevel, buildings);
  wallsmap["wall-$wminlevel"] = wmincount;
  return wallsmap;
}

Map<String, dynamic> getDefaultDefenses(int thlevel, Map<String, dynamic> buildings) {
  Map<String, int> defensemap = {};
  Map<String, dynamic> dmincount = getDefensesAndCount(thlevel, buildings);
  Map<String, dynamic> dmaxcount = getMaxDefensesAndCount(thlevel, buildings);
  Map<String, dynamic> dminlevel = getDefensesAndMaxLevel(thlevel, buildings);
  dmincount.forEach((key, val){
    int count = 0;
    for (int i = 0; i < val; i++) {
      int max = dminlevel[key]!;
      defensemap["$key-$count"] = max;
      count++;
    }
    if (val < dmaxcount[key]) {
      for (int j = 0; j < dmaxcount[key] - val; j++) {
        defensemap["$key-$count"] = 0;
        count++;
      }
    }
  });
  dmaxcount.forEach((key, val){
    if(!dmincount.containsKey(key)) {
      for (int i = 0; i < val; i++) {
        defensemap["$key-$i"] = 0;
      }
    }
  });
  return defensemap;
}

Map<String, dynamic> getDefaultTraps(int thlevel, Map<String, dynamic> buildings) {
  Map<String, int> trapmap = {};
  Map<String, dynamic> tmincount = getTrapsAndCount(thlevel, buildings);
  Map<String, dynamic> tmaxcount = getMaxTrapsAndCount(thlevel, buildings);
  Map<String, dynamic> tminlevel = getTrapsAndMaxLevel(thlevel, buildings);
  tmincount.forEach((key, val){
    int count = 0;
    for (int i = 0; i < val; i++) {
      int max = tminlevel[key]!;
      trapmap["$key-$count"] = max;
      count++;
    }
    if (val < tmaxcount[key]) {
      for (int j = 0; j < tmaxcount[key] - val; j++) {
        trapmap["$key-$count"] = 0;
        count++;
      }
    }
  });
  tmaxcount.forEach((key, val){
    if(!tmincount.containsKey(key)) {
      for (int i = 0; i < val; i++) {
        trapmap["$key-$i"] = 0;
      }
    }
  });
  return trapmap;
}

Map<String, dynamic> getDefaultArmyBuildings(int thlevel, Map<String, dynamic> buildings) {
  Map<String, int> armymap = {};
  Map<String, dynamic> amincount = getArmyAndCount(thlevel, buildings);
  Map<String, dynamic> amaxcount = getMaxArmyAndCount(thlevel, buildings);
  Map<String, dynamic> aminlevel = getArmyAndMaxLevel(thlevel, buildings);
  amincount.forEach((key, val){
    int count = 0;
    for (int i = 0; i < val; i++) {
      int max = aminlevel[key]!;
      armymap["$key-$count"] = max;
      count++;
    }
    if(val < amaxcount[key]) {
      for(int j = 0; j < amaxcount[key] - val; j++) {
        armymap["$key-$count"] = 0;
        count++;
      }
    }
  });
  amaxcount.forEach((key, val){
    if(!amincount.containsKey(key)) {
      for (int i = 0; i < val; i++) {
        armymap["$key-$i"] = 0;
      }
    }
  });
  return armymap;
}

Map<String, dynamic> getDefaultResources(int thlevel, Map<String, dynamic> buildings) {
  Map<String, int> resourcesmap = {};
  Map<String, dynamic> rmincount = getResourceAndCount(thlevel, buildings);
  Map<String, dynamic> rmaxcount = getResourceAndCount(thlevel, buildings);
  Map<String, dynamic> rminlevel = getResourceAndMaxLevel(thlevel, buildings);
  rmincount.forEach((key, val){
    int count = 0;
    for (int i = 0; i < val; i++) {
      int max = rminlevel[key]!;
      resourcesmap["$key-$count"] = max;
      count++;
    }
    if(val < rmaxcount[key]) {
      for(int j = 0; j < rmaxcount[key] - val; j++) {
        resourcesmap["$key-$count"] = 0;
        count++;
      }
    }
  });
  rmaxcount.forEach((key, val){
    if(!rmincount.containsKey(key)) {
      for (int i = 0; i < val; i++) {
        resourcesmap["$key-$i"] = 0;
      }
    }
  });
  return resourcesmap;
}

Map<String, dynamic> rearrangeWalls(Map<String, dynamic> map, String key, int oldvalue, int diffvalue) {
  if(diffvalue < 0) {
    if(map[key] - diffvalue.abs() >= 0) {
      int newval = int.parse(key.substring(key.lastIndexOf("-") + 1, key.length)) - 1;
      if (map["${key.substring(0, key.lastIndexOf("-"))}-$newval"] != null) {
        map["${key.substring(0, key.lastIndexOf("-"))}-$newval"] = map["${key.substring(0, key.lastIndexOf("-"))}-$newval"] + diffvalue.abs();
      } else {
        map["${key.substring(0, key.lastIndexOf("-"))}-$newval"] = diffvalue.abs();
      }
      if (map[key] - diffvalue.abs() >= 1) {
        map[key] = map[key] - diffvalue.abs();
      } else {
        map.remove(key);
      }
    }
  } else if(diffvalue > 0) {
    if(map[key] - diffvalue.abs() >= 0) {
      int newval = int.parse(key.substring(key.lastIndexOf("-") + 1, key.length)) + 1;
      if (map["${key.substring(0, key.lastIndexOf("-"))}-$newval"] != null) {
        map["${key.substring(0, key.lastIndexOf("-"))}-$newval"] = map["${key.substring(0, key.lastIndexOf("-"))}-$newval"] + diffvalue.abs();
      } else {
        map["${key.substring(0, key.lastIndexOf("-"))}-$newval"] = diffvalue.abs();
      }
      if (map[key] - diffvalue.abs() >= 1) {
        map[key] = map[key] - diffvalue.abs();
      } else {
        map.remove(key);
      }
    }
  }
  return map;
}

Map<String, dynamic> editWalls(Map<String, dynamic> buildings, Map<String, dynamic> map, String key, int oldvalue, int newval) {
  int overallmax = getWallOverallMaxLevel(buildings);
  int currentlevel = int.parse(key.substring(key.lastIndexOf("-") + 1, key.length));
  if(newval < oldvalue) {
    if(currentlevel < overallmax) {
      map[key] = newval;
      map["${key.substring(0, key.lastIndexOf("-"))}-${currentlevel + 1}"] = (map["${key.substring(0, key.lastIndexOf("-"))}-${currentlevel + 1}"] == null? 0 : map["${key.substring(0, key.lastIndexOf("-"))}-${currentlevel + 1}"]) + (oldvalue - newval);
    } else {
      if(currentlevel >= 1) {
        map[key] = newval;
        map["${key.substring(0, key.lastIndexOf("-"))}-${currentlevel - 1}"] = (map["${key.substring(0, key.lastIndexOf("-"))}-${currentlevel - 1}"] == null? 0 : map["${key.substring(0, key.lastIndexOf("-"))}-${currentlevel - 1}"]) + (oldvalue - newval);
      }
    }
  } else if(newval > oldvalue) {
    if(currentlevel < overallmax) {
      if(map["${key.substring(0, key.lastIndexOf("-"))}-${currentlevel + 1}"] >= (newval - oldvalue)) {
        map[key] = newval;
        map["${key.substring(0, key.lastIndexOf("-"))}-${currentlevel + 1}"] = (map["${key.substring(0, key.lastIndexOf("-"))}-${currentlevel + 1}"] == null ? 0 : map["${key.substring(0, key.lastIndexOf("-"))}-${currentlevel + 1}"]) - (newval - oldvalue);
      }
    } else if(currentlevel >= 1) {
      map[key] = newval;
      map["${key.substring(0, key.lastIndexOf("-"))}-${currentlevel - 1}"] = (map["${key.substring(0, key.lastIndexOf("-"))}-${currentlevel - 1}"] == null? 0 : map["${key.substring(0, key.lastIndexOf("-"))}-${currentlevel - 1}"]) - (newval - oldvalue);
    }
  }
  return map;
}

bool canWallBeIncreased(int thlevel, Map<String, dynamic> map, int currentLevel) {
  int wallmaxlevel = getMaxWallsMaxLevel(thlevel, map);
  return currentLevel < wallmaxlevel;
}

bool isWallUnderMax(int thlevel, Map<String, dynamic> map, int currentLevel) {
  int wallmaxlevel = getMaxWalls(thlevel, map);
  return currentLevel <= wallmaxlevel;
}

bool canWallBeDecreased(int thlevel, Map<String, dynamic> map, int currentLevel) {
  return currentLevel > 1;
}

Widget getFirstClan(Map<String, dynamic> map) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ?map["clan"] !=null && map["state"] != "notInWar"? Image.network(map["clan"]["badgeUrls"]["small"], scale: 1) : null,
      ?map["clan"] !=null && map["state"] != "notInWar"? SizedBox(height: 10) : null,
      AutoSizeText(map["clan"] !=null && map["state"] != "notInWar"? map["clan"]["name"] : "-",
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "Poppins",
          fontSize: 20,
        ),
        maxLines: 1,
      ),
      ?map["clan"] !=null && map["state"] != "notInWar"? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(star, scale: 1.5),
          SizedBox(width: 5),
          Text("${map["clan"]["stars"]}",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontSize: 15,
            )
          ),
          SizedBox(width: 15),
          Icon(Icons.percent, color: Colors.white, size: 20),
          SizedBox(width: 2),
          Text("${map["clan"]["destructionPercentage"].toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontSize: 15,
            )
          )
        ],
      ) : null,
      ?map["clan"] !=null && map["state"] != "notInWar"? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Attacks: ${map["clan"]["attacks"]}",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontSize: 15,
            )
          )
        ],
      ) : null,
    ],
  );
}

Widget getOpponentClan(Map<String, dynamic> map) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ?map["opponent"] !=null && map["state"] != "notInWar"? Image.network(map["opponent"]["badgeUrls"]["small"], scale: 1) : null,
      ?map["opponent"] !=null && map["state"] != "notInWar"? SizedBox(height: 10) : null,
      AutoSizeText(map["opponent"] !=null && map["state"] != "notInWar"? map["opponent"]["name"] : "-",
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "Poppins",
          fontSize: 20,
        ),
        maxLines: 1,
      ),
      ?map["opponent"] !=null && map["state"] != "notInWar"? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(star, scale: 1.5),
          SizedBox(width: 5),
          Text("${map["opponent"]["stars"]}",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontSize: 15,
            )
          ),
          SizedBox(width: 12),
          Icon(Icons.percent, color: Colors.white, size: 20),
          SizedBox(width: 2),
          Text("${map["opponent"]["destructionPercentage"].toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontSize: 15,
            )
          )
        ],
      ) : null,
      ?map["opponent"] !=null && map["state"] != "notInWar"? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Attacks: ${map["opponent"]["attacks"]}",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontSize: 15,
            )
          )
        ],
      ) : null,
    ],
  );
}

Text getStateText(String text) {
  if(text == "preparation") return Text("Vorbereitung", style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20));
  if(text == "inWar") return Text("Endet in", style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20));
  return Text("Neue Runde in", style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20));
}

Text getClanWarStateText(String text) {
  if(text == "preparation") return Text("Vorbereitung", style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20));
  if(text == "inWar") return Text("Endet in", style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20));
  return Text("War vorbei", style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20));
}

Row getClanWarStars(Map<String, dynamic> map) {
  return Row(
    children: [
      for(int i = 0; i < map["bestOpponentAttack"]["stars"]; i++) Image.asset(whitestar, scale: 6),
      for(int i = 0; i < (3 - map["bestOpponentAttack"]["stars"]); i++) Image.asset(whitestarempty, scale: 6),
      SizedBox(width: 5),
      Text("${map["bestOpponentAttack"]["destructionPercentage"]}%", style: const TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 12))
    ],
  );
}

List<Map<String, dynamic>> sortClanWarMembers(List<Map<String, dynamic>> members) {
  members.sort((a, b) => (a['mapPosition']).compareTo(b['mapPosition']));
  return members;
}

Map<String, dynamic> getClanWarRanking(Map<String, dynamic> map) {
  Map<String, dynamic> tempmap = {};
  map.forEach((key, val){
    for(var war in val) {
      if(tempmap[war["clan"]["tag"]] == null) tempmap[war["clan"]["tag"]] = {};
      if(tempmap[war["opponent"]["tag"]] == null) tempmap[war["opponent"]["tag"]] = {};
      if(tempmap[war["clan"]["tag"]]["stars"] == null) tempmap[war["clan"]["tag"]]["stars"] = 0;
      if(tempmap[war["opponent"]["tag"]]["stars"] == null) tempmap[war["opponent"]["tag"]]["stars"] = 0;
      if(tempmap[war["clan"]["tag"]]["percentage"] == null) tempmap[war["clan"]["tag"]]["percentage"] = 0;
      if(tempmap[war["opponent"]["tag"]]["percentage"] == null) tempmap[war["opponent"]["tag"]]["percentage"] = 0;
      tempmap[war["clan"]["tag"]]["name"] = war["clan"]["name"];
      tempmap[war["opponent"]["tag"]]["name"] = war["opponent"]["name"];
      tempmap[war["clan"]["tag"]]["stars"] = tempmap[war["clan"]["tag"]]["stars"] + war["clan"]["stars"];
      tempmap[war["opponent"]["tag"]]["stars"] = tempmap[war["opponent"]["tag"]]["stars"] + war["opponent"]["stars"];
      tempmap[war["clan"]["tag"]]["percentage"] = tempmap[war["clan"]["tag"]]["percentage"] + (war["clan"]["destructionPercentage"] / 100) * (war["teamSize"] * 100);
      tempmap[war["opponent"]["tag"]]["percentage"] = tempmap[war["opponent"]["tag"]]["percentage"] + (war["opponent"]["destructionPercentage"] / 100) * (war["teamSize"] * 100);
      if(war["state"] == "warEnded") { //Wenn War vorbei ist
        print(war["clan"]["stars"]);
        print(war["opponent"]["stars"]);
        if(war["clan"]["stars"] > war["opponent"]["stars"]) { //Clan mehr Sterne
          tempmap[war["clan"]["tag"]]["stars"] = tempmap[war["clan"]["tag"]]["stars"] + 10;
        } else if(war["clan"]["stars"] < war["opponent"]["stars"]) { //Opponent mehr Sterne
          tempmap[war["opponent"]["tag"]]["stars"] = tempmap[war["opponent"]["tag"]]["stars"] + 10;
        } else if(war["clan"]["stars"] == war["opponent"]["stars"]) { //Gleich viele Sterne
          if(war["clan"]["destructionPercentage"] > war["opponent"]["destructionPercentage"]) tempmap[war["clan"]["tag"]]["stars"] = tempmap[war["clan"]["tag"]]["stars"] + 10;
          if(war["clan"]["destructionPercentage"] < war["opponent"]["destructionPercentage"]) tempmap[war["opponent"]["tag"]]["stars"] = tempmap[war["opponent"]["tag"]]["stars"] + 10;
        }
      }
    }
  });
  final sortedEntries = tempmap.entries.toList()
    ..sort((a, b) {
      final starsA = a.value["stars"]!;
      final starsB = b.value["stars"]!;
      final percentageA = a.value["percentage"]!;
      final percentageB = b.value["percentage"]!;

      if (starsA != starsB) {
        return starsB.compareTo(starsA); // Absteigend nach stars
      } else {
        return percentageB.compareTo(percentageA); // Absteigend nach percentage
      }
    });
  final sortedMap = Map<String, dynamic>.fromEntries(sortedEntries);
  return sortedMap;
}