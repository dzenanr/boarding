part of boarding;

drawCircle(CanvasElement canvas, num x, num y, num radius,
    {num lineWidth: 1, String color: 'white', String borderColor: 'black'}) {
  // x center, y center
  var context = canvas.getContext('2d');
  context
      ..lineWidth = lineWidth
      ..fillStyle = color
      ..strokeStyle = borderColor
      ..beginPath()
      ..arc(x, y, radius, 0, PI * 2)
      ..closePath()
      ..fill()
      ..stroke();
}

drawCircleWithinSquare(CanvasElement canvas, num x, num y, num length,
    {num lineWidth: 1, String color: 'white', String borderColor: 'black'}) {
  // x left, y top
  var r = length / 2;
  drawCircle(canvas, x + r, y + r, r,
             lineWidth: lineWidth, color: color, borderColor: borderColor);
}

//http://www.html5canvastutorials.com/tutorials/html5-canvas-custom-shapes/
//http://stackoverflow.com/questions/19541192/how-to-draw-cloud-shape-in-html5-canvas
//http://www.html5canvastutorials.com/advanced/html5-canvas-save-drawing-as-an-image/
// to do: draw a cloud within a shape (polygon, regular polygon)
drawCloud(CanvasElement canvas, num x, num y, num width, num height,
    {num lineWidth: 1, String color: 'white', String borderColor: 'black'}) {
  var context = canvas.getContext('2d');
  context
      ..lineWidth = lineWidth
      ..fillStyle = color
      ..strokeStyle = borderColor
      ..beginPath()
      ..moveTo(170, 80)
      ..bezierCurveTo(130, 100, 130, 150, 230, 150)
      ..bezierCurveTo(250, 180, 320, 180, 340, 150)
      ..bezierCurveTo(420, 150, 420, 120, 390, 100)
      ..bezierCurveTo(430, 40, 370, 30, 340, 50)
      ..bezierCurveTo(320, 5, 250, 20, 250, 50)
      ..bezierCurveTo(200, 5, 150, 20, 170, 80)
      ..closePath()
      ..fill()
      ..stroke();
}

//http://stackoverflow.com/questions/2172798/how-to-draw-an-oval-in-html5-canvas
drawEllipseWithinRect(CanvasElement canvas, num x, num y, num width, num height,
    {num lineWidth: 1, String color: 'white', String borderColor: 'black'}) {
  var context = canvas.getContext('2d');
  var kappa = .5522848,
      ox = (width / 2) * kappa,  // control point offset horizontal
      oy = (height / 2) * kappa, // control point offset vertical
      xe = x + width,            // x-end
      ye = y + height,           // y-end
      xm = x + width / 2,        // x-middle
      ym = y + height / 2;       // y-middle
  context
      ..lineWidth = lineWidth
      ..fillStyle = color
      ..strokeStyle = borderColor
      ..beginPath()
      ..moveTo(x, ym)
      ..bezierCurveTo(x, ym - oy, xm - ox, y, xm, y)
      ..bezierCurveTo(xm + ox, y, xe, ym - oy, xe, ym)
      ..bezierCurveTo(xe, ym + oy, xm + ox, ye, xm, ye)
      ..bezierCurveTo(xm - ox, ye, x, ym + oy, x, ym)
      ..closePath() // use to close off open path
      ..fill()
      ..stroke();
}

drawFaceWithinSquare(CanvasElement canvas, num x, num y, num length,
    {num lineWidth: 1, String color: 'white', String borderColor: 'black'}) {
  drawCircleWithinSquare(canvas, x, y, length,
      lineWidth: lineWidth, color: color, borderColor: borderColor);
  drawCircle(canvas, x + length / 3, y + length / 2.5, length / 8,
      color: borderColor, borderColor: color);
  drawCircle(canvas, x + length / 3 * 2, y + length / 2.5, length / 8,
      color: borderColor, borderColor: color);
}

drawImgWithinRect(CanvasElement canvas, num x, num y, num width, num height,
    ImageElement img) {
  var context = canvas.getContext('2d');
  context
      ..beginPath()
      ..drawImageToRect(img, new Rectangle(x, y, width, height))
      ..closePath();
}

drawLine(CanvasElement canvas, num x1, num y1, num x2, num y2,
    {num lineWidth: 1, String color: 'black'}) {
  var context = canvas.getContext('2d');
  context
      ..lineWidth = lineWidth
      ..strokeStyle = color
      ..beginPath()
      ..moveTo(x1, y1)
      ..lineTo(x2, y2)
      ..closePath()
      ..stroke();
}

drawOneOfLines(CanvasElement canvas, num x1, num y1, num x2, num y2,
    {num lineWidth: 1, String color: 'black'}) {
  var context = canvas.getContext('2d');
  context
      ..lineWidth = lineWidth
      ..strokeStyle = color
      ..moveTo(x1, y1)
      ..lineTo(x2, y2);
}

drawDistanceLine(CanvasElement canvas, Piece p1, Piece p2, num minDistance) {
  //RGBA color: rgba(red, green, blue, alpha).
  //The alpha number is between 0.0 (fully transparent) and 1.0 (fully opaque).
  var p1x = p1.x + (p1.width / 2), p1y = p1.y + (p1.height / 2);
  var p2x = p2.x + (p2.width / 2), p2y = p2.y + (p2.height / 2);
  var distance12 = distance(p1, p2);
  if (distance12 <= minDistance) {
    var d = 1.2 - distance12 / minDistance;
    var c = 'rgba(255, 255, 255, $d)';
    drawLine(canvas, p1x, p1y, p2x, p2y, color: c);
  }
}

drawPosition(CanvasElement canvas, num x, num y,
    {num lineWidth: 1, String color: 'black'}) {
  var r = 1 / 2;
  drawCircle(canvas, x + r, y + r, r, lineWidth: lineWidth, color: color);
}

// http://scienceprimer.com/drawing-regular-polygons-javascript-canvas
drawPolygon(CanvasElement canvas, num x, num y, num sideLength, int sideCount,
    {num lineWidth: 1, String color: 'white', String borderColor: 'black'}) {
  // x center, y center
  var context = canvas.getContext('2d');
  context
      ..lineWidth = lineWidth
      ..fillStyle = color
      ..strokeStyle = borderColor
      ..beginPath()
      ..moveTo (x +  sideLength * cos(0), y +  sideLength *  sin(0));
  for (var i = 1; i <= sideCount; i++) {
    context.lineTo(x + sideLength * cos(i * 2 * PI / sideCount),
                   y + sideLength * sin(i * 2 * PI / sideCount));
  }
  context
      ..closePath()
      ..fill()
      ..stroke();
}

drawPolygonWithinSquare(CanvasElement canvas, num x, num y, num length,
                        num sideLength, int sideCount,
    {num lineWidth: 1, String color: 'white', String borderColor: 'black'}) {
  // x left, y top
  var r = length / 2;
  drawPolygon(canvas, x + r, y + r, sideLength, sideCount,
             lineWidth: lineWidth, color: color, borderColor: borderColor);
}

drawRect(CanvasElement canvas, num x, num y, num width, num height,
    {num lineWidth: 1, String color: 'white', String borderColor: 'black'}) {
  var context = canvas.getContext('2d');
  context
      ..lineWidth = lineWidth
      ..fillStyle = color
      ..strokeStyle = borderColor
      ..beginPath()
      ..rect(x, y, width, height)
      ..closePath()
      ..fill()
      ..stroke();
}

//http://stackoverflow.com/questions/1255512/how-to-draw-a-rounded-rectangle-on-html-canvas
prepareRoundedRect(CanvasElement canvas, num x, num y, num width, num height,
                   num radius) {
  var r2d = PI / 180;
  //ensure that the radius isn't too large for x
  if ((width - x) - (2 * radius) < 0) {radius = (( width - x ) / 2);}
  //ensure that the radius isn't too large for y
  if ((height - y) - (2 * radius) < 0 ) {radius = ((height - y) / 2 );}
  var context = canvas.getContext('2d');
  context
      ..beginPath()
      ..moveTo(x + radius, y)
      ..lineTo(width - radius, y)
      ..arc(width - radius, y + radius, radius, r2d * 270, r2d * 360, false)
      ..lineTo(width, height - radius)
      ..arc(width - radius, height - radius, radius, r2d * 0, r2d * 90, false)
      ..lineTo(x + radius, height)
      ..arc(x + radius, height - radius, radius, r2d * 90, r2d * 180, false)
      ..lineTo(x, y + radius)
      ..arc(x + radius, y + radius, radius, r2d * 180, r2d * 270, false)
      ..closePath();
}

drawRoundedRect(CanvasElement canvas, num x, num y, num width, num height,
    {num radius: 10, num lineWidth: 1, String color: 'white',
     String borderColor: 'black'}) {
  var context = canvas.getContext('2d');
  prepareRoundedRect(canvas, x, y, x + width, y + height, radius);
  context
      ..lineWidth = lineWidth
      ..fillStyle = color
      ..strokeStyle = borderColor
      ..fill()
      ..stroke();
}

drawSelectedRect(CanvasElement canvas, num x, num y, num width, num height,
    {num lineWidth: 1, String color: 'white', String borderColor: 'black'}) {
  const int sss = 8; // selection square size
  var context = canvas.getContext('2d');
  drawRect(canvas, x, y, width, height, lineWidth: lineWidth, color: color,
      borderColor: borderColor);
  context
      ..fillStyle = 'black'
      ..beginPath()
      ..rect(x, y, sss, sss)
      ..rect(x + width - sss, y, sss, sss)
      ..rect(x + width - sss, y + height - sss, sss, sss)
      ..rect(x, y + height - sss, sss, sss)
      ..closePath()
      ..fill();
}

drawSquare(CanvasElement canvas, num x, num y, num length,
    {num lineWidth: 1, String color: 'white', String borderColor: 'black'}) {
  var context = canvas.getContext('2d');
  context
      ..lineWidth = lineWidth
      ..fillStyle = color
      ..strokeStyle = borderColor
      ..beginPath()
      ..rect(x, y, length, length)
      ..closePath()
      ..fill()
      ..stroke();
}

//http://stackoverflow.com/questions/25837158/how-to-draw-a-star-by-using-canvas-html5
drawStar(CanvasElement canvas, num x, num y, num radius,
    {num innerRadius, int spikes: 5, num lineWidth: 1, String color: '#ffff99',
     String borderColor: 'black'}) {
  // light yellow: #ffff99
  var rot = PI / 2 * 3;
  var sx = x;
  var sy = y;
  var step = PI / spikes;
  var ir;
  if (ir == null) {
    ir = radius / 2;
  }
  var context = canvas.getContext('2d');
  context
      ..lineWidth = lineWidth
      ..strokeStyle = borderColor
      ..fillStyle = color
      ..beginPath()
      ..moveTo(x, y - radius);
  for (var i = 0; i < spikes; i++) {
    sx = x + cos(rot) * radius;
    sy = y + sin(rot) * radius;
    context.lineTo(sx, sy);
    rot += step;
    sx = x + cos(rot) * ir;
    sy = y + sin(rot) * ir;
    context.lineTo(sx, sy);
    rot += step;
  }
  context
      ..lineTo(x, y - radius)
      ..closePath()
      ..stroke()
      ..fill();
}

drawStarWithinSquare(CanvasElement canvas, num x, num y, num length,
    {num innerRadius, int spikes: 5, num lineWidth: 1, color: 'white',
     String borderColor: 'black'}) {
  drawStar(canvas, x + length / 2, y + length / 2, length / 2,
           innerRadius: innerRadius, spikes: spikes, lineWidth: lineWidth,
           color: color, borderColor: borderColor);
}

List<Map<String, num>> prepareStars(CanvasElement canvas, int count,
    {int spikes: 5}) {
  var stars = new List<Map>();
  for (var i = 0; i < count; i++) {
    var x = randomNum(canvas.width);
    var y = randomNum(canvas.height);
    var radius = randomNum(spikes * 2);
    var innerRadius = randomNum(spikes);
    var star = new Map<String, num>();
    star['x'] = x;
    star['y'] = y;
    star['radius'] = radius;
    star['innerRadius'] = innerRadius;
    star['spikes'] = spikes;
    stars.add(star);
  }
  return stars;
}

drawStars(CanvasElement canvas, List<Map<String, num>> stars) {
  for (var i = 0; i < stars.length; i++) {
    var star = stars[i];
    var x = star['x'];
    var y = star['y'];
    var radius = star['radius'];
    var innerRadius = star['innerRadius'];
    var spikes = star['spikes'];
    drawStar(canvas, x, y, radius,
        innerRadius: innerRadius, spikes: spikes);
  }
}

drawRandomStars(CanvasElement canvas, int count) {
  for (var i = 0; i < count; i++) {
    var x = randomNum(canvas.width);
    var y = randomNum(canvas.height);
    var spikes = randomRangeNum(5, 8);
    var radius = randomNum(spikes * 2);
    var innerRadius = randomNum(spikes);
    drawStar(canvas, x, y, radius,
        innerRadius: innerRadius, spikes: spikes);
  }
}

// maxWidth in pixels
drawTag(CanvasElement canvas, num x, num y, String text,
    {String font: 'sans-serif', num size: 16, String align: 'center',
     num maxWidth, String color: 'black'}) {
  var context = canvas.getContext('2d');
  context
      ..font = '${size}px ${font}'
      ..fillStyle = color
      ..textAlign = align;
  context.beginPath();
  if (maxWidth == null) {
    context.fillText(text, x, y);
  } else {
    context.fillText(text, x, y, maxWidth);
  }
  context.closePath();
}

drawOneOfTags(CanvasElement canvas, num x, num y, String text,
    {String font: 'sans-serif', num size: 16, String align: 'center',
     num maxWidth, String color: 'black'}) {
  var context = canvas.getContext('2d');
  context
      ..font = '${size}px ${font}'
      ..fillStyle = color
      ..textAlign = align;
  if (maxWidth == null) {
    context.fillText(text, x, y);
  } else {
    context.fillText(text, x, y, maxWidth);
  }
}

drawTriangleWithinSquare(CanvasElement canvas, num x, num y, num length,
    {num lineWidth: 1, color: 'white', String borderColor: 'black'}) {
  var context = canvas.getContext('2d');
  //var height = 100 * (sqrt(3) / 2);
  context
      ..lineWidth = lineWidth
      ..fillStyle = color
      ..strokeStyle = borderColor
      ..beginPath()
      ..moveTo(x + length / 2, y)
      ..lineTo(x + length, y + length)
      ..lineTo(x, y + length)
      //..lineTo(x + length / 2, y) // closePath does it
      ..closePath()
      ..fill()
      ..stroke();
}

drawVehicle(CanvasElement canvas, num x, num y, num width, num height,
    {num radius: 10, num lineWidth: 1, String color: 'white',
     String borderColor: 'black'}) {
  var context = canvas.getContext('2d');
  drawRoundedRect(canvas, x, y, width, height, radius: radius,
      lineWidth: lineWidth, color: color, borderColor: borderColor);
  context
      ..fillStyle = '#000000'
      ..beginPath()
      ..rect(x + 12, y - 3, 14, 6)
      ..rect(x + width - 26, y - 3, 14, 6)
      ..rect(x + 12, y + height - 3, 14, 6)
      ..rect(x + width - 26, y + height - 3, 14, 6)
      ..closePath()
      ..fill();
}






