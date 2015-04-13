library rush;

import 'dart:html';
import 'package:boarding/grid.dart';
import 'package:boarding/util.dart' as util;
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
  var model = new CarParkingModel();
  var canvas = querySelector('#canvas');
  var table = new util.Table.from(new util.Size.from(6, 6),
                                  new util.Area.from(canvas.width, canvas.height));
  var grid = new Grid(table);
  var board = new Board(canvas, grid, model, zone: 'beginner', parking: 1);
      //zone: 'intermediate', parking: 2);
  board.draw();
}
