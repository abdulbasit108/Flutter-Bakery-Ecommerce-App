import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key? key,
    required double width,
    required double height,
    required this.icon,
    required this.buttonColor,
    required this.buttonText,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;
  final IconData? icon;
  final Color buttonColor;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 32),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(15),
          ),
          width: _width * 0.15,
          height: _height * 0.066,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          width: _width * 0.16,
          child: Text(
            buttonText.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
