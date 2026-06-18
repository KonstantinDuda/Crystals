import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/crystal.dart';
import '../data/database.dart';
import 'event_state/suply_es.dart';

class SuplyBloc extends Bloc<SuplyEvent, SuplyState> {
  List<CrystalPart> suply = [];
  var data = Database();

  SuplyBloc() : super(SuplyInitialState()) {
    on<SuplyInitialEvent>(_suplyInitial);
    on<SuplyGetCPEvent>(_getCrystalPart);
    on<SuplyPreviewEvent>(_previewCrystalPart);
  }

  _suplyInitial(SuplyInitialEvent event, Emitter<SuplyState> emit) {
    _generateSuply();
    emit(SuplyUpdatedState(List.from(suply)));
  }

  /*List<CrystalPart>*/void _generateSuply() {
    //List<CrystalPart> localSuply = [];
    //var dataLength = data.getDataLength();
    //print("suply_bloc. _generateSuply: dataLength == $dataLength");

    var money = data.getMoney();
    //print("suply_bloc. _generateSuply: dataLength == $money");
    suply.add(money[Random().nextInt(3)]);
    suply.add(money[Random().nextInt(3) + 2]);
    suply.add(money[Random().nextInt(3) + 4]);

    var weapon = data.getWeapon();
    //print("suply_bloc. _generateSuply: dataLength == $weapon");
    suply.add(weapon[Random().nextInt(3)]);
    suply.add(weapon[Random().nextInt(3) + 2]);
    suply.add(weapon[Random().nextInt(3) + 4]);
    //print("SuplyBloc. _generateSuply. suply == $suply");
    //return localSuply;
  }

  _getCrystalPart(SuplyGetCPEvent event, Emitter<SuplyState> emit) {
    try {
      if (event.index < 0 || event.index >= suply.length) {
        emit(SuplyErrorState("Invalid index: ${event.index}"));
        return;
      }
      var updatedSuply = List<CrystalPart>.from(suply);
      updatedSuply.removeAt(event.index);
      emit(SuplyUpdatedState(updatedSuply));
    } catch (e) {
      emit(SuplyErrorState("Error getting crystal part: $e"));
    }
  }

  _previewCrystalPart(SuplyPreviewEvent event, Emitter<SuplyState> emit) {
    try {
      if (event.index < 0 || event.index >= suply.length) {
        emit(SuplyErrorState("Invalid index: ${event.index}"));
        return;
      }
      var updatedSuply = List<CrystalPart>.from(suply);
      updatedSuply.removeAt(event.index);
      emit(SuplyUpdatedState(updatedSuply));
    } catch (e) {
      emit(SuplyErrorState("Error previewing crystal part: $e"));
    }
  }
}