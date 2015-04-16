part of util;

randomBool() => new Random().nextBool();

randomRareTrue() {
  int sign = randomSign(10);
  if (sign == -1) return true;
  else return false;
}

// nextInt(max): range from 0, inclusive, to max, exclusive.
randomInt(int max) => new Random().nextInt(max);

int randomRangeInt(int min, int max) {
  int random = new Random().nextInt(max);
  if (random < min) {
    random = min;
  }
  return random;
}

// nextDouble(): range from 0.0, inclusive, to 1.0, exclusive.
double randomDouble(double max) {
  return new Random().nextDouble() * max;
}

num randomNum(num max) {
  return new Random().nextDouble() * max;
}

num randomRangeNum(num min, num max) {
  num random = new Random().nextDouble() * max;
  if (random < min) {
    random = min;
  }
  return random;
}

num randomSignNum(int max) {
  var logic = randomBool();
  var sign = randomSign(8);
  if (logic) {
    return sign * randomInt(max);
  } else {
    return sign * randomNum(max);
  }
}

int randomSign(int max) {
  int result = 1;
  var random = randomInt(max + 1);
  if (random == 0 || random == max) {
    result = -1;
  }
  return result;
}

randomElement(List list) => list[randomInt(list.length)];

String randomColorName() => randomElement(colorNames);

String randomColor() => colorCode[randomColorName()];



