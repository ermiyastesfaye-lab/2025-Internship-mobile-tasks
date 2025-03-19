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

class ProductManager {
  Map<int, Product> inventory = {};

  // Add a new product to the inventory
  void addProduct(
      {required String name,
      required String description,
      required double price}) {
    if (name.isEmpty) {
      throw ArgumentError("Product name cannot be empty");
    }

    if (description.isEmpty) {
      throw ArgumentError("Price cannot be negative");
    }
    var product = Product(name, description, price);
    inventory[product.id] = product;
  }

  // Display all the products in the inventory
  void viewProducts() {
    print(
        "___________________________VIEW ALL PRODUCTS____________________________________________");
    print("");

    for (Product product in inventory.values) {
      print('''
      Product Id: ${product.id} 
      Name of the product: ${product.name} 
      Product Description: ${product.description}
      Price of a product: \$${product.price}''');
      print("---------------------------------------------------------------");
    }

    print(
        "___________________________END___________________________________________");
    print("");
  }

  // Display the product with the specified id in the inventory
  void viewProduct(int id) {
    print(
        "___________________________HERE IS THE PRODUCT WITH ID $id!____________________________________________");
    print("");

    var product = inventory[id];
    if (product != null) {
      print('''
    Product Id: ${product.id} 
    Name of the product: ${product.name} 
    Product Description: ${product.description}
    Price of a product: \$${product.price}''');
    } else {
      throw ArgumentError("Product with ID $id not found!");
    }

    print(
        "___________________________END____________________________________________");
    print("");
  }

  // Edit the details of an existing product in the invetory.
  void editProduct(int id, {String? name, String? description, double? price}) {
    var product = inventory[id];
    if (product != null) {
      if (name != null) {
        product.name = name;
      }

      if (description != null) {
        product.description = description;
      }

      if (price != null) {
        product.price = price;
      }
    } else {
      throw ArgumentError("Product with ID $id not found!");
    }
  }

  // Delete the product with the specified id from the inventory
  void deleteProduct(int id) {
    if (inventory.containsKey(id)) {
      inventory.remove(id);
      print("Product with Id $id has been deleted!");
    } else {
      throw ArgumentError("Product with ID $id not found!");
    }
  }
}

void main() {
  ProductManager productManager = ProductManager();

  productManager.addProduct(
      name: "Smart Water Bottle",
      description:
          "A self-cleaning water bottle with a built-in UV light to purify water and keep it fresh.",
      price: 49.99);
  productManager.addProduct(
      name: "Wireless Earbuds",
      description:
          "Noise-canceling Bluetooth earbuds with 24-hour battery life and a sleek charging case.",
      price: 79.99);
  productManager.addProduct(
      name: "Mini Projector",
      description:
          "A portable projector that fits in your palm, perfect for movie nights and presentations.",
      price: 129.99);

  productManager.viewProducts();

  productManager.viewProduct(1);

  productManager.editProduct(0, name: "Smart water", price: 55.3);

  productManager.viewProducts();

  productManager.deleteProduct(0);

  productManager.viewProducts();
}
