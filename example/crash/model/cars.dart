part of crash;

abstract class Car extends Object with Piece {
  static const num defaultWidth = 75;
  static const num defaultHeight = 30;

  Car(int id) {
    this.id = id;
    shape = PieceShape.VEHICLE;
    width = defaultWidth;
    height = defaultHeight;
  }
}

class NonRedCar extends Car {

  NonRedCar(int id): super(id) {
    color.main = randomColor();
    speed = Speed.random();
  }
}

class RedCar extends Car {
  static const num smallWidth = 35;
  static const num smallHeight = 14;
  static const String smallColorCode = '#000000';
  static const String bigColorCode = '#E40000';

  bool isSmall = false;

  RedCar(int id): super(id) {
    color.main = bigColorCode;
  }

  bool get isBig => !isSmall;

  move([Direction direction]) {
    if (x > space.width - width) {
      x = space.width - width;
    }
    if (x < 0) {
      x = 0;
    }
    if (y > space.height - height) {
      y = space.height - height;
    }
    if (y < 0) {
      y = 0;
    }
  }

  bigger() {
    if (isSmall) {
      isSmall = false;
      width = 75;
      height = 30;
      color.main = bigColorCode;
    }
  }

  smaller() {
    if (isBig) {
      isSmall = true;
      width = smallWidth;
      height = smallHeight;
      color.main = smallColorCode;
    }
  }
}

class Cars extends Object with Pieces {
  RedCar redCar;

  Cars(int count) {
    redCar = new RedCar(0);
    create(count);
  }

  create(int count) {
    for (var i = 0; i < count - 1; i++) {
      add(new NonRedCar(i + 1));
    }
  }
}

