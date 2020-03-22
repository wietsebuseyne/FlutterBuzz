import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {

  final int seconds;

  CountdownWidget(this.seconds);

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();

}

class _CountdownWidgetState extends State<CountdownWidget> with TickerProviderStateMixin {

  AnimationController controller;

  _CountdownWidgetState();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.seconds),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void start() {
    controller.reverse(
        from: controller.value == 0.0 ? 1.0 : controller.value);
  }

  void stop() {
    controller.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 28, 39, 63),
      height: 150,
      width: 150,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: AnimatedBuilder(
          animation: controller,
          builder:
              (BuildContext context, Widget child) {
            return CustomPaint(
                painter: CustomTimerPainter(
                  animation: controller,
                  backgroundColor: Colors.transparent,
                  color: Colors.white,
                ));
          },
        ),
      ),
    );
  }

}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}