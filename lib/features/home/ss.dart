import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Hello extends StatelessWidget {
  const Hello({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "Go",
      child: Container(
        color: Color(0xFF4CAF50),
        child: Image.asset('assets/images/lion.png'),
      ),
    );
  }
}
