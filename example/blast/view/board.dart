part of blast;

class Board extends Object with Surface {
  int size = 0;
  Area area;

  Board(CanvasElement canvas) {
    this.canvas = canvas;
    area = new Area.from(canvas.width, canvas.height);
    blast();
    querySelector('#canvas').onMouseDown.listen((MouseEvent e) {
      blast();
    });
  }

  void blast() {
    size++;
    var table = new Table.from(new Size.from(size, size), area);
    grid = new TileGrid(table);
  }
}