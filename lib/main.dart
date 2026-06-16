//import 'package:crystal/data/database.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/provider_flame.dart';
import 'observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  //var data = Database();

  runApp(GameWidget(game: MyFlameProvider())
    // BlocProvider(create: (context) => ProviderBloc(),
    //   child: const MyApp(),
    // ),
    );
}