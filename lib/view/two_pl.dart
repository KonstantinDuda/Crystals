/*Гра полягає в тому що кожена сторона (незалежно чи це гравець
 та Ші чи два гравці) мають набір з 20 кристалів, 16 кристалів 
 типу гроші і 4 типу зброя. Кожен кристал можна розвинути до 2 
 разів. Посередині магазин з якого можна купувати покращення для 
 кристалів. На один крок гравцю видається стек з 4 грошових і 1 
 кристала зброї. Незалежно від того гравець це чи Ші набори 
 стандартні і процес кроку стандартизований. 
Тож мені треба буде створити блок з такою логікою. */

import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

class TwoPl extends PositionComponent {
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
}