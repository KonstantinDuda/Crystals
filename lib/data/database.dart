import 'crystal.dart';

class Database {
  static final Database _instance = Database._internal();

  factory Database() {
    return _instance;
  }

  Database._internal() {
    _generateDatabase();
  }

  // TODO: Add CRUD operations for crystal parts
  final List<CrystalPart> _database = [];
  final List<CrystalPart> _moneyParts = [];
  final List<CrystalPart> _weaponParts = [];

  void _generateDatabase() {
    int ids = 0;
    for (int i = 0; i < 9; i++) {
      var side = PartSide.left;
      var value = i + 1;
      if (i >= 3 && i < 6) {
        side = PartSide.center;
        value = i - 2;
      } else if (i >= 6) {
        side = PartSide.right;
        value = i - 5;
      }

      _moneyParts.add(
        CrystalPart(
          id: i + 1,
          name: "Left ${i + 1} Money Part",
          description: "Add ${i + 1} money",
          price: (i + 1) * 2,
          type: PartType.money,
          side: side,
          value: value,
        ),
      );
      _weaponParts.add(
        CrystalPart(
          id: i + 1,
          name: "Left ${i + 1} Weapon Part",
          description: "Add ${i + 1} damage",
          price: (i + 1) + 1,
          type: PartType.weapon,
          side: side,
          value: value,
        ),
      );
    }
  }

  void createCrystalPart(String name, String description, int price, PartType type, PartSide side, int value) {
    int localId = _database.isEmpty ? 1 : _database.last.id + 1;
    CrystalPart newCrystal = CrystalPart(id: localId, 
      name: name, description: description, 
      price: price, type: type, 
      side: side, value: value);
      if(newCrystal.type == PartType.money) {
        _moneyParts.add(newCrystal);
      } else if(newCrystal.type == PartType.weapon) {
        _weaponParts.add(newCrystal);
      }
      _database.add(newCrystal);
  }

  CrystalPart getCrystalPart(int id) {
    var result = _database.firstWhere(((element) => element.id == id), orElse: () => CrystalPart.empty());
    return result;
  }

  void updateCrystalPart(int id, CrystalPart newPart) {
    //var oldPart = _database.firstWhere(((element) => element.id == id), orElse: () => CrystalPart.empty());
    //print("_database: updateCrystalPart oldPart == $oldPart");
    
    //if(oldPart.id != 0) {
      //var index = _database.indexOf(oldPart);
var index = getIndex(id);
var oldPart = CrystalPart.empty();

    if(index > -1){
      oldPart = newPart;
      oldPart.id = id;
      
      _database[index] = oldPart;
    }
     print("_database: updateCrystalPart oldPart == $oldPart");
  }

  void deleteCrystalPart(int id) {
    var index = getIndex(id);
    if(index > -1) _database.removeAt(index);
  }

  int getIndex(int id) {
    var part = _database.firstWhere(((element) => element.id == id), orElse: () => CrystalPart.empty());
    var result = _database.indexOf(part);
    return result;
  }
}