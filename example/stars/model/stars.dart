part of stars;

class Star extends Object with Piece {

  Star(int id) {
    this.id = id;
  }

  bool increase() => size.increaseWithin(minMaxArea.maxArea);
  bool decrease() => size.decreaseWithin(minMaxArea.minArea);
}

class Stars extends Object with Pieces {

  Stars(int count) {
    create(count);
  }

  create(int count) {
    for (var i = 0; i < count; i++) {
      add(new Star(i));
    }
  }
}