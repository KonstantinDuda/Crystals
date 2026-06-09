import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide OverlayRoute, Route;

import '../view/menu.dart';
import '../view/two_pl.dart';

class MyFlameProvider extends FlameGame {
  late final RouterComponent router;

@override
  Color backgroundColor() {
    return Color.fromARGB(255, 26, 28, 41);
  }

  @override
  Future<void> onLoad() async {
    router = RouterComponent(
      routes: {
        'menu': OverlayRoute((context, game) => HomeMenu(
    onTwoPlayers: () => router.pushReplacementNamed('twoPlayers'),
    onVsAi: () => router.pushNamed('vsAi'),
  ),), 
        'twoPlayers': Route(() => TwoPl()),
        'vsAi': Route(GameScreen.new),
      },
      initialRoute: 'menu',
    );
    add(router);
  }
}

// Widget _gameBuilder(RouterComponent router, Route route) {
//   return GameWidget(
//     game: FlameGame()..add(
//       TwoPl()..position = Vector2(0, 0), // Центрується автоматично через Anchor.center
//     ),
//   );
// }

class GameScreen extends Component {
  @override
  Future<void> onLoad() async {
    // Завантаження ресурсів та ініціалізація гри
  }

  @override
  void update(double dt) {
    // Логіка оновлення гри
  }

  @override
  void render(Canvas canvas) {
    // Логіка рендерингу гри
  }
}