import 'package:equatable/equatable.dart';

import '../../data/player.dart';

// Events
class PlayerEvent extends Equatable {
  @override
  List<Object?> get props => [];  
}

class PlayerInitialEvent extends PlayerEvent {}

// States
class PlayerState extends Equatable {
  @override
  List<Object?> get props => [];
}

//class PlayerInitialState extends PlayerState {}

class PlayerUpdateState extends PlayerState {
  final Player player;

  PlayerUpdateState(this.player);

  @override
  List<Object?> get props => [player];
}

class PlayerErrorState extends PlayerState {}