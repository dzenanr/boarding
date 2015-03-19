part of invaders;

class Board extends Surface {
  MovablePieces clouds, creatures;
  MovablePiece laser, spaceship;
  
  Board(CanvasElement canvas) : super(canvas) {
    clouds = new MovablePieces(5);
    clouds.randomInit();
    clouds.forEach((MovablePiece cloud) {
      cloud.width = 70;
      cloud.height = 70;
      cloud.shape = PieceShape.IMG;
      cloud.imageId = 'cloud';
    });
    
    creatures = new MovablePieces(7);
    creatures.randomInit();
    creatures.forEach((MovablePiece creature) {
      creature.width = 80;
      creature.height = 80;
      if (creature.dy < 2) {
        creature.dy = 2;
      }
      if (creature.dx >= creature.dy) {
        creature.dx = creature.dy - 1;
      } 
      creature.y = -creature.y;
      var ri = randomInt(7);
      creature.dx = randomSign(ri) * creature.dx; 
      creature.shape = PieceShape.IMG;
      creature.imageId = 'creature';
    });
    
    laser = new MovablePiece();
    laser.randomInit();
    laser.width = 4;
    laser.height = 50;
    laser.color = 'gray';
    laser.borderColor = 'red';
    laser.speed.dy = 6;
    laser.shape = PieceShape.RECT;
    laser.isVisible = false;
    
    spaceship = new MovablePiece();
    spaceship.randomInit();
    spaceship.width = 70;
    spaceship.height = 70;
    spaceship.shape = PieceShape.IMG;
    spaceship.imageId = 'spaceship';
    
    canvas.onMouseMove.listen((MouseEvent e) {
      spaceship.x = e.offset.x - spaceship.width  / 2;
      spaceship.y = e.offset.y - spaceship.height / 2;
    });
    canvas.onMouseDown.listen((MouseEvent e) {
      laser.x = e.offset.x;
      laser.y = e.offset.y - spaceship.height;
      laser.isVisible = true;
    });
  }
  
  background() {
    context
        ..fillStyle = 'lightBlue'
        ..beginPath()
        ..fillRect(0, 0, width, height)
        ..closePath();
  }
  
  clear() {
    super.clear();
    background();
  }
  
  draw() {
    clear();
    if (creatures.any((Piece p) => p.isVisible)) {
      clouds.forEach((MovablePiece cloud) {
        cloud.move(Direction.DOWN);
        drawPiece(cloud);
      });
      creatures.forEach((MovablePiece creature) {
        if (creature.isVisible) {
          creature.move(Direction.DOWN);
          creature.x += creature.dx; 
          if (creature.x < 0 || creature.x > width) {
            creature.x = randomNum(width);
          }
          if (creature.isSelected && (creature.x < 0 || creature.y < 0)) {
            creature.isVisible = false;
          }
          if (!creature.isSelected && laser.isVisible && laser.hit(creature)) {
            creature.isSelected = true;
            creature.imageId = 'explosion';
            laser.isVisible = false;
          }
          drawPiece(creature);
        }
      });
      if (laser.isVisible) {
        laser.y = laser.y - 6;
        if (laser.y + laser.height < 0) {
          laser.isVisible = false;
        }
        drawPiece(laser);
      }
      drawPiece(spaceship);
    }
  }
}