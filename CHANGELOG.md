## Version history of [boarding](http://pub.dartlang.org/packages/boarding)

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

