part of rush;

class CarParkingModel {
  Areas areas;
  CarBrands carBrands;
  Parkings parkings;

  CarParkingModel() {
    areas = new Areas();
    carBrands = new CarBrands();
    parkings = new Parkings();
    init(this);
  }
}
