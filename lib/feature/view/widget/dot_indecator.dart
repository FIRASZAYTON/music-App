import 'package:flutter/material.dart';

class DotIndecator extends StatelessWidget {
  bool isSelect;
  DotIndecator({required this.isSelect, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      height: 6,
      width: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelect ? Colors.amber : Colors.red,
      ),
    );
  }
}
