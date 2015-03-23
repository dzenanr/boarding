import 'package:unittest/unittest.dart';
import 'package:boarding/grid.dart';
import 'package:boarding/util.dart';

testModel(Grid grid) {
  group('Testing model', () {
    var w = grid.columnCount;
    var h = grid.rowCount;
    setUp(() {
      expect(grid, isNotNull);
      expect(w, greaterThan(1));
      expect(h, greaterThan(1));
      expect(grid.cells.every((c) => c.text.text == 'empty'), isTrue);
    });
    tearDown(() {
      for (CellPiece c in grid.cells) {
        c.text.text = 'empty';
      }
    });
    test('Cell', () {
      CellPiece c = grid.cells.cell(h - 1, w - 1);
      expect(c, isNotNull);
      expect(c.row, equals(h - 1));
      expect(c.column, equals(w - 1));
    });
    test('Some cells are red', () {
      CellPiece c = grid.cells.cell(h - 1, w - 1);
      c.color.main = 'red';
      expect(grid.cells.any((c) => c.color.main == 'red'), isTrue);
    });
    test('Is cell in?', () {
      CellPiece c = grid.cells.cell(h - 1, w - 1);
      expect(c.isIn(h - 1, w - 1), isTrue);
      expect(c.isIn(0, 0), isFalse);
    });
  });
}

main() {
  var grid = new Grid(16, 20);
  for (CellPiece cell in grid.cells) {
    cell.text = new Tag('empty');
  }
  testModel(grid);
}
