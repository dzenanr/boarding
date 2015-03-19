part of crash;

class Board extends Surface {
  static const int carCount = 9; // including the red car

  Cars cars;
  RedCar redCar;
  Size space;

  Board(CanvasElement canvas) : super(canvas) {
    space = new Size(width, height);
    cars = new Cars(carCount);
    cars.forEach((Car car) {
      car.space = space;
      car.jump();
    });
    redCar = cars.redCar;
    redCar.space = space;
    document.onMouseDown.listen((MouseEvent e) {
      if (redCar.isSmall) redCar.bigger();
    });
    document.onMouseMove.listen((MouseEvent e) {
      redCar.x = e.offset.x - redCar.width  / 2;
      redCar.y = e.offset.y - redCar.height / 2;
      redCar.move();
    });
  }

  draw() {
    clear();
    bool isAccident = false;
    for (NonRedCar car in cars) {
      car.move();
      cars.avoidCollisions(car);
      cars.forEach((car) {
        if (redCar.isBig && redCar.hit(car)) {
          redCar.smaller();
          isAccident = true;
        } else if (redCar.isSmall && redCar.hit(car)) {
          car.box.position = space.randomPosition();
        }
      });
      drawPiece(car);
    }
    if (isAccident) {
      var car = new NonRedCar(cars.length + 1);
      car.box.position = space.randomPosition();
      car.space = space;
      cars.add(car);
    }
    drawPiece(redCar);
  }
}
