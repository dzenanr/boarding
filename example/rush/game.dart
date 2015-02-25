library rush;

import 'dart:html';
import 'package:boarding/grids.dart';
import 'package:boarding/boarding.dart';

part 'model/meta/concept.dart';
part 'model/meta/concepts.dart';
part 'model/meta/oid.dart';
part 'model/areas.dart';
part 'model/cars.dart';
part 'model/car_brands.dart';
part 'model/init.dart';
part 'model/model.dart';
part 'model/parkings.dart';
part 'view/board.dart';

main() {
  final model = new CarParkingModel();
  final grid = new SquareGrid(6);
  final board = new Board(querySelector('#canvas'), grid, model, 
      withLines: false, area: 'intermediate', parking: 2);
  board.draw();
}
