part of rush;

class Board extends Surface {
  String zone;
  int parking;

  CarParkingModel carParkingModel;
  Area currentArea;
  Parking currentParking;

  Board(CanvasElement canvas, Grid grid, this.carParkingModel,
      {String this.zone: 'beginner', int this.parking: 1}):
    super(canvas, grid: grid) {
    currentArea = carParkingModel.areas.getArea(zone);
    currentParking = currentArea.parkings.getParkingWithinArea(parking);
    canvas.onMouseDown.listen((MouseEvent e) {
      int column = e.offset.x ~/ grid.cellWidth;
      int row = e.offset.y ~/ grid.cellHeight;
      Car car = currentParking.cars.getCarInCell(row, column);
      if (car != null) {
        currentParking.cars.deselect();
        car.isSelected = true;
      } else {
        car = currentParking.cars.getSelectedCarAfterOrBeforeCell(row, column);
        if (car != null) {
          car.moveToCell(row, column);
          if (car.carBrand.code == 'X' &&
              car.currentColumn == grid.columnCount - car.carBrand.size) {
            car.currentColumn = grid.columnCount; // the car exits the parking
          }
        }
      }
    });
  }

  draw() {
    clear();
    for (Car car in currentParking.cars) {
      context.beginPath();
      int row = car.currentRow;
      int column = car.currentColumn;
      num x = column * grid.cellWidth;
      num y = row * grid.cellHeight;
      num carSize = car.carBrand.size;
      num carWidth = grid.cellWidth;
      num carHeight = grid.cellHeight;
      if (car.orientation == 'horizontal') {
        carWidth = grid.cellWidth * carSize;
      } else {
        carHeight = grid.cellHeight * carSize;
      }
      String color = car.carBrand.color;
      if (car.isSelected) {
        drawSelectedRect(canvas, x, y, carWidth, carHeight, color: color);
      } else {
        drawRect(canvas, x, y, carWidth, carHeight, color: color);
      }
    }
  }
}

