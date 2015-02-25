part of rush;

class Areas extends Concepts {
  Area getArea(String code) {
    for (Area area in this) {
      if (area.code == code) {
        return area;
      }
    }
    return null;
  }
}

class Area extends Concept {
  String code;

  Parkings parkings;

  Area(this.code) {
    parkings = new Parkings.ofArea(this);
  }

  String toString() {
    return 'Area: ${oid.timeStamp} ${code}';
  }
}
