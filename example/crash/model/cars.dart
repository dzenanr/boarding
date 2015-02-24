part of crash;

abstract class Car extends MovablePiece {
  static const num defaultWidth = 75;
  static const num defaultHeight = 30;

  Car() {
    width = defaultWidth;
    height = defaultHeight;
    x = randomNum(distanceWidth - width);
    y = randomNum(distanceHeight - height);
  }
}

class NonRedCar extends Car {
  NonRedCar() {
    colorCode = randomColorCode();
    speed = randomNum(MovablePiece.speedLimit) + 1;
    dx = randomNum(speed);
    dy = randomNum(speed);
  }
}

class RedCar extends Car {
  static const num smallWidth = 35;
  static const num smallHeight = 14;
  static const String smallColorCode = '#000000';
  static const String bigColorCode = '#E40000';
  
  bool small = false;
  bool get big => !small;
  
  move() {
    if (isMoving) {
      if (x > distanceWidth)  x = distanceWidth - 20;
      if (x < 0)              x = 20 - width;
      if (y > distanceHeight) y = distanceHeight - 20;
      if (y < 0)              y = 20 - height;      
    }
  }
  
  bigger() {
    if (small) {
      small = false;
      width = 75;
      height = 30;
      colorCode = bigColorCode;
      isMoving = true;
    }
  }

  smaller() {
    if (big) {
      small = true;
      width = smallWidth;
      height = smallHeight;
      colorCode = smallColorCode;
      isMoving = false;
    }
  }
  
  accident(Car car) {
    if (big) {
      if (car.x < x  && car.y < y) {
        if (car.x + car.width >= x && car.y + car.height >= y) smaller();
      } else if (car.x > x  && car.y < y) {
        if (car.x <= x + width && car.y + car.height >= y)     smaller();
      } else if (car.x < x  && car.y > y) {
        if (car.x + car.width >= x && car.y <= y + height)     smaller();
      } else if (car.x > x  && car.y > y) {
        if (car.x <= x + width && car.y <= y + height)         smaller();
      }
    }
  }
}

class Cars extends MovablePieces {
  RedCar redCar;

  Cars(int count) : super(count) {
    redCar = new RedCar();
    redCar.colorCode = RedCar.bigColorCode;
  }
  
  createMovablePieces(int count) {
    for (var i = 0; i < count - 1; i++) { 
      add(new NonRedCar());
    }
  }
}

