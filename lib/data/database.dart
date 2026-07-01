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
    loadData();
  }

  final List<CrystalPart> _database = [];
  List<CrystalPart> _moneyParts = [];
  List<CrystalPart> _weaponParts = [];

  Future<void> loadData() async {
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

    _database.addAll(_moneyParts);
    _database.addAll(_weaponParts);
  }

  List<CrystalPart> get moneyParts => _moneyParts;
  List<CrystalPart> get weaponParts => _weaponParts;
  List<CrystalPart> get database => _database;

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
}
