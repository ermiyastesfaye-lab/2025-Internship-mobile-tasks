import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:task_7/features/product/domain/entities/product.dart';
import 'package:task_7/features/product/presentation/bloc/product_bloc.dart';

class AddWatch extends StatefulWidget {
  const AddWatch({super.key});

  @override
  State<AddWatch> createState() => _AddWatchState();
}

class _AddWatchState extends State<AddWatch> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newWatch = Product(
        null,
        name: _nameController.text,
        category: _categoryController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text,
      );

      await _saveWatchList(newWatch);

      _nameController.clear();
      _categoryController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _imageUrlController.clear();
    }
  }

  Future<void> _saveWatchList(Product watchList) async {
    BlocProvider.of<ProductBloc>(context)
        .add(AddProductEvent(product: watchList));
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 48, 57),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 40, 48, 57),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Center(
          child: Text(
            'Add Product',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  'Image URL',
                  _imageUrlController,
                  key: const Key('imageUrlField'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an image URL';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  'Name',
                  _nameController,
                  key: const Key('nameField'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a watch name';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  'Category',
                  _categoryController,
                  key: const Key('categoryField'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  'Price',
                  _priceController,
                  isNumeric: true,
                  key: const Key('priceField'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  'Description',
                  _descriptionController,
                  maxLines: 5,
                  key: const Key('descriptionField'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromARGB(255, 37, 60, 103),
                    ),
                    onPressed: _submitForm,
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField(String label, TextEditingController controller,
    {bool isNumeric = false,
    int maxLines = 1,
    String? Function(String?)? validator,
    required Key key}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      const SizedBox(height: 5),
      TextFormField(
        key: key,
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.white),
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 61, 69, 78),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
