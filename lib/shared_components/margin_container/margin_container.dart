import 'package:flutter/material.dart';

class MarginContainer extends StatelessWidget {
  const MarginContainer({
    Key? key,
    required this.children,
    required this.columnAlignment,
  }) : super(key: key);

  final List<Widget> children;
  final CrossAxisAlignment columnAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      margin: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: columnAlignment,
        children: children,
      ),
    );
  }
}
