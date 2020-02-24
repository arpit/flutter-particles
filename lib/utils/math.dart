import 'dart:math';

final _random = new Random();

int randRange(int min, int max) => min + _random.nextInt(max - min);