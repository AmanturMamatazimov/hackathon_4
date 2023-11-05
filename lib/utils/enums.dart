class NavbarItem {
  final String name;
  NavbarItem._(this.name);
  @override
  String toString() => 'NavbarItem.$name';
  int get index => values.indexOf(this);

  static NavbarItem home = NavbarItem._('home');
  static NavbarItem catalog = NavbarItem._('catalog');
  static NavbarItem cart = NavbarItem._('basket');
  static NavbarItem profile = NavbarItem._('profile');

  static List<NavbarItem> values = [home, catalog, cart, profile];

  static NavbarItem named(String name) =>
      values.firstWhere((brand) => brand.name == name);
}
