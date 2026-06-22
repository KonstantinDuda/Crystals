import 'package:crystal/data/crystal.dart';
import 'package:equatable/equatable.dart';

// Events
class SuplyEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SuplyInitialEvent extends SuplyEvent {}

class SuplyGetCPEvent extends SuplyEvent {
  final int index;

  SuplyGetCPEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class SuplyPreviewEvent extends SuplyEvent {
  final int index;

  SuplyPreviewEvent(this.index);

  @override
  List<Object?> get props => [index];
}

// States
class SuplyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SuplyInitialState extends SuplyState {}

class SuplyUpdatedState extends SuplyState {
  final List<List<CrystalPart>> updatedSuply;

  SuplyUpdatedState(this.updatedSuply);

  @override
  List<Object?> get props => [updatedSuply];
}

class SuplyErrorState extends SuplyState {
  final String message;

  SuplyErrorState(this.message);

  @override
  List<Object?> get props => [message];
}