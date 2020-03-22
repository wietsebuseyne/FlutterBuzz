import 'package:flutter/cupertino.dart';

class VerticalPadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height*0.02,);
  }

}