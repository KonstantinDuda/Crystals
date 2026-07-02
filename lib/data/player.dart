import 'crystal.dart';

class Player {
  final int id;
  final int health;
  final int money;

  final List<Crystal> hand;
  final List<Crystal> stack;
  final List<Crystal> reset;

  final Tool tool;

  final int energyIn;
  final int energyToUltimate;
  final String ultimate;

  Player({
    required this.id,
    required this.health,
    required this.money,
    required this.hand,
    required this.stack,
    required this.reset,
    required this.tool,
    required this.energyIn,
    required this.energyToUltimate,
    required this.ultimate,
  });

  Player.empty({
    this.id = 0,
    this.health = 0,
    this.money = 0,
    this.hand = const <Crystal>[],
    this.stack = const <Crystal>[],
    this.reset = const <Crystal>[],
    this.tool = const Tool.empty(),
    this.energyIn = 0,
    this.energyToUltimate = 1000,
    this.ultimate = "",
  });
}

class Tool {
  final int id;
  final int health;
  final List<Tripod> tripods;

  Tool({required this.id, required this.health, required this.tripods});

  const Tool.empty({
    this.id = 0,
    this.health = 0,
    this.tripods = const <Tripod>[],
  });
}

// Підставка під зброю
class Tripod {
  final int id;
  final bool isOpen;
  final int energyToOpen;
  final int energyToOnceUse;
  final bool onceUseAvailable;
  //final bool isWeaponEquipped;
  final Crystal weapon;
  final String modifier;

  Tripod({
    required this.id,
    required this.isOpen,
    required this.energyToOpen,
    required this.energyToOnceUse,
    required this.onceUseAvailable,
    //required this.isWeaponEquipped,
    required this.weapon,
    required this.modifier,
  });

  Tripod.empty()
      : id = 0,
        isOpen = false,
        energyToOpen = 1000,
        energyToOnceUse = 1000,
        onceUseAvailable = false,
        weapon = Crystal.empty(),
        modifier = "";
}
