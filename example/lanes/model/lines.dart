part of lanes;

class YellowLine extends Object with Piece {
  YellowLine nextLine;

  YellowLine(int id) {
    this.id = id;
    width = 15;
    height = 50;
    color.main = 'yellow';
    color.border = 'yellow';
    speed.dy = 4;
    shape = PieceShape.RECT;
  }

  void calcY() {
    if (nextLine == null) {
      y = -height;
    } else {
      y = nextLine.y - height * 1.5;
    }
  }
 }

class YellowLines extends Object with Pieces {
  YellowLines(int count) {
    create(count);
  }

  void create(int count) {
    var nextLine = new YellowLine(0);
    nextLine.y = -nextLine.height;
    add(nextLine);
    for (var i = 1; i < count; i++) {
      var currentLine = new YellowLine(i);
      currentLine.nextLine = nextLine;
      nextLine = currentLine;
      add(currentLine);
    }
  }

  void calcY() {
    var frontLine = firstWhere((YellowLine yl) => yl.nextLine == null);
    frontLine.y = frontLine.space.height - frontLine.height;
    for (var line in this) {
      if (line.nextLine != null) {
        line.y = line.nextLine.y - line.height * 1.5;
      }
    }
  }

  void moveDown() {
    for (var line in this) {
      line.y += line.speed.dy;
      if (line.y > line.space.height) {
        line.calcY();
      }
    }
  }
}