import 'package:flutter/material.dart';
import 'dart:math' as Math;

///
/// Created by Auro on 25/06/24
///

class AppProgress extends StatefulWidget {
  final Color? color;
  final double? strokeWidth;
  final Size? size;

  const AppProgress(
      {super.key,
      this.strokeWidth,
      this.color,
      this.size = const Size(50, 50)});

  @override
  _AppProgressState createState() => _AppProgressState();
}

class _AppProgressState extends State<AppProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.size,
      child: AspectRatio(
        aspectRatio: 1,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (ctx, child) => CustomPaint(
            foregroundPainter: _CircleProgressBarPainter(
                color: widget.color ?? Theme.of(context).primaryColor,
                percentage: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(CurvedAnimation(
                        curve: Curves.fastOutSlowIn, parent: _controller))
                    .value,
                strokeWidth: widget.strokeWidth),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class _CircleProgressBarPainter extends CustomPainter {
  final double? percentage;
  final double strokeWidth;
  final Color? color;

  _CircleProgressBarPainter({
    @required this.color,
    @required this.percentage,
    double? strokeWidth,
  }) : strokeWidth = strokeWidth ?? 6;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);

    final shortestSide = Math.min(size.width, size.height);
    final foregroundPaint = Paint()
      ..color = color!
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final radius = (shortestSide / 2) - ((strokeWidth) / 2).ceil();

    final double startAngle = 2 * Math.pi * (percentage ?? 0);

    final count = 8;
    final gapSize = 20;
    final double gap = Math.pi / 180 * gapSize;
    final double singleAngle = (Math.pi * 2) / count;

    final Paint paint = Paint()
      ..color = color!
      ..strokeWidth = strokeWidth - 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < count; i++) {
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          gap + singleAngle * i, singleAngle - gap * 2, false, paint);
    }
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      singleAngle - gap * 5,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as _CircleProgressBarPainter);
    return oldPainter.percentage != percentage;
  }
}
