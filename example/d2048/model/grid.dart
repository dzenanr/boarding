part of d2048;

class Tile extends Cell {
  Tile(TileGrid grid, int row, int column): super(grid, row, column) {
    textSize = 32;
    textColor = 'blue';
  }
}

class TileGrid extends SquareGrid {
  TileGrid(int size): super(size) {
    randomCell();
    randomCell();
  }

  Cell newCell(Grid grid, int row, int column) => new Tile(this, row, column);

  Tile randomCell() {
    Tile c = cells.randomAvailableCell();
    if (c != null) {
      c.number = new Random().nextDouble() < 0.9 ? 2 : 4;
      c.color = 'yellow';
    }
    return c;
  }
}