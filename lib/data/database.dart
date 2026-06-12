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

  final List<CrystalPart> _crystalParts = [];
  final List<CrystalPart> _weaponParts = [];

  void _generateDatabase() {
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

      _crystalParts.add(
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

  List<CrystalPart> generateSuply() {
    List<CrystalPart> suply = [];

    suply.addAll(_crystalParts);
    suply.addAll(_weaponParts);
    print("Suply initialized with ${suply.length} crystals");
  
    return suply;
  }
}