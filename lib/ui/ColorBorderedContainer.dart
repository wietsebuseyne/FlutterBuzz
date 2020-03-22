import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorBorderedContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double height;
  final double width;

  const ColorBorderedContainer({@required this.child, @required this.color, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: new BoxDecoration(
            border: Border.all(color: color, width: 5.0),
            borderRadius: new BorderRadius.circular(20.0),
            boxShadow: [
              new BoxShadow(
                  color: Colors.white,
                  blurRadius: 2,
                  offset: new Offset(-0.3, -0.3))
            ],
            color: Colors.black),
        child: child);
  }
}
