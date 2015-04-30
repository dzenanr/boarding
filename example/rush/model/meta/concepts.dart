part of rush;

class Concepts {

  List<Concept> list;

  Concepts() {
    list = new List<Concept>();
  }

  void add(Concept concept) {
    list.add(concept);
  }

  Iterator<Concept> get iterator => list.iterator;
  void forEach(f(Concept concept)) { list.forEach(f); }
}
