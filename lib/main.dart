//import 'package:crystal/data/database.dart';
import 'package:crystal/bloc/suply_bloc.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/event_state/suply_es.dart';
import 'bloc/provider_flame.dart';
import 'data/database.dart';
import 'observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  var data = Database();
  data.loadData;

  runApp(//GameWidget(game: MyFlameProvider())
    BlocProvider(create: (_) => SuplyBloc()..add(SuplyInitialEvent()),
       child: GameWidget(game: MyFlameProvider()),
    ),
    );
}