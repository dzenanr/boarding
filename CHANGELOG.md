
## Version history of [boarding](http://pub.dartlang.org/packages/boarding)

*0.2.6* 2015-04-13

+ add the default constructor to all classes in util
+ prepare classes in model/pieces/pieces.dart as mixins
+ prepare classes in model/grid/composition.dart as mixins
+ prepare the Composition class in model/grid/composition.dart as mixin
+ prepare the Surface class in view/surface.dart as mixin
in order to use mixins
+ move MovablePiece into Piece
+ move MovablePieces into Pieces
+ update examples

*0.2.5* 2015-04-09

+ add lanes example
+ use loop index for piece id in the bonhomme, invaders & stars games
+ add firstWhere in Pieces in model/pieces/pieces.dart
+ add order game

*0.2.4* 2015-03-29 (Pub)

+ rename text.dart to tag.dart in util
+ remove the restriction of even size only in MazeGrid in model/grid/grid.dart
+ change int get rowCount => table.size.ColumnCount; to int get rowCount => table.size.rowCount;
  in Grid in model/grid/grid.dart
+ remove print(msg); from Memory in the memory game

*0.2.4* 2015-03-28

+ add text to index.html in the maze example
+ add cellPiece and randomCellPiece methods to Grid in model/grid/grid.dart

+ move MazeGrid and MazeCell from the maze example to model/grid/grid.dart
+ adapt the maze example (simpler)

+ add an exception for an odd grid size in MazeGrid in model/grid/grid.dart

+ add swap method to CellPiece in model/grid/cell_pieces.dart
+ add isNeighborOf method to CellPiece
+ use column before row in the fromJsonList method in CellPieces
+ use the swap method in the move method in CellPieces in model/grid/cell_pieces.dart
+ use the recursion in the merge method in CellPieces in model/grid/cell_pieces.dart
+ add draw method with isGameOver check in Board in the d2048 game
+ use the LEFT, RIGHT key codes before the UP, DOWN key codes in Board in the d2048 game
+ set isGameOver to false in the load method in Board
+ use the tag size (not area) in the invaders game
+ extend the Direction enum with LEFT_UP, RIGHT_UP, LEFT_DOWN and RIGHT_DOWN in util/geo.dart
+ add diagonal directions in the move method in CellPiece in model/grid/cell_pieces.dart
+ type return in the isNeighborOf method in CellPiece
+ add diagonal directions in isNeighborOf
+ rename the isNeighborOf method to isDirectNeighborOf
+ add isDiagonalNeighborOf and new isNeighborOf methods to CellPiece
+ add diagonal neighbors in the neighbor method in CellPieces in model/grid/cell_pieces.dart
+ add diagonal directions in the move method in MovablePiece in model/pieces/pieces.dart
+ add DirectDirection and DiagonalDirection enums in util/geo.dart
+ add randomDirectDirection and randomDiagonalDirection methods in util/geo.dart
+ use DirectDirection in the path method in MazeGrid in model/grid/grid.dart
+ rename rds to dds and rd to dd variables in the path method

*0.2.4* 2015-03-27

+ use canvas width and height only for the area property in the Surface class in view/surface.dart
+ remove the offset property from Surface
+ update the Board class in the breakout example to use canvas.offset
+ update the Racket class in the pingpong example to use canvas.offset

+ add the randomCell method to the Table class in util/geo.dart
+ add isMarked property to the Tage class in util/text.dart
+ add maze generation example

+ use isMarked from Tag in MazeGrid to find a path
+ rename the gen method to path in MazeGrid

*0.2.4* 2015-03-26

+ rename Size to Area (width, height) in util/geo.dart
+ add new Size with columnCount and rowCount in geo.dart
+ add Table with Size that extends Box in geo.dart
+ add Cell with column and row in geo.dart
+ add isIn and similar methods to Cell
+ rename MinMaxSize to MinMaxArea in geo.dart
+ update constructor names from .fromJsonMap to .fromJson in util
+ update Composition in model/grid/composition.dart to use Cell
+ rename cell.dart to cell_pieces.dart in model/grid
+ update CellPiece in cell_pieces.dart to use Cell
+ move from CellPiece to Tag the number property and related methods
+ update CellPieces to use tag.number instead of number
+ add compareTo to Tag
+ move compareTo from CellPiece to Piece and use compareTo from Tag
+ update Grid in model/grid/grid.dart to use Table from util/geo.dart
+ add convenience getters to Grid based on Table
+ use Area instead of Size in Surface in view/surface.dart
+ update tests
+ update all examples

*0.2.4* 2015-03-25

+ use the randomExtraInit method in Creature in the invaders example
+ check for isCovered in Board.draw() in the invaders example
+ add size property to Grid in model/grid/grid.dart
+ rename the size property in SquareGrid to length
+ simplify the cells method in Surface in view/surface.dart
+ add drawFaceWithinSquare function to view/shapes.dart
+ add FACE to enum PieceShape in model/pieces/pieces.dart
+ add case for FACE in the drawPiece method of Surface in view/surface.dart 
+ add gold_digger example

*0.2.4* 2015-03-24

+ add randomRareTrue function to util/random.dart
+ add isTagged property to the Piece class in model/pieces.dart
+ update json methods in Piece
+ use isCovered and isTagged in the randomExtraInit method in Piece
+ in the cells method of the Surface class in the view/surface.dart,
  prepare a cell piece and draw it with the drawPiece method
+ add in drawPiece tests for isVisible, isCovered and isTagged
+ update examples

*0.2.4* 2015-03-23

+ add Color class to util/color.dart
+ rename usedColors to usedColorNames
+ rename colorList to colorNameList
+ rename the getNotUsedColor method to getNotUsedColorName
+ add getNotUsedColor method
+ add Tag class to new util/text.dart
+ rename the randomColor method to randomColorName
+ rename the randomColorCode method to randomColor
+ rename the LinePath class to Line in util/geo.dart
+ add 2 positions to Line
+ add static random method with the Size parameter to Line
+ rename linePath to line in Piece in model/pieces/pieces.dart
+ replace color and text String properties in Piece with Color and Text properties
+ update json methods in Piece
+ update the randomInit method in Piece
+ update the drawTagLine and drawOneOfLines functions in view/shapes.dart
+ update the drawTag and drawOneOfTags functions in view/shapes.dart
+ update the drawPiece method in view/surface.dart
+ use Color in view/surface.dart
+ use Size in view/surface.dart
+ use fixed position and size Box in the Piece constructor
+ include random space and random box in the randomInit method in the Piece class
+ rename Cell in model/grid/cell.dart into CellPiece
+ extend CellPiece with Piece
+ add isCovered (former isHidden) in Piece
+ add p_art example
+ update tests
+ update examples
+ add bonhomme example

*0.2.4* 2015-03-21

+ add movablePieces and avoidCollisions properties to Surface in view/surface.dart
+ add movablePieces and avoidCollisions optional named parameters to Surface constructor
+ include movablePieces and conditional avoidCollisions in draw of Surface
+ add (minimal) move example without specific model and view

*0.2.3* 2015-03-21 (Pub)

+ clouds move up in the invaders example
+ replace the creature image by another one

*0.2.3* 2015-03-20

+ add audioId to Piece in model/pieces.dart
+ add usesAudio to Piece in model/pieces.dart
+ update the invaders example to use a sound when a laser hits a creature
+ create a model in the invaders example to initialize moving pieces

+ add videoId to Piece in model/pieces.dart
+ add usesVideo to Piece in model/pieces.dart
+ update the invaders example to show a video at the end of the game

*0.2.3* 2015-03-19

+ add drawPosition to shapes
+ add drawPolygon to shapes
+ add drawPolygonWithinSquare to shapes
+ add POLYGON to enum PieceShape in model/pieces/pieces.dart
+ add case PieceShape.POLYGON to Surface in view/surface.dart
+ add LinePath to util/geo.dart
+ use LinePath for linePath property in Piece in model/pieces.dart
+ move lineWidth in Piece to linePath as width
+ add tests

+ add String imageId property to Piece in model/pieces/pieces.dart
+ add IMG to enum PieceShape in pieces.dart
+ add case PieceShape.IMG to Surface in view/surface.dart
+ move enum Direction from Cell in model/grid/cell.dart to util/geo.dart
+ update import in examples 
+ add invaders example with images

*0.2.3* 2015-03-18

+ add Speed class to util/geo.dart
+ use speed of Speed instead of dx and dy in MovablePiece
+ update the crash example
+ update the dash example
+ update the pingpong example
+ move the Ball and Racket view classes to model/gear.dart in the breakout example
+ add increase, double, decrease and changeDirection in Speed of util/geo.dart
+ add increase, double and decrease in Size of util/geo
+ add increaseWithin, doubleWithin and decreaseWithin in Size of util/geo.dart
+ add stayWithinSpace in Box of util/geo.dart
+ add jump to MovablePiece
+ add changeDirectionIfOutOfSpace to MovablePiece
+ add stars example

*0.2.2* 2015-03-16 (Pub)

+ cleanup function parameters in shapes
+ sort functions in shapes by the following the order in enum PieceShape

*0.2.2* 2015-03-15

+ use only functions in shapes
+ update tests
+ update drawPiece in Surface in surface
+ update examples
+ add a white line in the middle of the table in the pingpong example
+ resolve why some circles are partially out of canvas in the bounce example
+ when the red car is small, hit a car that is not moving to propel it in the crash example
+ add drawEllipseWithinRect in shapes
+ add drawCircleWithinSquare in shapes
+ add drawTriangleWithinSquare in shapes
+ add ELLIPSE and TRIANGLE to enum PieceShape in pieces
+ update tests
+ add lineWidth property to Piece in pieces
+ update drawPiece in Surface in surface

*0.2.2* 2015-03-14

+ remove Point, Dimension and Distance classes from pieces
+ remove optional distance parameter in MovablePiece constructor
+ remove randomPosition based on random distance in MovablePiece
+ remove optional distance parameter in MovablePieces constructor
+ remove optional distance parameter in createMovablePieces in MovablePieces
+ add util/geo.dart
+ add Position, Size, Box, MinMaxSize and MinMaxSpace classes to geo.dart
+ remove x, y and dimension properties in Piece
+ use box, minMaxSize and minMaxSpace properties in Piece
+ update json methods in Piece 
+ update the randomInit method in Piece
+ add get and set for x, y, width and height derived properties in Piece
+ remove distance property in MovablePiece
+ add _space property in Piece
+ update json methods in Piece and MovablePiece 
+ add get and set for _space property in Piece
+ validate positions in set space
+ update the randomInit method in Piece
+ add the randomPosition method in Piece
+ update the randomInit method in MovablePiece
+ update the move method in MovablePiece

*0.2.2* 2015-03-13

+ add Dimension and Distance classes to pieces
+ use Dimension in Piece
+ use Distance in MovablePiece
+ add optional distance parameter to MovablePiece constructor
+ add randomPosition based on random distance in MovablePiece
+ add optional distance parameter to MovablePieces constructor
+ add optional distance parameter to createMovablePieces in MovablePieces
+ rename randomSequence to randomCommandSequence in programs in the art_pen model
+ update examples to use distance
+ improve the move method in RedCar in the crash example
+ add star as a new shape in pieces and shapes
+ add Point class in pieces

*0.2.2* 2015-03-12

+ make speed a derived property in MovablePiece
+ remove spped from json
+ rename colorCode to color in Piece
+ add borderColor to Piece
+ add color to Surface
+ include border color in draw piece in Surface
+ add distance function in pieces
+ add accelerate function in pieces
+ add drawRandomStars and drawStar in shapes
+ add prepareStars and drawStars in shapes
+ add drawDistanceLine in shapes
+ replace surface by canvas in shapes
+ rename shape.dart to shapes.dart
+ add gameLoop to Surface
+ window.animationFrame.then(gameLoop); to Surface
+ add attract example
+ correct bug in getSelectedCarAfterOrBeforeCell of Cars in the rush example

*0.2.1* 2015-03-10 (Pub)

+ move the accident method from RedCar in the crash example to MovablePiece
+ rename the accident method to hit
+ remove the FallingPiece class in pieces
+ remove the FallingPieces class in pieces
+ replace the move method with move([Direction direction]) of MovablePiece in pieces
+ replace FallingPiece with MovablePiece in Board of the drop example
+ show Direction in import in the crash and drop examples
+ add 'black' and 'white' to color list in util
+ rename randomNumber to randomSignNum in util
+ add more random tests
+ add dash example
+ rename distanceWidth to distanceMaxWidth of MovablePiece in pieces
+ rename distanceHeight to distanceMaxHeight of MovablePiece in pieces
+ add distanceMinWidth to MovablePiece 
+ add distanceMinHeight to MovablePiece

*0.2.1* 2015-03-08

+ add drawPiece method in Surface 
+ use drawPiece in Bricks of the breakout example
+ use drawPiece in Board of the crash example
+ use drawPiece in Board of the drop example
+ square hit changes only the square shape to rounded rectangle in the drop example
+ use Tag for the win message in Board of the memory example 
+ rename random range to random range num in util
+ rename the grids library to grid
+ simplify random functions
+ rename RECTANGLE to RECT in PieceShape enum
+ rename ROUNDED_RECTANGLE to ROUNDED_RECT in PieceShape enum
+ add SELECT_RECT to PieceShape enum
+ update drawPiece method in Surface

*0.2.1* 2015-03-07

+ add bounce example
+ add drawPiece in Board of the chaos example
+ correct the load method in Board of the drop example
+ use enum values in json for random shape in pieces
+ add random range in util
+ use random range in random init of pieces

*0.2.0* 2015-03-05 (Pub)

+ save (and load) pieces to (from) the local storage

*0.1.9* 2015-03-04

+ save (and load) grid cells to (from) the local storage
+ save (and load) the best score to (from) the local storage

*0.1.8* 2015-03-03

+ add d2048 example

*0.1.7* 2015-02-25

+ add rush example
+ add breakout example
+ add pingpong example

*0.1.6* 2015-02-24

+ add crash example

*0.1.5* 2015-02-23

+ add falling pieces
+ add drop example

*0.1.4* 2015-02-23

+ add avoid collisions
+ add art pen (with dartling)
+ add run programs and random commands
+ reorganize libraries

*0.1.3* 2015-02-19

+ add moving pieces in the model
+ add abstract class Shape in the view
+ add Chaos example

*0.1.2* 2015-01-27

+ const names are not any more in capital letters

*0.1.1* 2014-02-14 (Pub)

+ move return false to the end of the intersects method in the model/Cell class
+ use var for a local variable in the ttt example

*0.1.0* 2014-02-10 (Pub)

+ create the initial boarding package

