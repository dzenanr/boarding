part of invaders;

class Spaceship extends Object with Piece {
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

class Laser extends Object with Piece {
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

class Cloud extends Object with Piece {
  Cloud(int id) {
    this.id = id;
    randomInit();
    width = 80;
    height = 56;
    shape = PieceShape.IMG;
    imgId = 'cloud';
  }
}

class Creature extends Object with Piece {
  Creature(int id) {
    this.id = id;
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
    isTagged = false;
    dx = randomSign(ri) * dx;
    shape = PieceShape.IMG;
    imgId = 'creature';
  }
}

class Clouds extends Object with Pieces {
  Clouds(int count) {
    create(count);
  }

  void create(int count) {
    for (var i = 0; i < count; i++) {
      add(new Cloud(i));
    }
  }
}

class Creatures extends Object with Pieces {
  Creatures(int count) {
    create(count);
  }

  void create(int count) {
    for (var i = 0; i < count; i++) {
      add(new Creature(i));
    }
  }
}