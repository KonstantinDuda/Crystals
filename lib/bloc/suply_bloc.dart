import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/crystal.dart';
import '../data/database.dart';
import 'event_state/suply_es.dart';

class SuplyBloc extends Bloc<SuplyEvent, SuplyState> {
  List<List<CrystalPart>> suply = [];
  var data = Database();

  SuplyBloc() : super(SuplyInitialState()) {
    on<SuplyInitialEvent>(_suplyInitial);
    on<SuplyGetCPEvent>(_getCrystalPart);
    on<SuplyPreviewEvent>(_previewCrystalPart);
  }

  void _suplyInitial(SuplyInitialEvent event, Emitter<SuplyState> emit) {
    _generateSuply();
    emit(SuplyUpdatedState(List.from(suply)));
  }

  void _generateSuply() {
    var money = data.moneyParts;
    //print("suply_bloc. _generateSuply: dataLength == $money");
    var moneyPart = money[Random().nextInt(3) + 4];
    suply.add([moneyPart, moneyPart, moneyPart, moneyPart, moneyPart]);
    moneyPart = money[Random().nextInt(5) + 4];
    suply.add([moneyPart, moneyPart, moneyPart, moneyPart, moneyPart]);
    moneyPart = money[Random().nextInt(9) + 4];
    suply.add([moneyPart, moneyPart, moneyPart, moneyPart, moneyPart]);

    var weapon = data.weaponParts;
    //print("suply_bloc. _generateSuply: dataLength == $weapon");
    var weaponPart = weapon[Random().nextInt(3) + 4];
    suply.add([weaponPart, weaponPart, weaponPart, weaponPart, weaponPart]);
    weaponPart = weapon[Random().nextInt(5) + 4];
    suply.add([weaponPart, weaponPart, weaponPart, weaponPart, weaponPart]);
    weaponPart = weapon[Random().nextInt(11) + 4];
    suply.add([weaponPart, weaponPart, weaponPart, weaponPart, weaponPart]);
    //print("SuplyBloc. _generateSuply. suply == $suply");
    //return localSuply;
  }

  void _getCrystalPart(SuplyGetCPEvent event, Emitter<SuplyState> emit) {
    try {
      if (event.index < 0 || event.index >= suply.length) {
        emit(SuplyErrorState("Invalid index: ${event.index}"));
        return;
      }
      var updatedSuply = List<List<CrystalPart>>.from(suply);
      updatedSuply.removeAt(event.index);
      emit(SuplyUpdatedState(updatedSuply));
    } catch (e) {
      emit(SuplyErrorState("Error getting crystal part: $e"));
    }
  }

  void _previewCrystalPart(SuplyPreviewEvent event, Emitter<SuplyState> emit) {
    try {
      if (event.index < 0 || event.index >= suply.length) {
        emit(SuplyErrorState("Invalid index: ${event.index}"));
        return;
      }
      var updatedSuply = List<List<CrystalPart>>.from(suply);
      updatedSuply.removeAt(event.index);
      emit(SuplyUpdatedState(updatedSuply));
    } catch (e) {
      emit(SuplyErrorState("Error previewing crystal part: $e"));
    }
  }
}
