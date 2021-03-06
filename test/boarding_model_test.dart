import 'package:test/test.dart';
import 'package:boarding/grid.dart';
import 'package:boarding/util.dart';

void testModel(Grid grid) {
  group('Testing model', () {
    var cc = grid.table.columnCount;
    var rc = grid.table.rowCount;
    setUp(() {
      expect(grid, isNotNull);
      expect(cc, greaterThan(1));
      expect(rc, greaterThan(1));
      expect(grid.cellPieces.every((c) => c.tag.text == 'empty'), isTrue);
    });
    tearDown(() {
      for (CellPiece c in grid.cellPieces) {
        c.tag.text = 'empty';
      }
    });
    test('Cell Piece', () {
      CellPiece cp = grid.cellPieces.cellPiece(cc - 1, rc - 1);
      expect(cp, isNotNull);
      expect(cp.cell.column, equals(cc - 1));
      expect(cp.cell.row, equals(rc - 1));
    });
    test('Some cells are red', () {
      CellPiece cp = grid.cellPieces.cellPiece(cc - 1, rc - 1);
      cp.color.main = 'red';
      expect(grid.cellPieces.any((c) => c.color.main == 'red'), isTrue);
    });
    test('Is cell in?', () {
      CellPiece cp = grid.cellPieces.cellPiece(cc - 1, rc - 1);
      expect(cp.cell.isIn(cc - 1, rc - 1), isTrue);
      expect(cp.cell.isIn(0, 0), isFalse);
    });
  });
}

void main() {
  var table = new Table.from(new Size.from(16, 20), new Area.from(400, 600));
  var grid = new Grid(table);
  for (CellPiece cp in grid.cellPieces) {
    cp.tag = new Tag.from('empty');
  }
  testModel(grid);
}
