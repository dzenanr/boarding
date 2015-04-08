part of stars;

class Star extends MovablePiece {
  Star(int id): super(id);

  bool increase() => size.increaseWithin(minMaxArea.maxArea);
  bool decrease() => size.decreaseWithin(minMaxArea.minArea);
}

class Stars extends MovablePieces {
  Stars(int count): super(count);

  createMovablePieces(int count) {
    for (var i = 1; i <= count; i++) {
      add(new Star(i));
    }
  }
}