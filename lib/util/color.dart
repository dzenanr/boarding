part of util;

List usedColorNames = [];

Map<String, String> sevenColorCode = {
  'azure':      '#f0ffff',
  'beer':       '#fbb117',
  'coral':      '#ff7f50',
  'cream':      '#ffffcc',
  'gold':       '#ffd700',
  'ivory':      '#fffff0',
  'lightblue':  '#add8e6'
};


List<String> sevenColorNames = [
  'azure',
  'beer',
  'coral',
  'cream',
  'gold',
  'ivory',
  'lightblue'
];

// http://www.colorhexa.com/
Map<String, String> sevenColorTint = {
  '#f0ffff': '#ffffff',
  '#fbb117': '#fcc249',
  '#ff7f50': '#ff926a',
  '#ffffcc': '#ffffe6',
  '#ffd700': '#ffdf33',
  '#fffff0': '#ffffff',
  '#add8e6': '#c1e1ec'
};

Map<String, String> colorCode = {
  'azure':      '#f0ffff',
  'beer':       '#fbb117',
  'beige':      '#f5f5dc',
  'black':      '#000000',
  'blue':       '#0000ff',
  'brown':      '#963939',
  'chocolate':  '#d2691e',
  'coral':      '#ff7f50',
  'cornyellow': '#fff380',
  'cream':      '#ffffcc',
  'crimson':    '#e238ec',
  'cyan':       '#00ffff',
  'darkblue':   '#0000a0',
  'gold':       '#ffd700',
  'grapefruit': '#dc381f',
  'gray':       '#909090',
  'green':      '#009000',
  'ivory':      '#fffff0',
  'khaki':      '#f0e68c',
  'lightblue':  '#add8e6',
  'lightgray':  '#f8f8f8',
  'lime':       '#00ff00',
  'linen':      '#faf0e6',
  'magenta':    '#ff00ff',
  'maroon':     '#800000',
  'olive':      '#808000',
  'orange':     '#ff6f00',
  'peach':      '#ffe5b4',
  'pearl':      '#fdeef4',
  'pink':       '#faafbe',
  'red':        '#ff0000',
  'silver':     '#c0c0c0',
  'sunyellow':  '#ffe87c',
  'teagreen':   '#ccfb5b',
  'turquoise':  '#43c6db',
  'vanilla':    '#f3e5ab',
  'water':      '#ebf4fa',
  'wheat':      '#f5deb3',
  'white':      '#ffffff',
  'yellow':     '#ffff00'
};

List<String> colorNames = [
  'azure',
  'beer',
  'beige',
  'black',
  'blue',
  'brown',
  'chocolate',
  'coral',
  'cornyellow',
  'cream',
  'crimson',
  'cyan',
  'darkblue',
  'gold',
  'grapefruit',
  'gray',
  'green',
  'ivory',
  'khaki',
  'lightblue',
  'lightgray',
  'lime',
  'linen',
  'magenta',
  'maroon',
  'olive',
  'orange',
  'peach',
  'pearl',
  'pink',
  'red',
  'silver',
  'sunyellow',
  'teagreen',
  'turquoise',
  'vanilla',
  'water',
  'wheat',
  'white',
  'yellow'
];

String getNotUsedColorName() {
  var name;
  do {
    name = randomColorName();
  } while (usedColorNames.any((c) => c == name));
  usedColorNames.add(name);
  return name;
}

String getNotUsedColor() {
  return colorCode[getNotUsedColorName()];
}

class Color { // codes
  static const String defaultMain =   '#ffffff'; // white
  static const String defaultBorder = '#000000'; // black
  static const String defaultCover =  '#6d7b8d'; // light slate gray

  String main = defaultMain;
  String border = defaultBorder;
  String cover = defaultCover;

  Color();

  Color.from(this.main);

  Color.fromJson(Map<String, String> jsonMap) {
    main = jsonMap['main'];
    border = jsonMap['border'];
    cover = jsonMap['cover'];
  }

  Map<String, String> toJsonMap() {
    var jsonMap = new Map<String, String>();
    jsonMap['main'] = main;
    jsonMap['border'] = border;
    jsonMap['cover'] = cover;
    return jsonMap;
  }

  static Color random() {
    var color = new Color();
    color.main = randomColor();
    color.border = randomColor();
    color.cover = randomColor();
    return color;
  }
}




