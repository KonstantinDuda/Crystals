import 'dart:async';

import 'package:crystal/data/crystal.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../bloc/suply_bloc.dart';
import '../../bloc/event_state/suply_es.dart';
import '../../bloc/provider_flame.dart';
import 'crystal_cell.dart';

class TwoPl extends PositionComponent
    with
        HasGameReference<MyFlameProvider>,
        FlameBlocListenable<SuplyBloc, SuplyState> {
  List<List<CrystalPart>> suply = [];
  final List<CrystalCell> _cells = [];

  @override
  FutureOr<void> onLoad() {
    _initCells();
  }

  void _initCells() {
    final List<int> rows = [2, 1, 2, 1, 2];
    for (int i = 0; i < rows.length; i++) {
      for (int j = 0; j < rows[i]; j++) {
        final cell = CrystalCell(
          size: Vector2.zero(),
          part: CrystalPart.empty(),
        );
        add(cell);
        _cells.add(cell);
      }
    }
    _layoutCells();
  }

  void _layoutCells() {
    final double padding = 20.0;

    final double cellWidth = (game.size.x - (padding * 3)) / 9;
    final double cellHeight = (game.size.y - (padding * 4)) / 6;

    final List<int> rows = [2, 1, 2, 1, 2];
    int cellIndex = 0;
    double yOffset = 30.0;

    for (int i = 0; i < rows.length; i++) {
      int cellsInRow = rows[i];
      double rowWidth = (cellWidth * cellsInRow) + (padding * (cellsInRow - 1));
      double startX = (game.size.x - rowWidth) / 2;

      for (int j = 0; j < rows[i]; j++) {
        final cell = _cells[cellIndex];
        cell.size = Vector2(cellWidth, cellHeight);
        cell.position = Vector2(startX + j * (cellWidth + padding), yOffset);
        cellIndex++;
      }
      yOffset += cellHeight + padding;
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    if (_cells.isNotEmpty) {
      _layoutCells();
    }
  }

  @override
  void onMount() {
    super.onMount();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isMounted) {
        final initialState = bloc.state;
        bloc.add(SuplyInitialEvent());
        print("TwoPl onMount. initialState == $initialState");
      }
    });
  }

  @override
  void onNewState(SuplyState state) {
    //super.onNewState(state);
    if (state is SuplyUpdatedState) {
      suply = state.updatedSuply;
      print("TwoPl onNewState: $suply ");
      for (int i = 0; i < suply.length; i++) {
        _cells[i].updatePart(suply[i][0]);
      }
    }
    print("TwoPl new state");
  }

  @override
  void render(Canvas canvas) {
    //super.render(canvas);

    final bgPaint = Paint()..color = const Color.fromARGB(255, 15, 15, 20);
    final bgStartX = game.size.x / 3;
    canvas.drawRect(Rect.fromLTWH(bgStartX, 0, bgStartX, game.size.y), bgPaint);
  }
}
