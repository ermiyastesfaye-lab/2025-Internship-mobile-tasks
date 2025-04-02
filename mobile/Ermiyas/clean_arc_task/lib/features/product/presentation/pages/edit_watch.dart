// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:task_7/features/product/domain/entities/product.dart';
// import 'package:task_7/model/watch.dart';

// class EditWatch extends StatefulWidget {
//   final Product watch;

//   const EditWatch({super.key, required this.watch});

//   @override
//   State<EditWatch> createState() => _EditWatchState();
// }

// class _EditWatchState extends State<EditWatch> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _nameController;
//   late TextEditingController _categoryController;
//   late TextEditingController _priceController;
//   late TextEditingController _descriptionController;
//   late TextEditingController _imageUrlController;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.watch.name);
//     _categoryController = TextEditingController(text: widget.watch.category);
//     _priceController =
//         TextEditingController(text: widget.watch.price.toString());
//     _descriptionController =
//         TextEditingController(text: widget.watch.description);
//     _imageUrlController = TextEditingController(text: widget.watch.imageUrl);
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _categoryController.dispose();
//     _priceController.dispose();
//     _descriptionController.dispose();
//     _imageUrlController.dispose();
//     super.dispose();
//   }

//   void _updateWatch() {
//     if (_formKey.currentState!.validate()) {
//       final updatedWatch = Watch(
//         id: widget.watch.id,
//         name: _nameController.text,
//         category: _categoryController.text,
//         price: double.tryParse(_priceController.text) ?? 0.0,
//         description: _descriptionController.text,
//         imageUrl: _imageUrlController.text,
//       );

//       updateWatchInLocalStorage(context, updatedWatch);

//       Navigator.pop(context, updatedWatch);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 40, 48, 57),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 40, 48, 57),
//         title: const Text('Edit Watch', style: TextStyle(color: Colors.white)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // Image preview from URL

//                 const SizedBox(height: 20),
//                 _buildTextField("Image URL", _imageUrlController),
//                 _buildTextField("Name", _nameController),
//                 _buildTextField("Category", _categoryController),
//                 _buildTextField("Price", _priceController, isNumeric: true),
//                 _buildTextField("Description", _descriptionController,
//                     maxLines: 5),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           backgroundColor:
//                               const Color.fromARGB(255, 37, 60, 103)),
//                       onPressed: _updateWatch,
//                       child: const Text(
//                         'Update',
//                         style: TextStyle(fontSize: 17, color: Colors.white),
//                       )),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller,
//       {bool isNumeric = false, int maxLines = 1}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
//         const SizedBox(height: 5),
//         TextFormField(
//           controller: controller,
//           keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
//           style: TextStyle(color: Colors.white),
//           maxLines: maxLines,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: const Color.fromARGB(255, 61, 69, 78),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//           onChanged: (value) {
//             if (label == "Image URL") {
//               setState(() {});
//             }
//           },
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }

// Future<void> updateWatchInLocalStorage(context, Watch updatedWatch) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   List<String> watchList = prefs.getStringList('watch_list') ?? [];

//   List<Watch> watches = watchList.map((json) => Watch.fromJson(json)).toList();

//   for (int i = 0; i < watches.length; i++) {
//     if (watches[i].id == updatedWatch.id) {
//       watches[i] = updatedWatch;
//       break;
//     }
//   }

//   List<String> updatedWatchList =
//       watches.map((watch) => watch.toJson()).toList();

//   await prefs.setStringList('watch_list', updatedWatchList);
//   Navigator.pushNamed(context, '/');
// }
