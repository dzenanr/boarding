import 'package:unittest/unittest.dart';
import 'package:boarding/grids.dart';

testModel(Grid grid) {
  group('Testing model', () {
    var w = grid.columnCount;
    var h = grid.rowCount;
    setUp(() {
      expect(grid, isNotNull);
      expect(w, greaterThan(1));
      expect(h, greaterThan(1));
      expect(grid.cells.every((c) => c.text == 'empty'), isTrue);
    });
    tearDown(() {
      for (Cell c in grid.cells) {
        c.text = 'empty';
      }
    });
    test('Cell', () {
      Cell c = grid.cells.cell(h - 1, w - 1);
      expect(c, isNotNull);
      expect(c.row, equals(h - 1));
      expect(c.column, equals(w - 1));
    });
    test('Some cells are red', () {
      Cell c = grid.cells.cell(h - 1, w - 1);
      c.textColor = 'red';
      expect(grid.cells.any((c) => c.textColor == 'red'), isTrue);
    });
    test('Is cell in?', () {
      Cell c = grid.cells.cell(h - 1, w - 1);
      expect(c.isIn(h - 1, w - 1), isTrue);
      expect(c.isIn(0, 0), isFalse);
    });
  });
}

main() {
  var grid = new Grid(16, 20);
  for (Cell cell in grid.cells) {
    cell.text = 'empty';
  }
  testModel(grid);
}
