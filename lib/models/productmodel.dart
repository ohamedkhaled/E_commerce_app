class Product {
  late String Name, Price, Discription, Category, Location, id;
  late int Quantity;

  Product(
      {required this.Name,
      required this.Price,
      required this.Discription,
      required this.Category,
      required this.Location});

  Product.Quantity(
      {required this.Quantity,
      required this.Name,
      required this.Price,
      required this.Discription,
      required this.Category,
      required this.Location});

  Product.id(
      {required this.id,
      required this.Name,
      required this.Price,
      required this.Discription,
      required this.Category,
      required this.Location});

  Product.name(String Name) {
    this.Name = Name;
  }
}
