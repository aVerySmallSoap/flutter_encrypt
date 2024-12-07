class Crumbs {
  int id;
  Object data;

  Crumbs({
    required this.id,
    required this.data,
  });

  void update(Object o) {
    data = o;
  }
}
