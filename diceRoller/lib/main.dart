import 'package:first_app/gradient_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
     MaterialApp(
      home: Scaffold(
        body: GradientContainer(
         color1: Color.fromARGB(255, 5, 53, 109),
         color2: Color.fromARGB(255, 168, 208, 255),
            ),
      ),
    ),
  );
}

