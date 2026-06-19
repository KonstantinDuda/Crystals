import 'dart:async';

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
        // final cell =
        //   CrystalCell(size: Vector2(cellWidth, cellHeight), part: CrystalPart.empty())
        //     ..position = Vector2(startX + j * (cellWidth + padding), yOffset);
        // add(cell);
        // _cells.add(cell);
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

    //removeAll(children);

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
      //removeAll(children);
      suply = state.updatedSuply;
      print("TwoPl onNewState: $suply ");
      for (int i = 0; i < suply.length; i++) {
        // add(CrystalCell(
        //   size: Vector2(100, 120),
        //   part: suply[i],
        // ));
        _cells[i].updatePart(suply[i]);
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

class CrystalCell extends PositionComponent {
  final int horizontalSlots = 3;
  CrystalPart part;

  CrystalCell({required Vector2 size, required this.part}) : super(size: size);

  // Функція для малювання фігур. Можна буде використати для кристалів гравців
  void drawShape(Canvas canvas, PartType type, Rect slotRect) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    switch (type) {
      case PartType.weapon:
        paint.color = Colors.red;
        // Малюємо трикутник
        final path = Path()
          ..moveTo(slotRect.center.dx, slotRect.top + 5)
          ..lineTo(slotRect.right - 5, slotRect.bottom - 5)
          ..lineTo(slotRect.left + 5, slotRect.bottom - 5)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case PartType.money:
        paint.color = Colors.green;
        // Малюємо ромб
        canvas.drawPath(
          Path()..addPolygon([
            Offset(slotRect.center.dx, slotRect.top + 5),
            Offset(slotRect.right - 5, slotRect.center.dy),
            Offset(slotRect.center.dx, slotRect.bottom - 5),
            Offset(slotRect.left + 5, slotRect.center.dy),
          ], true),
          paint,
        );
        break;
      case PartType.modifier:
        paint.color = Colors.yellow;
        canvas.drawCircle(slotRect.center, slotRect.width / 4, paint);
        break;
    }
  }

  void updatePart(CrystalPart newPart) {
    part = newPart;
  }

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

    // 1. Малюємо ціну (TextPainter для тексту)
    final textSpan = TextSpan(
      text: part.price.toString(),
      style: const TextStyle(color: Colors.white, fontSize: 12),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(5, 5));

    // 2. Визначаємо, в яких слотах малювати (0, 1, 2)
    List<int> targetSlots = [];
    if (part.side == PartSide.left)
      targetSlots = [0];
    else if (part.side == PartSide.center)
      targetSlots = [1];
    else if (part.side == PartSide.right)
      targetSlots = [2];
    else if (part.side == PartSide.all)
      targetSlots = [0, 1, 2];

    // 3. Малюємо фігуру у відповідному слоті
    final slotHeight = size.y * 0.7;
    final startY = size.y * 0.3;

    for (int slot in targetSlots) {
      final rect = Rect.fromLTWH(
        slot * slotWidth + 5,
        startY + 5,
        slotWidth - 10,
        slotHeight - 10,
      );
      drawShape(canvas, part.type, rect);
    }
  }
}
