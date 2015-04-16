part of tint;

class Board extends Object with Surface {
  int size = 1;
  int count = 0;
  Area area;
  Tile tintTile;

  LabelElement scoreLabel = querySelector('#score');

  Board(CanvasElement canvas) {
    this.canvas = canvas;
    area = new Area.from(canvas.width, canvas.height);
    zoomOut();
    querySelector('#canvas').onMouseDown.listen((MouseEvent e) {
      int column = (e.offset.x ~/ grid.cellWidth).toInt();
      int row = (e.offset.y ~/ grid.cellHeight).toInt();
      var tile = grid.cellPieces.cellPiece(column, row);
      if (tile == tintTile) {
        scoreLabel.text = (++count).toString();
        zoomOut();
      } else {
        scoreLabel.text = (--count).toString();
      }
    });
  }

  zoomOut() {
    size++;
    var table = new Table.from(new Size.from(size, size), area);
    grid = new TileGrid(table);
    var randomColorCode = sevenColorCode[randomElement(sevenColorNames)];
    var randomColor = new Color();
    randomColor.main = randomColorCode;
    //randomColor.border = randomColorCode;
    tintTile = grid.cellPieces.randomCellPiece();
    var tintColorCode = sevenColorTint[randomColorCode];
    tintTile.color.main = tintColorCode;
    //tintTile.color.border = tintColorCode;
    grid.colorAllExcept(randomColor, tintTile);
  }
}