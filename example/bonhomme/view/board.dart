part of bonhomme;

class Board extends Surface {
  static const int treeCount = 8; 

  Trees trees;
  Bonhomme bonhomme;
  Size space;
  bool gameOver = false;
  LabelElement winner;
  int hitCount = 0;

  Board(CanvasElement canvas, Trees trees): this.trees = trees, 
      super(canvas, movablePieces: trees) {
    winner = querySelector("#winner");
    space = new Size(width, height);
    trees.forEach((Tree tree) {
      tree.space = space;
    });
    bonhomme = new Bonhomme();
    bonhomme.space = space;
    document.onMouseMove.listen((MouseEvent e) {
      bonhomme.x = e.offset.x - bonhomme.width  / 2;
      bonhomme.y = e.offset.y - bonhomme.height / 2;
      bonhomme.move();
    });
  }

  draw() {
    if (!gameOver) {
      super.draw();
      trees.forEach((Tree tree) {
        if (tree.isMoving && bonhomme.hit(tree)) {
          hitCount++;
          tree.imgId = 'tree2';
          tree.isMoving = false;
          drawPiece(tree);
        } 
      });
      if (hitCount > 4) {
        gameOver = true; 
        winner.text = 'you lost';
      }
      drawPiece(bonhomme);
      if (bonhomme.x > width) {
        gameOver = true; 
        winner.text = 'you won';
      }
    }
  }
}
