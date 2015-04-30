import 'package:test/test.dart';
import 'package:boarding/util.dart';

void testUtil() {
  group('Testing utilities', () {
    test('Random integer', () {
      var r = randomInt(10);
      expect(r, lessThan(10));
    });
    test('Random double', () {
      var r = randomDouble(1.9);
      expect(r, lessThan(1.9));
    });
    test('Random number', () {
      var r = randomNum(10.1);
      expect(r, lessThan(10.1));
    });
    test('Random range number', () {
      var r = randomRangeNum(0.8, 9.9);
      expect(r, inClosedOpenRange(0.8, 9.9));
    });
    test('Random range number', () {
      var r = randomRangeNum(400, 400);
      expect(r, equals(400));
    });
    test('Random sign number', () {
      var r = randomSignNum(10);
      expect(r, inClosedOpenRange(-10, 10));
    });
    test('Random list element', () {
      var list = [22, 45.8, 33.8, 44, 8];
      var r = randomElement(list);
      expect(list.contains(r), isTrue);
    });
    test('Random color', () {
      var r = randomColorName();
      expect(colorNames.contains(r), isTrue);
    });
    test('Random color code', () {
      var r = randomColor();
      expect(colorCode.containsValue(r), isTrue);
    });
    test('Random bool', () {
      var r = randomBool();
      expect(r, anyOf([isTrue, isFalse]));
    });
    test('Random sign', () {
      var r = randomSign(10);
      expect(r, anyOf([-1, 1]));
    });
  });
}

void main() {
  testUtil();
}
