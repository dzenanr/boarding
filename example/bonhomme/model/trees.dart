part of bonhomme;

class Tree extends MovablePiece {
  Tree(int id): super(id) {
    randomInit();
    shape = PieceShape.IMG;
    width = 45;
    height = 45;
    imgId = 'tree';
  }
}

class Trees extends MovablePieces {
  Trees(int count) : super(count);

  createMovablePieces(int count) {
    for (var i = 0; i < count - 1; i++) {
      add(new Tree(i + 1));
    }
  }
}