part of util;

class Tag {
  String text;
  String font = 'sans-serif';
  num size = 16;
  String align = 'center';
  num maxWidth; // in pixels
  var color = new Color();
  num _number = 0;
  
  Tag([this.text = '']);
   
  Tag.fromJson(Map<String, Object> jsonMap) {
    text = jsonMap['text'];
    font = jsonMap['font'];
    size = jsonMap['size'];
    align = jsonMap['align'];
    maxWidth = jsonMap['maxWidth'];
    color = new Color.fromJson(jsonMap['color']);
    _number = jsonMap['number'];
  }

  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
    jsonMap['text'] = text;
    jsonMap['font'] = font;
    jsonMap['size'] = size;
    jsonMap['align'] = align;
    jsonMap['maxWidth'] = maxWidth;
    jsonMap['color'] = color.toJsonMap();
    jsonMap['number'] = _number;
    return jsonMap;
  }
  
  num get number => _number;
  set number(num n) {
    _number = n;
    text = _number.toString();
  }
  
  empty() => text = '';
  bool get isEmpty => text == '';
  
  /**
   * Compares two tags based on numbers.
   * If the result is less than 0 then the first tag is less than the second tag,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first tag is greater than the second tag.
   */
  int compareTo(Tag t) {
    return number.compareTo(t.number);
  }
  
  static Tag random() {
    var tag = new Tag();
    tag.text = randomElement(colorNameList());
    tag.size = randomRangeInt(8, 64);
    tag.color = Color.random();
    return tag;
  }
}