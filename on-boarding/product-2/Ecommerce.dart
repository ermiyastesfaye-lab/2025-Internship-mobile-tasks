import 'productManager.dart';

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
