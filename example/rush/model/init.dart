part of rush;

CarParkingModel model;

void init(CarParkingModel carParkingModel) {
  model = carParkingModel;
  initAreas();
  initCarBrands();
  initParkings();
}

void initAreas() {
  Area areaBeginner = new Area('beginner');
  model.areas.add(areaBeginner);

  Area areaIntermediate = new Area('intermediate');
  model.areas.add(areaIntermediate);
}

void initCarBrands() {
  CarBrand carBrandA = new CarBrand('A');
  carBrandA.size = 2;
  carBrandA.colorName = 'green';
  carBrandA.color = '#66CC99';
  carBrandA.red = 102;
  carBrandA.green = 204;
  carBrandA.blue = 153;
  model.carBrands.add(carBrandA);

  CarBrand carBrandB = new CarBrand('B');
  carBrandB.size = 2;
  carBrandB.colorName = 'orange';
  carBrandB.color = '#FFCC66';
  carBrandB.red = 255;
  carBrandB.green = 204;
  carBrandB.blue = 102;
  model.carBrands.add(carBrandB);

  CarBrand carBrandC = new CarBrand('C');
  carBrandC.size = 2;
  carBrandC.colorName = 'cyan';
  carBrandC.color = '#00FFFF';
  carBrandC.red = 0;
  carBrandC.green = 255;
  carBrandC.blue = 255;
  model.carBrands.add(carBrandC);

  CarBrand carBrandD = new CarBrand('D');
  carBrandD.size = 2;
  carBrandD.colorName = 'light pink';
  carBrandD.color = '#FF99CC';
  carBrandD.red = 255;
  carBrandD.green = 153;
  carBrandD.blue = 204;
  model.carBrands.add(carBrandD);

  CarBrand carBrandE = new CarBrand('E');
  carBrandE.size = 2;
  carBrandE.colorName = 'dark magenta';
  carBrandE.color = '#660033';
  carBrandE.red = 102;
  carBrandE.green = 0;
  carBrandE.blue = 51;
  model.carBrands.add(carBrandE);

  CarBrand carBrandF = new CarBrand('F');
  carBrandF.size = 2;
  carBrandF.colorName = 'dark green';
  carBrandF.color = '#009966';
  carBrandF.red = 0;
  carBrandF.green = 153;
  carBrandF.blue = 102;
  model.carBrands.add(carBrandF);

  CarBrand carBrandG = new CarBrand('G');
  carBrandG.size = 2;
  carBrandG.colorName = 'gray';
  carBrandG.color = '#BEBEBE';
  carBrandG.red = 190;
  carBrandG.green = 190;
  carBrandG.blue = 190;
  model.carBrands.add(carBrandG);

  CarBrand carBrandH = new CarBrand('H');
  carBrandH.size = 2;
  carBrandH.colorName = 'peach';
  carBrandH.color = '#FF9966';
  carBrandH.red = 255;
  carBrandH.green = 153;
  carBrandH.blue = 102;
  model.carBrands.add(carBrandH);

  CarBrand carBrandI = new CarBrand('I');
  carBrandI.size = 2;
  carBrandI.colorName = 'light gray';
  carBrandI.color = '#D3D3D3';
  carBrandI.red = 211;
  carBrandI.green = 211;
  carBrandI.blue = 211;
  model.carBrands.add(carBrandI);

  CarBrand carBrandJ = new CarBrand('J');
  carBrandJ.size = 2;
  carBrandJ.colorName = 'brown';
  carBrandJ.color = '#996600';
  carBrandJ.red = 153;
  carBrandJ.green = 102;
  carBrandJ.blue = 0;
  model.carBrands.add(carBrandJ);

  CarBrand carBrandK = new CarBrand('K');
  carBrandK.size = 2;
  carBrandK.colorName = 'mustard';
  carBrandK.color = '#CC9900';
  carBrandK.red = 204;
  carBrandK.green = 153;
  carBrandK.blue = 0;
  model.carBrands.add(carBrandK);

  CarBrand carBrandO = new CarBrand('O');
  carBrandO.size = 3;
  carBrandO.colorName = 'light yellow';
  carBrandO.color = '#FFFF99';
  carBrandO.red = 255;
  carBrandO.green = 255;
  carBrandO.blue = 153;
  model.carBrands.add(carBrandO);

  CarBrand carBrandP = new CarBrand('P');
  carBrandP.size = 3;
  carBrandP.colorName = 'magenta';
  carBrandP.color = '#993366';
  carBrandP.red = 153;
  carBrandP.green = 51;
  carBrandP.blue = 102;
  model.carBrands.add(carBrandP);

  CarBrand carBrandQ = new CarBrand('Q');
  carBrandQ.size = 3;
  carBrandQ.colorName = 'gray blue';
  carBrandQ.color = '#6699CC';
  carBrandQ.red = 102;
  carBrandQ.green = 153;
  carBrandQ.blue = 204;
  model.carBrands.add(carBrandQ);

  CarBrand carBrandR = new CarBrand('R');
  carBrandR.size = 3;
  carBrandR.colorName = 'deep sky blue';
  carBrandR.color = '#00BFFF';
  carBrandR.red = 0;
  carBrandR.green = 191;
  carBrandR.blue = 255;
  model.carBrands.add(carBrandR);

  CarBrand carBrandX = new CarBrand('X');
  carBrandX.size = 2;
  carBrandX.colorName = 'red';
  carBrandX.color = '#CC0033';
  carBrandX.red = 204;
  carBrandX.green = 0;
  carBrandX.blue = 51;
  model.carBrands.add(carBrandX);
}

void initParkings() {
  Area beginnerArea = model.areas.getArea('beginner');
  if (beginnerArea != null) {
    beginnerArea.parkings = new Parkings.ofArea(beginnerArea);
    initParkingsOfBeginnerArea(beginnerArea);
  }
  Area intermediateArea = model.areas.getArea('intermediate');
  if (intermediateArea != null) {
    intermediateArea.parkings = new Parkings.ofArea(intermediateArea);
    initParkingsOfIntermediateArea(intermediateArea);
  }

}

void initParkingsOfBeginnerArea(Area area) {
  if (area.code == 'beginner') {
    Parking parking1 = new Parking(area, 1);
    model.parkings.add(parking1);
    area.parkings.add(parking1);
    initCarsOfParking1OfBeginnerArea(area, parking1);

    Parking parking2 = new Parking(area, 2);
    model.parkings.add(parking2);
    area.parkings.add(parking2);
    initCarsOfParking2OfBeginnerArea(area, parking2);
  }
}

void initParkingsOfIntermediateArea(Area area) {
  if (area.code == 'intermediate') {
    Parking parking1 = new Parking(area, 1);
    model.parkings.add(parking1);
    area.parkings.add(parking1);
    initCarsOfParking1OfIntermediateArea(area, parking1);

    Parking parking2 = new Parking(area, 2);
    model.parkings.add(parking2);
    area.parkings.add(parking2);
    initCarsOfParking2OfIntermediateArea(area, parking2);
  }
}

void initCarsOfParking1OfBeginnerArea(Area area, Parking parking) {
  if (area.code == 'beginner' && parking.number == 1) {
    CarBrand carBrandA = model.carBrands.getCarBrand('A');
    if (carBrandA != null) {
      Car car1A = new Car(parking, carBrandA);
      car1A.orientation = 'horizontal';
      car1A.startRow = 0;
      car1A.startColumn = 0;
      parking.cars.add(car1A);
      carBrandA.cars.add(car1A);
    }

    CarBrand carBrandB = model.carBrands.getCarBrand('B');
    if (carBrandB != null) {
      Car car1B = new Car(parking, carBrandB);
      car1B.orientation = 'vertical';
      car1B.startRow = 4;
      car1B.startColumn = 0;
      parking.cars.add(car1B);
      carBrandB.cars.add(car1B);
    }

    CarBrand carBrandC = model.carBrands.getCarBrand('C');
    if (carBrandC != null) {
      Car car1C = new Car(parking, carBrandC);
      car1C.orientation = 'horizontal';
      car1C.startRow = 4;
      car1C.startColumn = 4;
      parking.cars.add(car1C);
      carBrandC.cars.add(car1C);
    }

    CarBrand carBrandO = model.carBrands.getCarBrand('O');
    if (carBrandO != null) {
      Car car1O = new Car(parking, carBrandO);
      car1O.orientation = 'vertical';
      car1O.startRow = 0;
      car1O.startColumn = 5;
      parking.cars.add(car1O);
      carBrandO.cars.add(car1O);
    }

    CarBrand carBrandP = model.carBrands.getCarBrand('P');
    if (carBrandP != null) {
      Car car1P = new Car(parking, carBrandP);
      car1P.orientation = 'vertical';
      car1P.startRow = 1;
      car1P.startColumn = 0;
      parking.cars.add(car1P);
      carBrandP.cars.add(car1P);
    }

    CarBrand carBrandQ = model.carBrands.getCarBrand('Q');
    if (carBrandQ != null) {
      Car car1Q = new Car(parking, carBrandQ);
      car1Q.orientation = 'vertical';
      car1Q.startRow = 1;
      car1Q.startColumn = 3;
      parking.cars.add(car1Q);
      carBrandQ.cars.add(car1Q);
    }

    CarBrand carBrandR = model.carBrands.getCarBrand('R');
    if (carBrandR != null) {
      Car car1R = new Car(parking, carBrandR);
      car1R.orientation = 'horizontal';
      car1R.startRow = 5;
      car1R.startColumn = 2;
      parking.cars.add(car1R);
      carBrandR.cars.add(car1R);
    }

    CarBrand carBrandX = model.carBrands.getCarBrand('X');
    if (carBrandX != null) {
      Car car1X = new Car(parking, carBrandX);
      car1X.orientation = 'horizontal';
      car1X.startRow = 2;
      car1X.startColumn = 1;
      parking.cars.add(car1X);
      carBrandX.cars.add(car1X);
    }

    for (Car car in parking.cars) {
      car.currentRow = car.startRow;
      car.currentColumn = car.startColumn;
    }
  }
}

void initCarsOfParking2OfBeginnerArea(Area area, Parking parking) {
  if (area.code == 'beginner' && parking.number == 2) {
    CarBrand carBrandA = model.carBrands.getCarBrand('A');
    if (carBrandA != null) {
      Car car1A = new Car(parking, carBrandA);
      car1A.orientation = 'vertical';
      car1A.startRow = 0;
      car1A.startColumn = 0;
      parking.cars.add(car1A);
      carBrandA.cars.add(car1A);
    }

    CarBrand carBrandB = model.carBrands.getCarBrand('B');
    if (carBrandB != null) {
      Car car1B = new Car(parking, carBrandB);
      car1B.orientation = 'vertical';
      car1B.startRow = 1;
      car1B.startColumn = 3;
      parking.cars.add(car1B);
      carBrandB.cars.add(car1B);
    }

    CarBrand carBrandC = model.carBrands.getCarBrand('C');
    if (carBrandC != null) {
      Car car1C = new Car(parking, carBrandC);
      car1C.orientation = 'vertical';
      car1C.startRow = 2;
      car1C.startColumn = 4;
      parking.cars.add(car1C);
      carBrandC.cars.add(car1C);
    }

    CarBrand carBrandD = model.carBrands.getCarBrand('D');
    if (carBrandD != null) {
      Car car1D = new Car(parking, carBrandD);
      car1D.orientation = 'vertical';
      car1D.startRow = 4;
      car1D.startColumn = 2;
      parking.cars.add(car1D);
      carBrandD.cars.add(car1D);
    }

    CarBrand carBrandE = model.carBrands.getCarBrand('E');
    if (carBrandE != null) {
      Car car1E = new Car(parking, carBrandE);
      car1E.orientation = 'horizontal';
      car1E.startRow = 4;
      car1E.startColumn = 4;
      parking.cars.add(car1E);
      carBrandE.cars.add(car1E);
    }

    CarBrand carBrandF = model.carBrands.getCarBrand('F');
    if (carBrandF != null) {
      Car car1F = new Car(parking, carBrandF);
      car1F.orientation = 'horizontal';
      car1F.startRow = 5;
      car1F.startColumn = 0;
      parking.cars.add(car1F);
      carBrandF.cars.add(car1F);
    }

    CarBrand carBrandG = model.carBrands.getCarBrand('G');
    if (carBrandG != null) {
      Car car1G = new Car(parking, carBrandG);
      car1G.orientation = 'horizontal';
      car1G.startRow = 5;
      car1G.startColumn = 3;
      parking.cars.add(car1G);
      carBrandG.cars.add(car1G);
    }

    CarBrand carBrandO = model.carBrands.getCarBrand('O');
    if (carBrandO != null) {
      Car car1O = new Car(parking, carBrandO);
      car1O.orientation = 'horizontal';
      car1O.startRow = 0;
      car1O.startColumn = 3;
      parking.cars.add(car1O);
      carBrandO.cars.add(car1O);
    }

    CarBrand carBrandP = model.carBrands.getCarBrand('P');
    if (carBrandP != null) {
      Car car1P = new Car(parking, carBrandP);
      car1P.orientation = 'vertical';
      car1P.startRow = 1;
      car1P.startColumn = 5;
      parking.cars.add(car1P);
      carBrandP.cars.add(car1P);
    }

    CarBrand carBrandQ = model.carBrands.getCarBrand('Q');
    if (carBrandQ != null) {
      Car car1Q = new Car(parking, carBrandQ);
      car1Q.orientation = 'horizontal';
      car1Q.startRow = 3;
      car1Q.startColumn = 0;
      parking.cars.add(car1Q);
      carBrandQ.cars.add(car1Q);
    }

    CarBrand carBrandX = model.carBrands.getCarBrand('X');
    if (carBrandX != null) {
      Car car1X = new Car(parking, carBrandX);
      car1X.orientation = 'horizontal';
      car1X.startRow = 2;
      car1X.startColumn = 0;
      parking.cars.add(car1X);
      carBrandX.cars.add(car1X);
    }

    for (Car car in parking.cars) {
      car.currentRow = car.startRow;
      car.currentColumn = car.startColumn;
    }
  }
}

void initCarsOfParking1OfIntermediateArea(Area area, Parking parking) {
  if (area.code == 'intermediate' && parking.number == 1) {
    CarBrand carBrandA = model.carBrands.getCarBrand('A');
    if (carBrandA != null) {
      Car car1A = new Car(parking, carBrandA);
      car1A.orientation = 'horizontal';
      car1A.startRow = 0;
      car1A.startColumn = 1;
      parking.cars.add(car1A);
      carBrandA.cars.add(car1A);
    }

    CarBrand carBrandB = model.carBrands.getCarBrand('B');
    if (carBrandB != null) {
      Car car1B = new Car(parking, carBrandB);
      car1B.orientation = 'vertical';
      car1B.startRow = 3;
      car1B.startColumn = 2;
      parking.cars.add(car1B);
      carBrandB.cars.add(car1B);
    }

    CarBrand carBrandE = model.carBrands.getCarBrand('E');
    if (carBrandE != null) {
      Car car1E = new Car(parking, carBrandE);
      car1E.orientation = 'vertical';
      car1E.startRow = 4;
      car1E.startColumn = 5;
      parking.cars.add(car1E);
      carBrandE.cars.add(car1E);
    }

    CarBrand carBrandO = model.carBrands.getCarBrand('O');
    if (carBrandO != null) {
      Car car1O = new Car(parking, carBrandO);
      car1O.orientation = 'vertical';
      car1O.startRow = 0;
      car1O.startColumn = 0;
      parking.cars.add(car1O);
      carBrandO.cars.add(car1O);
    }

    CarBrand carBrandP = model.carBrands.getCarBrand('P');
    if (carBrandP != null) {
      Car car1P = new Car(parking, carBrandP);
      car1P.orientation = 'vertical';
      car1P.startRow = 0;
      car1P.startColumn = 3;
      parking.cars.add(car1P);
      carBrandP.cars.add(car1P);
    }

    CarBrand carBrandQ = model.carBrands.getCarBrand('Q');
    if (carBrandQ != null) {
      Car car1Q = new Car(parking, carBrandQ);
      car1Q.orientation = 'horizontal';
      car1Q.startRow = 3;
      car1Q.startColumn = 3;
      parking.cars.add(car1Q);
      carBrandQ.cars.add(car1Q);
    }

    CarBrand carBrandR = model.carBrands.getCarBrand('R');
    if (carBrandR != null) {
      Car car1R = new Car(parking, carBrandR);
      car1R.orientation = 'horizontal';
      car1R.startRow = 5;
      car1R.startColumn = 2;
      parking.cars.add(car1R);
      carBrandR.cars.add(car1R);
    }

    CarBrand carBrandX = model.carBrands.getCarBrand('X');
    if (carBrandX != null) {
      Car car1X = new Car(parking, carBrandX);
      car1X.orientation = 'horizontal';
      car1X.startRow = 2;
      car1X.startColumn = 1;
      parking.cars.add(car1X);
      carBrandX.cars.add(car1X);
    }

    for (Car car in parking.cars) {
      car.currentRow = car.startRow;
      car.currentColumn = car.startColumn;
    }
  }
}

void initCarsOfParking2OfIntermediateArea(Area area, Parking parking) {
  if (area.code == 'intermediate' && parking.number == 2) {
    CarBrand carBrandA = model.carBrands.getCarBrand('A');
    if (carBrandA != null) {
      Car car1A = new Car(parking, carBrandA);
      car1A.orientation = 'vertical';
      car1A.startRow = 0;
      car1A.startColumn = 0;
      parking.cars.add(car1A);
      carBrandA.cars.add(car1A);
    }

    CarBrand carBrandB = model.carBrands.getCarBrand('B');
    if (carBrandB != null) {
      Car car1B = new Car(parking, carBrandB);
      car1B.orientation = 'horizontal';
      car1B.startRow = 0;
      car1B.startColumn = 1;
      parking.cars.add(car1B);
      carBrandB.cars.add(car1B);
    }

    CarBrand carBrandC = model.carBrands.getCarBrand('C');
    if (carBrandC != null) {
      Car car1C = new Car(parking, carBrandC);
      car1C.orientation = 'vertical';
      car1C.startRow = 4;
      car1C.startColumn = 4;
      parking.cars.add(car1C);
      carBrandC.cars.add(car1C);
    }

    CarBrand carBrandO = model.carBrands.getCarBrand('O');
    if (carBrandO != null) {
      Car car1O = new Car(parking, carBrandO);
      car1O.orientation = 'vertical';
      car1O.startRow = 0;
      car1O.startColumn = 5;
      parking.cars.add(car1O);
      carBrandO.cars.add(car1O);
    }

    CarBrand carBrandP = model.carBrands.getCarBrand('P');
    if (carBrandP != null) {
      Car car1P = new Car(parking, carBrandP);
      car1P.orientation = 'vertical';
      car1P.startRow = 1;
      car1P.startColumn = 2;
      parking.cars.add(car1P);
      carBrandP.cars.add(car1P);
    }

    CarBrand carBrandQ = model.carBrands.getCarBrand('Q');
    if (carBrandQ != null) {
      Car car1Q = new Car(parking, carBrandQ);
      car1Q.orientation = 'horizontal';
      car1Q.startRow = 3;
      car1Q.startColumn = 3;
      parking.cars.add(car1Q);
      carBrandQ.cars.add(car1Q);
    }

    CarBrand carBrandR = model.carBrands.getCarBrand('R');
    if (carBrandR != null) {
      Car car1R = new Car(parking, carBrandR);
      car1R.orientation = 'horizontal';
      car1R.startRow = 5;
      car1R.startColumn = 0;
      parking.cars.add(car1R);
      carBrandR.cars.add(car1R);
    }

    CarBrand carBrandX = model.carBrands.getCarBrand('X');
    if (carBrandX != null) {
      Car car1X = new Car(parking, carBrandX);
      car1X.orientation = 'horizontal';
      car1X.startRow = 2;
      car1X.startColumn = 0;
      parking.cars.add(car1X);
      carBrandX.cars.add(car1X);
    }

    for (Car car in parking.cars) {
      car.currentRow = car.startRow;
      car.currentColumn = car.startColumn;
    }
  }
}
