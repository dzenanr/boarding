part of invaders;

class Spaceship extends MovablePiece {  
  Spaceship() {
    randomInit();
    width = 70;
    height = 70;
    shape = PieceShape.IMG;
    imgId = 'spaceship';
    videoId = 'invader';
    usesVideo = false;
  }
}

class Laser extends MovablePiece {  
  Laser() {
    randomInit();
    width = 4;
    height = 50;
    color.main = 'gray';
    color.border = 'red';
    speed.dy = 6;
    shape = PieceShape.RECT;
    isVisible = false;
    audioId = 'collision';
    usesAudio = true;
  }
}

class Cloud extends MovablePiece {  
  Cloud(int id) {
    randomInit();
    width = 80;
    height = 56;
    shape = PieceShape.IMG;
    imgId = 'cloud';
  }
}

class Creature extends MovablePiece {  
  Creature(int id) {
    randomExtraInit();
    width = 48;
    height = 64;
    if (dy < 2) {
      dy = 2;
    }
    if (dx >= dy) {
      dx = dy - 1;
    } 
    y = -y;
    var ri = randomInt(7);
    //isCovered = false;
    isTagged = false;
    dx = randomSign(ri) * dx; 
    shape = PieceShape.IMG;
    imgId = 'creature';
  }
}

class Clouds extends MovablePieces {
  Clouds(int count): super(count);

  createMovablePieces(int count) {
    var id = 0;
    for (var i = 0; i < count; i++) {
      add(new Cloud(++id));
    }
  }
}

class Creatures extends MovablePieces {
  Creatures(int count): super(count);

  createMovablePieces(int count) {
    var id = 0;
    for (var i = 0; i < count; i++) {
      add(new Creature(++id));
    }
  }
}