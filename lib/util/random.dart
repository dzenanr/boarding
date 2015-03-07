part of util;

randomBool() => new Random().nextBool();

randomInt(int max) => new Random().nextInt(max);

double randomDouble(double max) {
  double randomDouble = new Random().nextDouble() * max;
  return randomDouble > max ? max : randomDouble;
}

num randomNum(num max) {
  num random = new Random().nextDouble() * max;
  return random > max ? max : random;
}

num randomRangeNum(num min, num max) {
  num random = new Random().nextDouble() * max;
  if (random < min) {
    random = min;
  } else if (random > max) {
    random = max;
  } 
  return random;
}

num randomNumber(int max) {
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

String randomColor() => randomElement(colorList());

String randomColorCode() => colorMap()[randomColor()];



