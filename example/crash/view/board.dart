part of crash;

class Board extends Surface {
  static const int carCount = 9; // including the red car
  
  Cars cars;
  RedCar redCar;
  
  Board(CanvasElement canvas) : super(canvas) {
    cars = new Cars(carCount);
    redCar = cars.redCar;
    redCar.distanceWidth = canvas.width;
    redCar.distanceHeight = canvas.height;
    document.onMouseDown.listen((MouseEvent e) {
      if (redCar.isSmall) redCar.bigger();
    });
    document.onMouseMove.listen((MouseEvent e) {
      redCar.x = e.offset.x - redCar.width  / 2;
      redCar.y = e.offset.y - redCar.height / 2; 
      redCar.move();
    });
    window.animationFrame.then(gameLoop);
  }
  
  gameLoop(num delta) {
    draw();
    window.animationFrame.then(gameLoop);
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
      cars.add(new NonRedCar(cars.length + 1));
    }
    drawPiece(redCar);
  }
}
