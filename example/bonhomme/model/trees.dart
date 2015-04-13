part of bonhomme;

class Tree extends MovablePiece {
  Tree(int id) {
    this.id = id;
    randomInit();
    shape = PieceShape.IMG;
    width = 45;
    height = 45;
    imgId = 'tree';
  }
}

class Trees extends MovablePieces {
  Trees(int count) {
    create(count);
  }

  create(int count) {
    for (var i = 0; i < count; i++) {
      add(new Tree(i));
    }
  }
}