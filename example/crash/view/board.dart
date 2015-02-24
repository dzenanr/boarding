part of crash;

class Vehicle extends RoundedRect {
  Vehicle(Surface surface, num x, num y, num width, num height,
      {num lineWidth: 1, String color: 'white', String borderColor: 'black'}):
      super(surface, x, y, width, height, lineWidth: lineWidth, color: color, borderColor: borderColor);
 
  draw() {
    super.draw();
    surface.context
      ..beginPath()
      ..fillStyle = '#000000'
      ..rect(x + 12, y - 3, 14, 6)
      ..rect(x + width - 26, y - 3, 14, 6)
      ..rect(x + 12, y + height - 3, 14, 6)
      ..rect(x + width - 26, y + height - 3, 14, 6)
      ..fill()
      ..closePath();
  }
}

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
      if (redCar.small) redCar.bigger();
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
    for (NonRedCar car in cars) {
      car.move();
      cars.avoidCollisions(car);
      cars.forEach((car) => redCar.accident(car));
      new Vehicle(this, car.x, car.y, car.width, car.height, color: car.colorCode).draw();
    }
    new Vehicle(this, redCar.x, redCar.y, redCar.width, redCar.height, color: redCar.colorCode).draw();
  }
}
