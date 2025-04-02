# Clean Architecture Task - Product Feature

## Overview

This project implements a e-commerce app feature using the Clean Architecture pattern. It separates the codebase into distinct layers to ensure scalability, maintainability, and testability.

## Clean Architecture

The Clean Architecture pattern is used in this project to ensure separation of concerns and maintainability. It divides the application into three main layers:

1. **Domain Layer**:

   - The core of the application.
   - Contains business logic, entities, and use cases.
   - Independent of any external frameworks or libraries.

2. **Data Layer**:

   - Responsible for data handling, including fetching and storing data.
   - Contains models and repositories.
   - Converts raw data (e.g., JSON) into domain entities.

3. **Presentation Layer**:
   - Manages the user interface and user interactions.
   - Contains widgets, state management, and view models.

### Layer Interaction

- The **Presentation Layer** interacts with the **Domain Layer** through use cases.
- The **Domain Layer** interacts with the **Data Layer** through repository interfaces.
- The **Data Layer** implements these repository interfaces to fetch or persist data.

### Benefits of Clean Architecture

- **Testability**: Each layer can be tested independently.
- **Scalability**: Easy to add new features without affecting other layers.
- **Maintainability**: Clear separation of concerns makes the codebase easier to understand and modify.

## Project Structure

The project is organized into the following layers:

- **Domain Layer**: Contains business logic and entities.
- **Data Layer**: Handles data models and data sources (e.g., APIs, databases).
- **Presentation Layer**: Manages UI and user interaction.

### Key Folders

- `features/product/domain`: Contains entities and use cases.
- `features/product/data`: Contains models and repositories.
- `features/product/presentation`: Contains UI components and state management.

## Key Files

### `product_model.dart`

- Located in `features/product/data/models/`.
- Represents the data model for a product.
- Includes methods for JSON serialization (`toJson`) and deserialization (`fromJson`).

### Example Code

#### Creating a ProductModel from JSON:

```dart
final productJson = {
  "id": 1,
  "name": "Laptop",
  "category": "Electronics",
  "price": 1200.00,
  "description": "A high-performance laptop.",
  "imageUrl": "http://example.com/laptop.jpg"
};

final product = ProductModel.fromJson(productJson);
```

#### Converting a ProductModel to JSON:

```dart
final product = ProductModel(
  id: 1,
  name: "Laptop",
  category: "Electronics",
  price: 1200.00,
  description: "A high-performance laptop.",
  imageUrl: "http://example.com/laptop.jpg"
);

final productJson = product.toJson();
```

## How to Run

1. Ensure you have Flutter installed on your system.
2. Navigate to the project directory.
3. Run the following command to start the application:
   ```bash
   flutter run
   ```
