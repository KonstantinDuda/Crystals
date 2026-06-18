import 'dart:ui';

import 'package:crystal/data/crystal.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
//import 'package:flame/events.dart';

import '../bloc/suply_bloc.dart';
import '../bloc/event_state/suply_es.dart';
import '../bloc/provider_flame.dart';

class TwoPl extends PositionComponent
    with
        HasGameReference<MyFlameProvider>,
        FlameBlocListenable<SuplyBloc, SuplyState> {
  List<CrystalPart> suply = [];

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    removeAll(children);

    _layoutCells();
  }

  void _layoutCells() {
    final double padding = 20.0;
    //  final int cellCount = 8;

    final double cellWidth = (game.size.x - (padding * 3)) / 9;
    final double cellHeight = (game.size.y - (padding * 4)) / 6;

    final List<int> rows = [2, 1, 2, 1, 2];

    double yOffset = 30.0;

    for (int i = 0; i < rows.length; i++) {
      int cellsInRow = rows[i];
      double rowWidth = (cellWidth * cellsInRow) + (padding * (cellsInRow - 1));
      double startX = (game.size.x - rowWidth) / 2;

      for (int j = 0; j < rows[i]; j++) {
        add(
          CrystalCell(size: Vector2(cellWidth, cellHeight))
            ..position = Vector2(startX + j * (cellWidth + padding), yOffset),
        );
      }
      yOffset += cellHeight + padding;
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
    super.onNewState(state);
    if(state is SuplyUpdatedState) {
      suply = state.updatedSuply;
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

class CrystalCell extends PositionComponent {
  final int horizontalSlots = 3;

  CrystalCell({required Vector2 size}) : super(size: size);

  @override
  void render(Canvas canvas) {
    //super.render(canvas);
    final borderPaint = Paint()
      ..color = const Color.fromARGB(255, 100, 100, 120)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // 1. Рамка всієї комірки
    canvas.drawRect(size.toRect(), borderPaint);

    // 2. Горизонтальний роздільник між ціною та слотами (на 30% висоти)
    final double priceSectionHeight = size.y * 0.3;
    canvas.drawLine(
      Offset(0, priceSectionHeight),
      Offset(size.x, priceSectionHeight),
      borderPaint,
    );

    // 3. Рисочки для розділення 3-х слотів
    // Нижня ділянка починається від 30% до 100%
    final double slotsSectionHeight = size.y - priceSectionHeight;
    final double lineVerticalSize =
        slotsSectionHeight * 0.3; // Рисочка = 30% від висоти слотів

    // Початок Y для рисочок (середина нижньої ділянки)
    final double lineStartY =
        priceSectionHeight + (slotsSectionHeight - lineVerticalSize) / 2;

    // Малюємо дві рисочки на 1/3 та 2/3 ширини комірки
    final double slotWidth = size.x / 3;

    canvas.drawLine(
      Offset(slotWidth, lineStartY),
      Offset(slotWidth, lineStartY + lineVerticalSize),
      borderPaint..strokeWidth = 1.5,
    );

    canvas.drawLine(
      Offset(slotWidth * 2, lineStartY),
      Offset(slotWidth * 2, lineStartY + lineVerticalSize),
      borderPaint..strokeWidth = 1.5,
    );
  }
}

/*class TwoPl extends PositionComponent {
  static const int gridSize = 3;
  static const double cellSize = 100.0;
  static const double spacing = 10.0;

  static const double totalSize = (gridSize * cellSize) + ((gridSize + 1) * spacing);

  TwoPl() : super(size: Vector2.all(totalSize), anchor: Anchor.center);

@override
  void onMount() {
    super.onMount();
    position = findGame()!.size / 2; // Центруємо компонент на екрані
  }

  @override
  void render(Canvas canvas) {
    //super.render(canvas);
  
    final paint = Paint()..color = const Color.fromARGB(255, 30, 30, 40);
  canvas.drawRect(size.toRect(), paint);

  final borderPaint = Paint()
    ..color = const Color.fromARGB(255, 80, 80, 100)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  canvas.drawRect(size.toRect(), borderPaint);
  }

  @override
  FutureOr<void> onLoad() {
    for(int i = 0; i < gridSize; i++) {
      for(int j = 0; j < gridSize; j++) {
        add(Crystal(position: Vector2(
          spacing + j * (cellSize + spacing),
          spacing + i * (cellSize + spacing),
        )));
      }
    }
  }
}

class Crystal extends PositionComponent with HoverCallbacks{
  bool isHover = false;
  
  Crystal({required Vector2 position}) : super(size: Vector2.all(TwoPl.cellSize), position: position);

@override
  void onHoverEnter() => isHover = true;

  @override
  void onHoverExit() => isHover = false;

  @override
  void render(Canvas canvas) {
    //super.render(canvas);

    final paint = Paint()
      ..color = isHover 
      ? const Color.fromARGB(255, 100, 200, 255)
      : const Color.fromARGB(255, 50, 50, 70);

    canvas.drawRRect(RRect.fromRectAndRadius(size.toRect(), const Radius.circular(8)), paint);
  }
}*/
