import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart' hide OverlayRoute, Route;

import '../data/crystal.dart';
import '../view/menu.dart';
import '../view/two_pl/two_pl.dart';
import 'event_state/suply_es.dart';
import 'suply_bloc.dart';

class MyFlameProvider extends FlameGame {
  late final RouterComponent router;
  //final SuplyBloc suplyBloc;

  @override
  Color backgroundColor() {
    return Color.fromARGB(255, 26, 28, 41);
  }

  @override
  Future<void> onLoad() async {
    router = RouterComponent(
      routes: {
        'menu': OverlayRoute(
          (context, game) => HomeMenu(
            onTwoPlayers: () => router.pushReplacementNamed('twoPlayers'),
            onVsAi: () => router.pushNamed('vsAi'),
          ),
        ),
        'twoPlayers': Route(
          () => FlameBlocProvider<SuplyBloc, SuplyState>(
            create: () => SuplyBloc(),
            children: [TwoPl()],
          ),
        ),
        'vsAi': Route(GameScreen.new),
      },
      initialRoute: 'menu',
    );
    add(router);
  }

  // 1. Метод для показу підказки
void showTooltip(CrystalPart part, int count, Offset position) {
  overlays.addEntry('tooltip', (context, game) {
    return Positioned(
      left: position.dx + 20, // Зсув від мишки
      top: position.dy + 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.black87,
          child: Column(
            children: [
              Text("Кількість: $count", style: TextStyle(color: Colors.white)),
              Text(part.description, style: TextStyle(color: Colors.cyan)),
              //Text(part.description, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  });
  overlays.add('tooltip');
}

  void hideTooltip() {
    overlays.remove('tooltip');
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
