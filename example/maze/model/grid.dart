part of maze_gen;

//www.migapro.com/depth-first-search
class MazeGrid extends Grid {
  MazeGrid(Table table): super(table) {
    cellPieces.forEach((CellPiece cp) {
      cp.tag.number = 1;
      cp.color.main = 'black'; // wall
    });
    CellPiece sp = cellPieces.randomCellPiece();
    sp.tag.number = 0;
    gen(sp.cell.column, sp.cell.row);
  }
  
  gen(int c, int r) {
    var rds = new List<Direction>();
    for (var i = 0; i < 4; i++) {
      rds.add(randomDirection());
    }
    for (var rd in rds) {
      switch(rd) {
        case Direction.LEFT:
          // if 2 cells left is outside
          if (c - 2 <= 0) {
            continue;
          }
          var cp1 = cellPieces.cellPiece(c - 1, r);
          var cp2 = cellPieces.cellPiece(c - 2, r);
          if (cp2.tag.number == 1) { // if wall
              cp2.tag.number = 0;  // path
              cp1.tag.number = 0;
              gen(c - 2, r);
          }
          break;
        case Direction.RIGHT:
          // if 2 cells right is outside
          if (c + 2 >= table.size.columnCount - 1) {
            continue;
          }
          var cp1 = cellPieces.cellPiece(c + 1, r);
          var cp2 = cellPieces.cellPiece(c + 2, r);
          if (cp2.tag.number == 1) {
              cp2.tag.number = 0;
              cp1.tag.number = 0;
              gen(c + 2, r);
          }          
          break;
        case Direction.UP:
          // if 2 cells up is outside
          if (r - 2 <= 0) {
            continue;
          }
          var cp1 = cellPieces.cellPiece(c, r - 1);
          var cp2 = cellPieces.cellPiece(c, r - 2);
          if (cp2.tag.number == 1) {
              cp2.tag.number = 0;
              cp1.tag.number = 0;
              gen(c, r - 2);
          }
          break;
        case Direction.DOWN:
          // if 2 cells down is outside
          if (r + 2 >= table.size.rowCount - 1) {
            continue;
          }
          var cp1 = cellPieces.cellPiece(c, r + 1);
          var cp2 = cellPieces.cellPiece(c, r + 2);
          if (cp2.tag.number == 1) {
              cp2.tag.number = 0;
              cp1.tag.number = 0;
              gen(c, r + 2);
          }    
      }
    }
  }
}