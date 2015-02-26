part of rush;

class Cars extends Concepts {
  Parking parking;
  CarBrand carBrand;

  Cars.ofParking(this.parking);
  Cars.ofCarBrand(this.carBrand);

  void deselect() {
    for (Car car in this) {
      car.isSelected = false;
    }
  }

  Car getSelectedCar() {
    for (Car car in this) {
      if (car.isSelected) {
        return car;
      }
    }
    return null;
  }
  
  Car getCarInCell(int row, int column) {
    for (Car car in this) {
      if (car.inCell(row, column)) {
        return car;
      }
    }
    return null;
  }

  Car getSelectedCarAfterOrBeforeCell(int row, int column) {
    for (Car car in this) {
      if (car.isSelected && car.afterOrBeforeCell(row, column)) {
        return car;
      }
    }
    return null;
  }
}

class Car extends Concept {
  Parking parking;
  CarBrand carBrand;

  String orientation;
  int startRow;
  int startColumn;

  int currentRow;
  int currentColumn;
  bool isSelected = false;

  Car(this.parking, this.carBrand);

  String toString() {
    return 'Car: ${oid.timeStamp} ${orientation} ${startRow} ${startColumn}';
  }

  bool inCell(int row, int column) {
    if (currentRow == row && currentColumn == column) {
      return true;
    } else if (orientation == 'horizontal' && carBrand.size == 2) {
      if (currentRow == row && currentColumn == column - 1) {
        return true;
      }
    } else if (orientation == 'horizontal' && carBrand.size == 3) {
      if (currentRow == row && (currentColumn == column - 1 || currentColumn == column - 2)) {
        return true;
      }
    } else if (orientation == 'vertical' && carBrand.size == 2) {
      if (currentRow == row - 1 && currentColumn == column) {
        return true;
      }
    } else if (orientation == 'vertical' && carBrand.size == 3) {
      if ((currentRow == row - 1 || currentRow == row - 2) && currentColumn == column) {
        return true;
      }
    }
    return false;
  }

  bool afterCell(int row, int column) {
    if (orientation == 'horizontal') {
      if (currentRow == row && currentColumn == column + 1) {
        return true;
      }
    } else if (orientation == 'vertical') {
      if (currentRow == row + 1 && currentColumn == column) {
        return true;
      }
    }
    return false;
  }

  bool beforeCell(int row, int column) {
    if (orientation == 'horizontal') {
      if (currentRow == row && carBrand.size == 2 && currentColumn == column - 2) {
        return true;
      } else if (currentRow == row && carBrand.size == 3 && currentColumn == column - 3) {
        return true;
      }
    } else if (orientation == 'vertical') {
      if (currentRow == row - 2 && carBrand.size == 2 && currentColumn == column) {
        return true;
      } else if (currentRow == row - 3 && carBrand.size == 3 && currentColumn == column) {
        return true;
      }
    }
    return false;
  }

  bool afterOrBeforeCell(int row, int column) {
    return afterCell(row, column) || beforeCell(row, column);
  }

  moveToOrTowardCell(int row, int column) {
    if (afterCell(row, column)) {
      currentRow = row;
      currentColumn = column;
    } else if (beforeCell(row, column)) {
      if (orientation == 'horizontal') {
        currentColumn = currentColumn + 1;
      } else if (orientation == 'vertical') {
        currentRow = currentRow + 1;
      }
    }
  }
}

