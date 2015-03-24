part of util;

class Tag {
  String text;
  String font = 'sans-serif';
  num size = 16;
  String align = 'center';
  num maxWidth; // in pixels
  var color = new Color();
  
  Tag([this.text = '']);
   
  Tag.fromJsonMap(Map<String, Object> jsonMap) {
    text = jsonMap['text'];
    font = jsonMap['font'];
    size = jsonMap['size'];
    align = jsonMap['align'];
    maxWidth = jsonMap['maxWidth'];
    color = new Color.fromJsonMap(jsonMap['color']);
  }

  Map<String, Object> toJsonMap() {
    var jsonMap = new Map<String, Object>();
    jsonMap['text'] = text;
    jsonMap['font'] = font;
    jsonMap['size'] = size;
    jsonMap['align'] = align;
    jsonMap['maxWidth'] = maxWidth;
    jsonMap['color'] = color.toJsonMap();
    return jsonMap;
  }
  
  static Tag random() {
    var tag = new Tag();
    tag.text = randomElement(colorNameList());
    tag.size = randomRangeInt(8, 64);
    tag.color = Color.random();
    return tag;
  }
}