import 'package:unittest/unittest.dart';
import 'package:boarding/util.dart';

testUtil() {
  group('Testing utilities', () {
    test('Random number', () {
      var rn = randomNum(10);
      expect(rn, lessThan(10));
    });
    test('Random integer', () {
      var ri = randomInt(10);
      expect(ri, lessThan(10));
    });
    test('Random list element', () {
      var list = [22, 45.8, 33.8, 44, 8];
      var re = randomElement(list);
      expect(list.contains(re), isTrue);
    });
    test('Random color', () {
      var rc = randomColor();
      expect(colorList().contains(rc), isTrue);
    });
    test('Random color code', () {
      var rcc = randomColorCode();
      print(rcc);
      expect(colorMap().containsValue(rcc), isTrue);
    });
  });
}

main() {
  testUtil();
}
