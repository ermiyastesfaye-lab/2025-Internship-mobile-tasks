// Represents a product with a unique id, name, description and price
class Product {
  int id;
  String name;
  String description;
  double _price;

  static int _counter = 0;

  Product._(this.id, this.name, this.description, this._price);

  // Factory constructor that creates a new [Product] with a unique ID.
  factory Product(String name, String description, double price) {
    // Increment the counter and assign the new product ID
    int id = _counter++;
    return Product._(id, name, description, price);
  }

  double get price => _price;

  // Set the price for the product.
  set price(double newPrice) {
    if (newPrice >= 0) {
      _price = newPrice;
    } else {
      throw ArgumentError("Price can't be negative");
    }
  }
}
