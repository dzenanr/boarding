part of d2048;

class GameCell extends Cell {
  GameCell(GameGrid grid, int row, int column): super(grid, row, column) {
    this.textSize = 32;
    this.textColor = 'blue';
  }
}

class GameGrid extends SquareGrid {
  GameGrid(int size): super(size) {
    randomCell();
    randomCell();
  }

  Cell newCell(Grid grid, int row, int column) => new GameCell(this, row, column);

  GameCell randomCell() {
    GameCell c = cells.randomAvailableCell();
    if (c != null) {
      c.number = new Random().nextDouble() < 0.9 ? 2 : 4;
      c.color = 'yellow';
    }
    return c;
  }
}