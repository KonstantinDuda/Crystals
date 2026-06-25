import 'package:crystal/data/crystal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/database.dart';
import '../data/player.dart';
import 'event_state/player_es.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  var player = Player.empty();
  var data = Database();

  PlayerBloc() : super(PlayerUpdateState(Player.empty())) {
    on<PlayerInitialEvent>(_playerInitial);
  }

  _playerInitial(PlayerInitialEvent event, Emitter<PlayerState> emit) {
    List<Crystal> localHand = [];
    List<Crystal> localStack = [];
    Tripod tripodOne;
    //tripodOne.getTripod(1);
    Tool localTool = Tool.empty();

    player = Player(
      id: 1, 
      health: 30, 
      money: 0, 
      hand: localHand, 
      stack: localStack, 
      reset: [], 
      tool: localTool, 
      energyIn: 0,
      energyToUltimate: 9,
      ultimate: "Heal 3 health");
    
    emit(PlayerUpdateState(player));
  }
}