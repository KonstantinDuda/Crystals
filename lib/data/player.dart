// Player data model (заглушка для демонстрації)
import 'crystal.dart';

class Player {
  int id;
  int health;
  int money;

  List<Crystal> hand;
  List<Crystal> stack;
  List<Crystal> reset;

  int toolHealth;
  int toolEnergeCount;
  // TODO: Осередок для зброї, вірогідно варто зробити окремим 
  // класом а сюди додавати список тих об'єктів. В них має бути 
  // бул чи він вже відкритий чи ні, чи в нього влито енергію, ціна 
  // відкриття, ціна фокусування, модифікатор типу додаткового урона...


  int weaponSocetCount;
  String ultimate;

  Player({
    required this.id,
    required this.health,
    required this.money,
    required this.hand,
    required this.stack,
    required this.reset,
    required this.toolHealth,
    required this.toolEnergeCount,
    required this.weaponSocetCount,
    required this.ultimate,
  });

  Player.empty({
    this.id = 0,
    this.health = 0,
    this.money = 0,
    this.hand = const <Crystal>[],
    this.stack = const <Crystal>[],
    this.reset = const <Crystal>[],
    this.toolHealth = 0,
    this.toolEnergeCount = 0,
    this.weaponSocetCount = 0,
    this.ultimate = "",
  });
}
