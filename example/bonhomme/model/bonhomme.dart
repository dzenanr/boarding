part of bonhomme;

class Bonhomme extends MovablePiece {
  Bonhomme([int id]): super(id) {
    randomInit();
    shape = PieceShape.IMG;
    width = 60;
    height = 60;
    x = 0;
    y = 0;
    imgId = 'bonhomme';
  }
}