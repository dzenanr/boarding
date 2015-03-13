part of crash;

abstract class Car extends MovablePiece {
  static const num defaultWidth = 75;
  static const num defaultHeight = 30;

  Car(int id): super(id) {
    shape = PieceShape.VEHICLE;
    width = defaultWidth;
    height = defaultHeight;
  }
}

class NonRedCar extends Car {

  NonRedCar(int id): super(id) {
    color = randomColorCode();
    var speed = randomNum(MovablePiece.speedLimit);
    dx = randomNum(speed);
    dy = randomNum(speed);
  }
}

class RedCar extends Car {
  static const num smallWidth = 35;
  static const num smallHeight = 14;
  static const String smallColorCode = '#000000';
  static const String bigColorCode = '#E40000';

  bool isSmall = false;

  RedCar(int id): super(id) {
    color = bigColorCode;
  }

  bool get isBig => !isSmall;

  move([Direction direction]) {
    if (x + width > this.distance.width) {
      //x = distance.width - width;
      x = this.distance.width - width;
    }
    if (x - width < 0) {x = 0;}
    if (y + height > this.distance.height) {
      //y = distance.height - height;
      y = this.distance.height - height;
    }
    if (y - height < 0) {y = 0;}
  }

  bigger() {
    if (isSmall) {
      isSmall = false;
      width = 75;
      height = 30;
      color = bigColorCode;
    }
  }

  smaller() {
    if (isBig) {
      isSmall = true;
      width = smallWidth;
      height = smallHeight;
      color = smallColorCode;
    }
  }
}

class Cars extends MovablePieces {
  RedCar redCar;

  Cars(int count) : super(count) {
    redCar = new RedCar(0);
  }

  createMovablePieces(int count, {Distance distance}) {
    for (var i = 0; i < count - 1; i++) {
      add(new NonRedCar(i + 1));
    }
  }
}

