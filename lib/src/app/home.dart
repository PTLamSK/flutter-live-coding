import 'dart:math';

import 'package:flutter/material.dart';
import 'package:live_coding/src/app/container.dart';
import 'package:live_coding/src/challenge.dart';

final class LiveCodingHome extends StatelessWidget {
  static const _colors = [
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.yellow,
    Colors.pink,
    Colors.cyan,
    Colors.brown,
    Colors.grey,
    Colors.teal,
    Colors.indigo,
    Colors.lime,
    Colors.amber,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.blueGrey,
    Colors.black,
  ];

  const LiveCodingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiveCodingTest(
        children: generateRandomLiveCodingContainers(5000).toList()..shuffle(),
      ),
    );
  }

  Iterable<LiveCodingContainer> generateRandomLiveCodingContainers(int n) sync* {
    final random = Random();

    for (int i = 0; i < n; i++) {
      final dimension = 50 + random.nextInt(800);
      final color = _colors[random.nextInt(_colors.length)];

      yield LiveCodingContainer(
        dimension: dimension.toDouble(),
        color: color,
      );
    }
  }
}
