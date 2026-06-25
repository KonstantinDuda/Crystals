import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import 'crystal.dart';

class Database {
  static final Database _instance = Database._internal();

  factory Database() {
    return _instance;
  }

  Database._internal() {
    //_generateDatabase();
    loadData();
  }

  final List<CrystalPart> _database = [];
  List<CrystalPart> _moneyParts = [];
  List<CrystalPart> _weaponParts = [];

  Future<void> loadData() async {
    // Читаємо файл з папки assets
    final String response = await rootBundle.loadString('lib/assets/crystal_parts.json');
    final data = await json.decode(response);

    // Парсимо списки з JSON
    _moneyParts = (data['money_parts'] as List)
        .map((item) => CrystalPart.fromJson(item))
        .toList();

    _weaponParts = (data['weapon_parts'] as List)
        .map((item) => CrystalPart.fromJson(item))
        .toList();

    _database.addAll(_moneyParts);
    _database.addAll(_weaponParts);
  }

  List<CrystalPart> get moneyParts => _moneyParts;
  List<CrystalPart> get weaponParts => _weaponParts; 
  List<CrystalPart> get database => _database;

  /*void _generateDatabase() {
    PartSide getSide() {
      var side = PartSide.left;
      var rand = Random().nextInt(3);
      if (rand == 1) {
        side = PartSide.center;
      } else if (rand == 2) {
        side = PartSide.right;
      }
      return side;
    }

    for (int i = 2; i < 14; i++) {
      var money = 1;
      var damage = 1;

      var localName = "Crystal";
      var descMoney = "Get $money money";
      var descWeapon = "Deal $damage damage";

      if (i >= 2 && i < 5) {
        var side = getSide();
        var newPart = createCrystalPart(
          localName,
          descMoney,
          i,
          PartType.money,
          side,
          money,
        );
        _moneyParts.add(newPart);
      }
      if (i >= 4 && i < 8) {
        money = 2;
        descMoney = "Get $money money";
        var side = getSide();
        var newPart = createCrystalPart(
          localName,
          descMoney,
          i,
          PartType.money,
          side,
          money,
        );
        _moneyParts.add(newPart);

        var weapSide = getSide();
        var newWeap = createCrystalPart(
          localName,
          descWeapon,
          i,
          PartType.weapon,
          weapSide,
          damage,
        );
        _weaponParts.add(newWeap);
      }
      if (i >= 7 && i < 12) {
        money = 3;
        descMoney = "Get $money money";
        var side = getSide();
        var newPart = createCrystalPart(
          localName,
          descMoney,
          i,
          PartType.money,
          side,
          money,
        );
        _moneyParts.add(newPart);

        damage = 2;
        descWeapon = "Deal $damage damage";
        var weapSide = getSide();
        var newWeap = createCrystalPart(
          localName,
          descWeapon,
          i,
          PartType.weapon,
          weapSide,
          damage,
        );
        _weaponParts.add(newWeap);
      }
      if (i >= 11 && i <= 13) {
        damage = 3;
        descWeapon = "Deal $damage damage";
        var weapSide = getSide();
        var newWeap = createCrystalPart(
          localName,
          descWeapon,
          i,
          PartType.weapon,
          weapSide,
          damage,
        );
        _weaponParts.add(newWeap);
      }
    }
    //print("_generateDatabase. _database: $_database");
  }

  CrystalPart createCrystalPart(
    String name,
    String description,
    int price,
    PartType type,
    PartSide side,
    int value,
  ) {
    int localId = _database.isEmpty ? 1 : _database.last.id + 1;
    CrystalPart newCrystal = CrystalPart(
      id: localId,
      name: name,
      description: description,
      price: price,
      type: type,
      side: side,
      value: value,
    );
    if (newCrystal.type == PartType.money) {
      _moneyParts.add(newCrystal);
    } else if (newCrystal.type == PartType.weapon) {
      _weaponParts.add(newCrystal);
    }
    _database.add(newCrystal);
    return newCrystal;
  }*/

  CrystalPart getCrystalPart(int id) {
    var result = _database.firstWhere(
      ((element) => element.id == id),
      orElse: () => CrystalPart.empty(),
    );
    return result;
  }

  void updateCrystalPart(int id, CrystalPart newPart) {
    var index = _getIndex(id);
    var oldPart = CrystalPart.empty();

    if (index > -1) {
      oldPart = newPart;
      oldPart.id = id;

      _database[index] = oldPart;
    }
    print("_database: updateCrystalPart oldPart == $oldPart");
  }

  void deleteCrystalPart(int id) {
    var index = _getIndex(id);
    if (index > -1) _database.removeAt(index);
  }

  int _getIndex(int id) {
    var part = _database.firstWhere(
      ((element) => element.id == id),
      orElse: () => CrystalPart.empty(),
    );
    var result = _database.indexOf(part);
    return result;
  }

  int getDataLength() {
    return _database.length;
  }

  // List<CrystalPart> getMoney() {
  //   return _moneyParts;
  // }

  // List<CrystalPart> getWeapon() {
  //   return _weaponParts;
  // }
}
