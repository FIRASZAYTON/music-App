import 'package:flutter/material.dart';

class ContainerShadow extends StatelessWidget {
  final double? hight;
  final double? width;
  final Widget child;
  const ContainerShadow({Key? key, required this.child, this.hight, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: child,
      width: width,
      height: hight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 14,
              offset: Offset(5, 5)),
          BoxShadow(
              color: Colors.white, blurRadius: 15, offset: Offset(-5, -5)),
        ],
      ),
    );
  }
}
