import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../../bloc/provider_flame.dart';
import '../../data/crystal.dart';

class CrystalCell extends PositionComponent with HoverCallbacks {
  final int horizontalSlots = 3;
  CrystalPart part;
  int count;
  bool isHovered = false;

  CrystalCell({required Vector2 size, required this.part, this.count = 0})
    : super(size: size);

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

  void updatePart(CrystalPart newPart, int partCount) {
    part = newPart;
    count = partCount;
  }

  @override
  void onHoverEnter() {
    //super.onHoverEnter();
    isHovered = true;
    // Можна додати візуальний ефект: трохи збільшити розмір
    scale = Vector2.all(1.05);
    final globalOffset = Offset(absolutePosition.x, absolutePosition.y);
    (findGame() as MyFlameProvider).showTooltip(part, count, globalOffset);
  }

  @override
  void onHoverExit() {
    //super.onHoverExit();
    isHovered = false;
    scale = Vector2.all(1.0);
    (findGame() as MyFlameProvider).hideTooltip();
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

    // 1. Адаптивний розмір шрифту: наприклад, 20% від висоти верхньої секції
    final double responsiveFontSize = priceSectionHeight * 0.45;

    final textSpan = TextSpan(
      text: part.price.toString(),
      style: TextStyle(
        color: Colors.white,
        fontSize: responsiveFontSize,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();

    // 2. Центрування: (ширина комірки - ширина тексту) / 2
    final double centerX = (size.x - textPainter.width) / 2;
    // Центрування по вертикалі в межах верхніх 30%
    final double centerY = (priceSectionHeight - textPainter.height) / 2;
    textPainter.paint(canvas, Offset(centerX, centerY));

    // 2. Визначаємо, в яких слотах малювати (0, 1, 2)
    List<int> targetSlots = [];
    if (part.side == PartSide.left) {
      targetSlots = [0];
    } else if (part.side == PartSide.center) {
      targetSlots = [1];
    } else if (part.side == PartSide.right) {
      targetSlots = [2];
    } else if (part.side == PartSide.all) {
      targetSlots = [0, 1, 2];
    }

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

    // Якщо наведено, малюємо рамку іншого кольору
    if (isHovered) {
      final paint = Paint()
        ..color = Colors.white.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill;
      canvas.drawRect(size.toRect(), paint);

      // Відображення "кількості" у куточку, якщо це стопка (stack)
      if (count > 0) _drawCounter(canvas);
    }
  }

  void _drawCounter(Canvas canvas) {
    // Стиль тексту для лічильника
    final textSpan = TextSpan(
      text: "x$count",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.black54, // Щоб текст було видно на будь-якому фоні
      ),
    );
    
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();

    // Малюємо в правому нижньому куті комірки
    final offset = Offset(
      size.x - textPainter.width - 5,
      size.y - textPainter.height - 5,
    );
    
    textPainter.paint(canvas, offset);
  }
}
