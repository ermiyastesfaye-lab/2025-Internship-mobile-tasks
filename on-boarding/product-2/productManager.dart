import 'product.dart';

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
