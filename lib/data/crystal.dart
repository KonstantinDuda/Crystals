// Part of Crystal data model
enum PartType {money, weapon}
enum PartSide {left, center, right}

class CrystalPart{
  int id;
  String name;
  String description;
  int price;
  PartType type;
  PartSide side;
  int value;

  CrystalPart({
    required this.id, 
    required this.name, 
    required this.description, 
    required this.price,
    required this.type,
    required this.side,
    required this.value,
});

  CrystalPart.empty({
    this.id = 0, 
    this.name = "", 
    this.description = "", 
    this.price = 0,
    this.type = PartType.money,
    this.side = PartSide.center,
    this.value = 0,
  });
}

// class WeaponPart extends CrystalPart {
//   WeaponPart( int value,
//     ) : super(1, "Weapon Part", "A part of a weapon crystal", PartType.weapon, value);

//   WeaponPart.empty(
//      int value,
//     ) : super(0, "", "", PartType.weapon, 0);
// }

// class MoneyPart extends CrystalPart {
//   MoneyPart( int value,
//     ) : super(1, "Money Part", "A part of a money crystal", PartType.money, value);

//   MoneyPart.empty(
//      int value,
//     ) : super(0, "", "", PartType.money, 0);
// }

// Crystal data model
class Crystal {
  int id;
  CrystalPart leftPart;
  CrystalPart centerPart;
  CrystalPart rightPart;
  String description = "";
  PartType type = PartType.money;
  List<int> damage = [];
  int money = 0;

  Crystal({
    required this.id,
    required this.leftPart,
    required this.centerPart,
    required this.rightPart,
  }) {
    if(leftPart.type == PartType.weapon || 
      centerPart.type == PartType.weapon || 
      rightPart.type == PartType.weapon) {
      type = PartType.weapon; 
    } else {
      type = PartType.money;
    }

    if(type == PartType.weapon) {
      String weaponPart = "";
      if(leftPart.type == PartType.weapon) {
        weaponPart = leftPart.description;
      } 
      if(centerPart.type == PartType.weapon) {
        weaponPart = centerPart.description;
      } 
      if(rightPart.type == PartType.weapon) {
        weaponPart = rightPart.description;
      }
      description = weaponPart;
    } else {
      description = "${leftPart.description}\n${centerPart.description}\n${rightPart.description}";
    }
  }

  void activate(Player player) {
    List<CrystalPart> weaponParts = [leftPart, centerPart, rightPart]
        .where((p) => p.type == PartType.weapon)
        .toList();
/*
    // 1. Логіка зброї
    if (weaponParts.length == 1) {
      // Наносить 1 урон самостійно
      player.dealDamage(weaponParts[0].value, target: null); 
    } else if (weaponParts.length >= 2) {
      // Або наносить 2 урона, або розділяє
      player.dealDamage(2, target: null); 
    }

    // 2. Логіка грошей (якщо третя частина - гроші)
    if (right.type == PartType.money) {
      player.bank += right.value;
    }*/
  }

}

// Player data model (заглушка для демонстрації)
class Player {
  int health;
  int money;
  List<Crystal> crystals;
  
  Player({
    required this.health,
    required this.money,
    required this.crystals,
  }); 
}