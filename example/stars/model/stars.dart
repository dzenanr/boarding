part of stars;

class Star extends MovablePiece {
  Star(int id): super(id);
  
  bool increase() => size.increaseWithin(minMaxSize.maxSize);
  bool decrease() => size.decreaseWithin(minMaxSize.minSize);
}

class Stars extends MovablePieces {  
  Stars(int count): super(count);
  
  createMovablePieces(int count) {
    var id = 0;
    for (var i = 0; i < count; i++) {
      add(new Star(++id));
    }
  }
}