part of d_art;

class Board extends shape.Surface { 
  Map<String, String> colors;
  d_pen.Pen pen;
  d_pen.ArtRepo artRepo;
  
  Board(CanvasElement canvas, this.artRepo) : super(canvas) {
    colors = util.colorMap();
    pen = new d_pen.Pen(artRepo);
    pen.drawingWidth = width;
    pen.drawingHeight = height;
    draw();
  }
  
  draw() {
    clear();
    for (d_pen.Segment segment in pen.segments) {
      if (segment.visible) {
        context.beginPath();
        for (d_pen.Line line in segment.lines) {
          new shape.OneOfLines(this, line.beginX, line.beginY, line.endX, line.endY, 
              lineWidth: segment.width, color: colors[segment.color]).draw(); 
          if (segment.text != null && segment.text.trim() != '') {
            var x = (line.beginX + line.endX) / 2;
            var y = (line.beginY + line.endY) / 2;
            new shape.OneOfTags(this, x + 2, y - 2, 14, segment.text, maxWidth: line.pixels).draw(); 
          }
        }
        context.stroke();
        context.closePath();
      }
    }
  }
}

