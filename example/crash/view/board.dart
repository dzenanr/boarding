part of crash;

class Board extends Surface {
  static const int carCount = 9; // including the red car

  Cars cars;
  RedCar redCar;
  Size distanceSize;

  Board(CanvasElement canvas) : super(canvas) {
    distanceSize = new Size(width, height);
    cars = new Cars(carCount);
    cars.forEach((Car car) {
      car.distanceSize = distanceSize;
      car.x = randomNum(car.distanceSize.width - car.width);
      car.y = randomNum(car.distanceSize.height - car.height);
    });
    redCar = cars.redCar;
    redCar.distanceSize = distanceSize;
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
        }
      });
      drawPiece(car);
    }
    if (isAccident) {
      var car = new NonRedCar(cars.length + 1);
      car.distanceSize = distanceSize;
      car.x = randomNum(car.distanceSize.width - car.width);
      car.y = randomNum(car.distanceSize.height - car.height);
      cars.add(car);
    }
    drawPiece(redCar);
  }
}
