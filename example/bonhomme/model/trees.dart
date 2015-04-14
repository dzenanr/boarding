part of bonhomme;

class Tree extends Object with Piece {
  Tree(int id) {
    this.id = id;
    randomInit();
    shape = PieceShape.IMG;
    width = 45;
    height = 45;
    imgId = 'tree';
  }
}

class Trees extends Object with Pieces {
  Trees(int count) {
    create(count);
  }

  create(int count) {
    for (var i = 0; i < count; i++) {
      add(new Tree(i));
    }
  }
}