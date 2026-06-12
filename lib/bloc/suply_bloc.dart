import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/crystal.dart';
import '../data/database.dart';
import 'event_state/suply_es.dart';

class SuplyBloc extends Bloc<SuplyEvent, SuplyState> {
  final List<CrystalPart> suply;
  var data = Database();

  SuplyBloc(this.suply) : super(SuplyUpdatedState(suply)) {
    on<SuplyInitialEvent>(_suplyInitial);
    on<SuplyGetCPEvent>(_getCrystalPart);
    on<SuplyPreviewEvent>(_previewCrystalPart);
  }

  _suplyInitial(SuplyInitialEvent event, Emitter<SuplyState> emit) {
    var suply = data.generateSuply();
    emit(SuplyUpdatedState(suply));
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