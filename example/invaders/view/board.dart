part of invaders;

class Board extends Surface {
  MovablePieces clouds, creatures;
  MovablePiece laser, spaceship;
  
  AudioElement hitSound;
  VideoElement invaderVideo;
  
  Board(CanvasElement canvas) : super(canvas) {  
    clouds = new Clouds(5);
    creatures = new Creatures(7);
    spaceship = new Spaceship();
    //*********************************************************************
    // If the video folder in this example is empty or does not exist,
    // load the video from https://www.youtube.com/watch?v=dgSsBT-rJuw
    // into the video folder (boarding/example/invaders/video/invader.webm)
    // by using http://www.computerhope.com/issues/ch001002.htm 
    // Uncomment the following line to use the video.
    //spaceship.usesVideo = true;
    //*********************************************************************
    laser = new Laser();
    hitSound = document.querySelector('#${laser.audioId}');   
    invaderVideo = document.querySelector('#${spaceship.videoId}');
    invaderVideo.hidden = true; 
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
      clouds.forEach((Cloud cloud) {
        cloud.move(Direction.DOWN);
        drawPiece(cloud);
      });
      creatures.forEach((Creature creature) {
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
            creature.imgId = 'explosion';
            hitSound.load();
            hitSound.play();
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
    } else if (spaceship.usesVideo) {   
      invaderVideo.hidden = false; 
      invaderVideo.play();
    }
  }
}