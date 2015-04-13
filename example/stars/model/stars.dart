part of stars;

class Star extends MovablePiece {
//class Star extends Object with MovablePiece {

  Star(int id) {
    this.id = id;
  }

  bool increase() => size.increaseWithin(minMaxArea.maxArea);
  bool decrease() => size.decreaseWithin(minMaxArea.minArea);
}

class Stars extends MovablePieces {

  Stars(int count) {
    create(count);
  }

  create(int count) {
    for (var i = 0; i < count; i++) {
      add(new Star(i));
    }
  }
}