// Part of Crystal data model
enum PartType { money, weapon, modifier }

enum PartSide { left, center, right, all, nowhere }

class CrystalPart {
  final int id;
  final String name;
  final String description;
  final int price;
  final PartType type;
  final PartSide side;
  final int value;

  CrystalPart({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.type,
    required this.side,
    required this.value,
  });

  factory CrystalPart.fromJson(Map<String, dynamic> json) {
    return CrystalPart(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      type: PartType.values.byName(json['type']),
      side: PartSide.values.byName(json['side']),
      value: json['value'],
    );
  }

  const CrystalPart.empty({
    this.id = 0,
    this.name = "",
    this.description = "",
    this.price = 0,
    this.type = PartType.money,
    this.side = PartSide.nowhere,
    this.value = 0,
  });

  @override
  String toString() {
    var result =
        "id: $id, \t price: $price \t side: $side, \t type: $type, value: $value \n";
    return result;
  }
}

// Crystal data model
class Crystal {
  int id;
  CrystalPart leftPart;
  CrystalPart centerPart;
  CrystalPart rightPart;
  String description = "";
  PartType type = PartType.money;
  int damage = 0;
  int money = 0;

  Crystal({
    required this.id,
    required this.leftPart,
    required this.centerPart,
    required this.rightPart,
  }) {
    if (leftPart.type == PartType.weapon ||
        centerPart.type == PartType.weapon ||
        rightPart.type == PartType.weapon) {
      type = PartType.weapon;
    } else {
      type = PartType.money;
    }

    if (type == PartType.weapon) {
      var localDamage = 0;
      if (leftPart.id != 0) {
        localDamage += leftPart.value;
      } //damage.add(leftPart.value);
      if (centerPart.id != 0) {
        localDamage += centerPart.value;
      } //damage.add(centerPart.value);
      if (rightPart.id != 0) {
        localDamage += rightPart.value; //damage.add(rightPart.value);
      }
      damage = localDamage;
    } else {
      var localMoney = 0;
      if (leftPart.id != 0) localMoney += leftPart.value;
      if (centerPart.id != 0) localMoney += centerPart.value;
      if (rightPart.id != 0) localMoney += rightPart.value;
      money = localMoney;
      //description = "${leftPart.description}\n${centerPart.description}\n${rightPart.description}";
    }
  }

  Crystal.empty({
    this.id = 0,
    this.leftPart = const CrystalPart.empty(),
    this.centerPart = const CrystalPart.empty(),
    this.rightPart = const CrystalPart.empty(),
  });

  // void activate(Player player) {
  //   List<CrystalPart> weaponParts = [leftPart, centerPart, rightPart]
  //       .where((p) => p.type == PartType.weapon)
  //       .toList();
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
  //}
}
