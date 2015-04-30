part of art_pen;

class Pen {
  static final num angle = 0;
  static final num steps = 80;
  static final int repeat = 0;

  static final int randomMaxInt = 8;
  static final num randomMaxNum = 665.99;
  static final num randomAngleMax = 360.0;
  static final num randomStepsMax = 180.0;
  static final int randomRepeatMax = 36;

  int spaceWidth;
  int spaceHeight;
  String _color;
  int _width;
  bool _down;
  String _write;
  bool visible;

  PenEntries penEntries;
  Segments segments;
  Segment lastSegment;
  Concept lineConcept;
  Line lastLine;

  List<List> commands;

  Pen(ArtRepo artRepo) {
    var artModels = artRepo.getDomainModels(ArtRepo.artDomainCode);
    penEntries = artModels.getModelEntries(ArtRepo.artPenModelCode);
    segments = penEntries.getEntry('Segment');
    lineConcept = penEntries.model.getConcept('Line');
    _init();
  }

  void _init() {
    _color = 'black';
    _width = 1;
    _down = true;
    _write = '';
    visible = true;
    spaceWidth = 600;
    spaceHeight = 400;

    lastSegment = new Segment(segments.concept);
    lastSegment.visible = _down;
    segments.add(lastSegment);
    lastLine = null;

    commands = new List<List>();
  }

  void erase() {
    segments.clear();
    _init();
  }

  num get startX => spaceWidth / 2;
  num get startY => spaceHeight / 2;

  void set color(String color) {
    _color = color;
    if (!lastSegment.lines.isEmpty) {
      lastSegment = new Segment(segments.concept);
      segments.add(lastSegment);
    }
    lastSegment.color = color;
    lastSegment.width = width;
    lastSegment.visible = down;
    lastSegment.text = write;
    commands.add(['color', _color]);
  }

  String get color => _color;

  void set width(int width) {
    if (width == 0) {
      _width = 1;
    } else {
      _width = width;
    }
    if (!lastSegment.lines.isEmpty) {
      lastSegment = new Segment(segments.concept);
      segments.add(lastSegment);
    }
    lastSegment.width = width;
    lastSegment.color = color;
    lastSegment.visible = down;
    lastSegment.text = write;
    commands.add(['width', _width]);
  }

  int get width => _width;

  void set down(bool down) {
    _down = down;
    if (!lastSegment.lines.isEmpty) {
      lastSegment = new Segment(segments.concept);
      segments.add(lastSegment);
    }
    lastSegment.visible = down;
    lastSegment.color = color;
    lastSegment.width = width;
    lastSegment.text = write;
    commands.add(['down', _down]);
  }

  bool get down => _down;

  void set write(String write) {
    _write = write;
    if (!lastSegment.lines.isEmpty) {
      lastSegment = new Segment(segments.concept);
      segments.add(lastSegment);
    }
    lastSegment.text = write;
    lastSegment.color = color;
    lastSegment.width = width;
    lastSegment.visible = down;
    commands.add(['write', _write]);
  }

  String get write => _write;

  void moveToStart() => moveTo(startX, startY);

  void moveTo(num x, num y) {
    if (lastLine == null) {
      lastLine = new Line.first(lastSegment.lines.concept, x, y);
    } else {
      lastLine = new Line.next(lastSegment.lines.concept, lastLine);
    }
    var previousLine = lastLine;
    lastLine = new Line.next(lastSegment.lines.concept, lastLine);
    lastLine.segment = lastSegment;
    lastLine.beginX = previousLine.endX;
    lastLine.beginY = previousLine.endY;
    lastLine.endX = x;
    lastLine.endY = y;
    lastLine.backOnBorder(spaceWidth, spaceHeight);
    lastSegment.lines.add(lastLine);
    commands.add(['moveTo', x, y]);
  }

  void move(num turn, [num steps= 0, int repeat= 0]) {
    if (lastLine == null) {
      lastLine = new Line.first(lastSegment.lines.concept, startX, startY);
    } else {
      lastLine = new Line.next(lastSegment.lines.concept, lastLine);
    }
    lastLine.segment = lastSegment;
    lastLine.angle = turn;
    lastLine.pixels = steps;
    lastLine.backOnBorder(spaceWidth, spaceHeight);
    lastSegment.lines.add(lastLine);

    if (repeat > 0) {
      for (var i = 0; i < repeat; i++) {
        lastLine =
            new Line.next(lastSegment.lines.concept, lastLine);
        lastLine.segment = lastSegment;
        lastLine.angle = turn;
        lastLine.pixels = steps;
        lastLine.backOnBorder(spaceWidth, spaceHeight);
        lastSegment.lines.add(lastLine);
      }
    }
    commands.add(['move', turn, steps, repeat]);
  }

  void art([int times = 1]) {
    for (var i = 0; i < times; i++) {
      _duplicate();
    }
    commands.add(['art', times]);
  }

  void _duplicate() {
    if (lastLine != null) {
      Segments copiedSegments = new Segments(segments.concept);
      for (Segment segment in segments) {
        Segment copiedSegment = new Segment(segment.concept);
        copiedSegment.color = segment.color;
        copiedSegment.width = segment.width;
        for (Line line in segment.lines) {
          Line copiedLine = new Line(line.concept);
          copiedLine.previousLine = line.previousLine;
          copiedLine.beginX = line.beginX;
          copiedLine.beginY = line.beginY;
          copiedLine.angle = line.angle;
          copiedLine.pixels = line.pixels;
          copiedLine.segment = copiedSegment;
          bool addedCopiedLine = copiedSegment.lines.add(copiedLine);
          if(!addedCopiedLine) {
            copiedSegment.lines.errors.display(title:
                'Error: copiedSegment.lines.add(copiedLine);');
          }
          assert(addedCopiedLine);
        }
        bool addedCopiedSegment = copiedSegments.add(copiedSegment);
        if(!addedCopiedSegment) {
          copiedSegment.lines.errors.display(title:
              'Error: copiedSegments.add(copiedSegment);');
        }
        assert(addedCopiedSegment);
      }

      for (Segment copiedSegment in copiedSegments) {
        for (Line copiedLine in copiedSegment.lines) {
          copiedLine.previousLine = lastLine;
          copiedLine.beginX = lastLine.endX;
          copiedLine.beginY = lastLine.endY;
          copiedLine.angle = copiedLine.angle;
          lastLine = copiedLine;
        }
        bool addedSegment = segments.add(copiedSegment);
        if(!addedSegment) {
          copiedSegment.lines.errors.display(title:
              'Error: segments.add(copiedSegment);');
        }
        assert(addedSegment);
        lastSegment = copiedSegment;
      }
    }
  }

  void right(num angle) {
    if (angle > 0) {
      move(angle);
    }
  }

  void left(num angle) {
    if (angle > 0) {
      move(-angle);
    }
  }

  void forward(num steps) {
    if (steps > 0) {
      move(0, steps);
    }
  }

  void backward(num steps) {
    if (steps > 0) {
      move(0, -steps);
    }
  }

  void go(num steps, {num angle: 0, int repeat: 0}) {
    var i = 0;
    while (i++ < repeat + 1) {
      move(0, steps);
      move(angle, 0);
    }
  }

  void skip(num steps, {num angle: 0, int repeat: 0}) {
    down = false;
    var i = 0;
    while (i++ < repeat + 1) {
      move(0, steps);
      move(angle, 0);
    }
    down = true;
  }

  void colorRandom() {color = util.randomColorName();}
  void widthRandom() {width = util.randomInt(randomMaxInt);}
  void downRandom() {down = util.randomBool();}

  void moveRandom() =>
      move(util.randomSign(randomMaxInt) * util.randomDouble(randomAngleMax),
          util.randomSign(randomMaxInt) * util.randomDouble(randomStepsMax),
          util.randomInt(randomRepeatMax));

  void moveToRandom() =>
      moveTo(util.randomDouble(randomMaxNum), util.randomDouble(randomMaxNum));

  void leftRandom() { left(util.randomDouble(randomAngleMax)); }
  void rightRandom() { right(util.randomDouble(randomAngleMax)); }
  void backwardRandom() { backward(util.randomDouble(randomStepsMax)); }
  void forwardRandom() { forward(util.randomDouble(randomStepsMax)); }

  void artRandom() {
    art(randomInt(randomMaxInt));
  }

  void goRandom() =>
      go(util.randomSign(randomMaxInt) * util.randomDouble(randomStepsMax),
          angle: util.randomSign(randomMaxInt) * util.randomDouble(randomAngleMax),
          repeat: util.randomInt(randomRepeatMax));

  void skipRandom() =>
      skip(util.randomSign(randomMaxInt) * util.randomDouble(randomStepsMax),
          angle: util.randomSign(randomMaxInt) * util.randomDouble(randomAngleMax),
          repeat: util.randomInt(randomRepeatMax));

  String fromCommands() {
    String result = '';
    for (var command in commands) {
      if (command.length > 1) { // skip commands without params
        String commandLine = command[0];
        if (commandLine != '') {
          for (var i = 1; i < command.length; i++) {
            commandLine = '$commandLine, ${command[i]}';
          }
          commandLine = '$commandLine;\n';
          result = '$result$commandLine';
        }
      }
    }
    return result;
  }

  List<List> _toCommands(String commandsString) {
    var commandList = new List<List>();
    var singleLine = commandsString.replaceAll('\n', '');
    var commandsWoutSpaces = singleLine.trim().replaceAll(' ', '');
    List commandStrings = commandsWoutSpaces.split(';');
    for (String commandString in commandStrings) {
      List commandElements = commandString.split(',');
      commandList.add(commandElements);
    }
    return commandList;
  }

  void interpret(String commandsString) {
    try {
      List<List> commandList = _toCommands(commandsString);
      for (var command in commandList) {
        if (command.length > 0) {
          switch(command[0]) {
            case 'color':
              color = command[1];
              break;
            case 'colorRandom':
              colorRandom();
              break;
            case 'width':
              width = int.parse(command[1]);
              break;
            case 'widthRandom':
              widthRandom();
              break;
            case 'down':
              String downString = command[1];
              if (downString == 'true') {
                down = true;
              } else if (downString == 'false') {
                down = false;
              }
              break;
            case 'downRandom':
              downRandom();
              break;
            case 'write':
              write = command[1];
              break;
            case 'moveToStart':
              moveToStart();
              break;
            case 'moveTo':
              moveTo(double.parse(command[1]), double.parse(command[2]));
              break;
            case 'moveToRandom':
              moveToRandom();
              break;
            case 'move':
              if (command.length == 2) {
                move(double.parse(command[1]));
              } else if (command.length == 3) {
                move(double.parse(command[1]), double.parse(command[2]));
              } else if (command.length == 4) {
                move(double.parse(command[1]), double.parse(command[2]),
                  int.parse(command[3]));
              }
              break;
            case 'moveRandom':
              moveRandom();
              break;
            case 'go':
              if (command.length == 2) {
                go(double.parse(command[1]));
              } else if (command.length == 3) {
                go(double.parse(command[1]), angle: double.parse(command[2]));
              } else if (command.length == 4) {
                go(double.parse(command[1]), angle: double.parse(command[2]),
                  repeat: int.parse(command[3]));
              }
              break;
            case 'goRandom':
              goRandom();
              break;
            case 'skip':
              if (command.length == 2) {
                skip(double.parse(command[1]));
              } else if (command.length == 3) {
                skip(double.parse(command[1]), angle: double.parse(command[2]));
              } else if (command.length == 4) {
                skip(double.parse(command[1]), angle: double.parse(command[2]),
                  repeat: int.parse(command[3]));
              }
              break;
            case 'skipRandom':
              skipRandom();
              break;
            case 'left':
              left(double.parse(command[1]));
              break;
            case 'leftRandom':
              leftRandom();
              break;
            case 'right':
              right(double.parse(command[1]));
              break;
            case 'rightRandom':
              rightRandom();
              break;
            case 'backward':
              backward(double.parse(command[1]));
              break;
            case 'backwardRandom':
              backwardRandom();
              break;
            case 'forward':
              forward(double.parse(command[1]));
              break;
            case 'forwardRandom':
              forwardRandom();
              break;
            case 'art':
              art(int.parse(command[1]));
              break;
            case 'artRandom':
              artRandom();
              break;
          } // switch
        } // if
      } // for
    } catch(e) {
      print('error in interpretation of commands -- $e');
    }
  }
  
  void displayCommands() {
    print('');
    commands.forEach((c) => print('${c.join(', ')};'));
  }
}
