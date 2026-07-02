import 'dart:convert';
//import 'dart:math';

import 'package:flutter/services.dart';

import 'crystal.dart';

class Database {
  static final Database _instance = Database._internal();

  factory Database() {
    return _instance;
  }

  Database._internal() {
    //crystalPartLoadData();
  }

  // Crystal parts data
  final List<CrystalPart> _crystalParts = [];
  List<CrystalPart> _moneyParts = [];
  List<CrystalPart> _weaponParts = [];

  Future<void> crystalPartLoadData() async {
    // Читаємо файл з папки assets
    final String response = await rootBundle.loadString(
      'lib/assets/crystal_parts.json',
    );
    final data = await json.decode(response);

    // Парсимо списки з JSON
    _moneyParts = (data['money_parts'] as List)
        .map((item) => CrystalPart.fromJson(item))
        .toList();

    _weaponParts = (data['weapon_parts'] as List)
        .map((item) => CrystalPart.fromJson(item))
        .toList();

    _crystalParts.addAll(_moneyParts);
    _crystalParts.addAll(_weaponParts);
    print(
      "Database. crystalPartLoadData: _crystalParts == ${_crystalParts.length}",
    );
  }

  // CRUD operations for CrystalPart
  List<CrystalPart> get moneyParts => _moneyParts;
  List<CrystalPart> get weaponParts => _weaponParts;
  List<CrystalPart> get crystalParts => _crystalParts;

  CrystalPart getCrystalPart(int id) {
    if (id > 0) {
      var result = _crystalParts.firstWhere(
        ((element) => element.id == id),
        orElse: () => CrystalPart.empty(),
      );
      return result;
    } else {
      return CrystalPart.empty();
    }
  }

  void updateCrystalPart(int id, CrystalPart newPart) {
    var index = _getCrystalPartIndex(id);
    //var oldPart = CrystalPart.empty();

    if (index > -1) {
      var oldPart = CrystalPart(
        id: id,
        name: newPart.name,
        description: newPart.description,
        price: newPart.price,
        type: newPart.type,
        side: newPart.side,
        value: newPart.value,
      );
      //oldPart.id = id;

      _crystalParts[index] = oldPart;
      print("_crystalParts: updateCrystalPart oldPart == $oldPart");
    }
  }

  void deleteCrystalPart(int id) {
    var index = _getCrystalPartIndex(id);
    if (index > -1) _crystalParts.removeAt(index);
  }

  int _getCrystalPartIndex(int id) {
    var part = _crystalParts.firstWhere(
      ((element) => element.id == id),
      orElse: () => CrystalPart.empty(),
    );
    var result = _crystalParts.indexOf(part);
    return result;
  }

  int getDataLength() {
    return _crystalParts.length;
  }

  // Crystal data
  final List<Crystal> _crystals = [];

  List<Crystal> get crystals => _crystals;

  void crystalLoadData() {
    var crystalWeaponLeft = Crystal(
      id: 1,
      leftPart: getCrystalPart(4),
      centerPart: CrystalPart.empty(),
      rightPart: CrystalPart.empty(),
    );
    var crystalMoneyLeft = Crystal(
      id: 2,
      leftPart: getCrystalPart(1),
      centerPart: CrystalPart.empty(),
      rightPart: CrystalPart.empty(),
    );

    var crystalMoneyCenter = Crystal(
      id: 3,
      leftPart: CrystalPart.empty(),
      centerPart: getCrystalPart(2),
      rightPart: CrystalPart.empty(),
    );

    var crystalMoneyRight = Crystal(
      id: 4,
      leftPart: CrystalPart.empty(),
      centerPart: CrystalPart.empty(),
      rightPart: getCrystalPart(3),
    );

    var crystalWeaponRight = Crystal(
      id: 5,
      leftPart: CrystalPart.empty(),
      centerPart: CrystalPart.empty(),
      rightPart: getCrystalPart(6),
    );
    _crystals.addAll([
      crystalWeaponLeft,
      crystalMoneyLeft,
      crystalMoneyCenter,
      crystalMoneyRight,
      crystalWeaponRight,
    ]);
  }

  // CRUD operations for Crystal
  void createCrystal(Crystal crystal) {
    var newCrystal = Crystal.empty();
    var biggestId = 0;

    for (var element in _crystals) {
      if (element.id > biggestId) {
        biggestId = element.id;
      }
    }
    newCrystal = Crystal(
      id: biggestId + 1,
      leftPart: crystal.leftPart,
      centerPart: crystal.centerPart,
      rightPart: crystal.rightPart,
    );

    _crystals.add(newCrystal);
  }

  Crystal getCrystal(int id) {
    var result = _crystals.firstWhere(
      ((element) => element.id == id),
      orElse: () => Crystal.empty(),
    );
    return result;
  }

  void updateCrystal(int id, Crystal newCrystal) {
    var index = _getCrystalIndex(id);
    if (index > -1) {
      var oldCrystal = Crystal(
        id: id,
        leftPart: newCrystal.leftPart,
        centerPart: newCrystal.centerPart,
        rightPart: newCrystal.rightPart,
      );
      _crystals[index] = oldCrystal;
    }
  }

  void deleteCrystal(int id) {
    var index = _getCrystalIndex(id);
    if (index > -1) _crystals.removeAt(index);
  }

  int _getCrystalIndex(int id) {
    var part = _crystals.firstWhere(
      ((element) => element.id == id),
      orElse: () => Crystal.empty(),
    );
    var result = _crystals.indexOf(part);
    return result;
  }
}
