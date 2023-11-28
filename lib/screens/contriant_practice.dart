import 'package:flutter/material.dart';

class ConstriantPractice extends StatelessWidget {
  const ConstriantPractice({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          color: Colors.red,
        ),
        Container(
          height: 150,
          color: Colors.blue,
        ),
        Container(
          height: 120,
          color: Colors.green,
        ),
      ],
    );
  }
}
