part of d_art;

class Board extends Object with shape.Surface {
  Map<String, String> colors;
  d_pen.Pen pen;
  d_pen.ArtRepo artRepo;

  Board(CanvasElement canvas, this.artRepo) {
    this.canvas = canvas;
    colors = util.colorMap();
    pen = new d_pen.Pen(artRepo);
    pen.spaceWidth = width;
    pen.spaceHeight = height;
    draw();
  }

  draw() {
    for (d_pen.Segment segment in pen.segments) {
      if (segment.visible) {
        context.beginPath();
        for (d_pen.Line line in segment.lines) {
          shape.drawOneOfLines(canvas, line.beginX, line.beginY, line.endX,
              line.endY, lineWidth: segment.width, color: colors[segment.color]);
          if (segment.text != null && segment.text.trim() != '') {
            var x = (line.beginX + line.endX) / 2;
            var y = (line.beginY + line.endY) / 2;
            shape.drawOneOfTags(canvas, x + 2, y - 2, segment.text, maxWidth: line.pixels);
          }
        }
        context.stroke();
        context.closePath();
      }
    }
  }
}

