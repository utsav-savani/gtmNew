import 'package:flutter/material.dart';
import 'package:gtm/theme/app_colors.dart';

enum ServiceStatus { newService, inProgress, confirmed, cancelled }

class DrawDottedHorizontalLine extends CustomPainter {
  late Paint _paint;

  DrawDottedHorizontalLine() {
    _paint = Paint();
    _paint.color = AppColors.greyishBrown; //dots color
    _paint.strokeWidth = 1; //dots thickness
    _paint.strokeCap = StrokeCap.round; //dots corner edges
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -300; i < 300; i = i + 15) {
      // 15 is space between dots
      if (i % 3 == 0) {
        canvas.drawLine(Offset(i, 0.0), Offset(i + 10, 0.0), _paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

enum NodeType { category, service }

class NodeDetails {
  int id;
  NodeType type;
  bool? isSelected;

  NodeDetails({required this.id, required this.type, required this.isSelected});
}
