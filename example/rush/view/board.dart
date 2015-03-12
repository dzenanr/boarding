part of rush;

class Board extends SquareSurface {
  int cellLength; // in pixels
  String area;
  int parking;

  CarParkingModel carParkingModel;
  Area currentArea;
  Parking currentParking;

  Board(CanvasElement canvas, SquareGrid grid, this.carParkingModel,
      {bool withLines: true, String this.area: 'beginner', int this.parking: 1}):
    super(canvas, withLines: withLines, grid: grid) {
    cellLength = length ~/ grid.size;
    currentArea = carParkingModel.areas.getArea(area);
    currentParking = currentArea.parkings.getParkingWithinArea(parking);
    canvas.onMouseDown.listen((MouseEvent e) {
      int row = e.offset.y ~/ cellLength;
      int column = e.offset.x ~/ cellLength;
      Car car = currentParking.cars.getCarInCell(row, column);
      if (car != null) {
        currentParking.cars.deselect();
        car.isSelected = true;
      } else {
        car = currentParking.cars.getSelectedCarAfterOrBeforeCell(row, column);
        if (car != null) {
          car.moveToCell(row, column);
          if (car.carBrand.code == 'X' &&
              car.currentColumn == grid.size - car.carBrand.size) {
            car.currentColumn = grid.size; // the car exits the parking
          }
        }
      }
    });
  }

  draw() {
    super.draw();
    for (Car car in currentParking.cars) {
      context.beginPath();
      int row = car.currentRow;
      int column = car.currentColumn;
      int x = column * cellLength;
      int y = row * cellLength;
      int carSize = car.carBrand.size;
      int carWidth = cellLength;
      int carHeight = cellLength;
      if (car.orientation == 'horizontal') {
        carWidth = cellLength * carSize;
      } else {
        carHeight = cellLength * carSize;
      }
      String color = car.carBrand.color;
      if (car.isSelected) {
        new SelectedRect(canvas, x, y, carWidth, carHeight, color: color).draw();
      } else {
        new Rect(canvas, x, y, carWidth, carHeight, color: color).draw();
      }
    }
  }
}

