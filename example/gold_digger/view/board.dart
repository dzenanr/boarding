part of gold_digger;

class Board extends Surface {
  static const String gold = '#ffd700';
  Ball ball;
  String mainColor;
  String borderColor;
  int secondCount = 0;
  int goldCount = 0;
  int goldCountLimit = 3;
  
  Board(CanvasElement canvas, DGrid grid) : super(canvas, grid: grid) {
    LabelElement goldCountLabel = querySelector("#gold-count");
    ball = new Ball(grid.cellPieces.cellPiece(0, 0));
    mainColor = ball.color.main;
    borderColor = ball.color.border;
    new Timer.periodic(const Duration(milliseconds: 1000), (Timer t) {
      secondCount++;
      ball.dCell = grid.cellPieces.randomCellPiece();
      if (ball.dCell.color.main == gold) { 
        ball.color.main = borderColor;
        ball.color.border = mainColor;
        if (++goldCount == goldCountLimit) {
          t.cancel();
        } 
        if (goldCount == 1) {
          goldCountLabel.text = 'dug ${goldCount} gold piece in ${secondCount} seconds';
        } else {
          goldCountLabel.text = 'dug ${goldCount} gold pieces in ${secondCount} seconds';
        }
      } else {
        ball.color.main = mainColor;
        ball.color.border = borderColor;
      }
    });
  }
  
  draw() {
    super.draw();
    drawPiece(ball);
  }
}