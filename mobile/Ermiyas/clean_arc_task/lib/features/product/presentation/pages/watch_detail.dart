// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:task_7/features/product/domain/entities/product.dart';
// import 'package:task_7/model/watch.dart';
// import 'package:task_7/features/product/presentation/pages/edit_watch.dart';

// class WatchDetail extends StatefulWidget {
//   final Product watch;
//   const WatchDetail({super.key, required this.watch});

//   @override
//   State<WatchDetail> createState() => _WatchDetailState();
// }

// class _WatchDetailState extends State<WatchDetail> {
//   @override
//   Widget build(BuildContext context) {
//     final watch = widget.watch;
//     return Scaffold(
//         backgroundColor: const Color.fromARGB(255, 40, 48, 57),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(0),
//             child: Column(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.4,
//                       child: Stack(
//                         children: [
//                           ClipRRect(
//                             child: Image.network(
//                               watch.imageUrl,
//                               width: double.infinity,
//                               height: MediaQuery.of(context).size.height * 0.4,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Image.asset(
//                                   'assets/images/watch5.webp',
//                                   width: 100,
//                                   height: 100,
//                                 );
//                               },
//                             ),
//                           ),
//                           Positioned(
//                             top: 0,
//                             left: 0,
//                             right: 0,
//                             child: AppBar(
//                               automaticallyImplyLeading: false,
//                               backgroundColor: Colors.transparent,
//                               elevation: 0,
//                               toolbarHeight: kToolbarHeight,
//                               title: GestureDetector(
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Container(
//                                   width: 50,
//                                   height: 50,
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Color.fromARGB(255, 40, 48, 57),
//                                   ),
//                                   child: const Icon(
//                                     Icons.arrow_back_ios_new_rounded,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ), // AppBar title
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         watch.category,
//                         style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.grey),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             watch.name,
//                             style: const TextStyle(
//                                 fontSize: 23,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white),
//                           ),
//                           Text(
//                             '\$${watch.price}',
//                             style: const TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.white),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         child: Text(
//                           watch.description,
//                           style: const TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(
//                             width: 150,
//                             height: 50,
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor:
//                                       const Color.fromARGB(255, 61, 69, 78),
//                                   shape: RoundedRectangleBorder(
//                                       side: const BorderSide(color: Colors.red),
//                                       borderRadius: BorderRadius.circular(10)),
//                                 ),
//                                 onPressed: () =>
//                                     deleteWatchInLocalStorage(context, watch),
//                                 child: const Text(
//                                   'Delete',
//                                   style: TextStyle(
//                                       fontSize: 17, color: Colors.red),
//                                 )),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           SizedBox(
//                             width: 150,
//                             height: 50,
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     backgroundColor:
//                                         const Color.fromARGB(255, 63, 81, 243)),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           EditWatch(watch: watch),
//                                     ),
//                                   );
//                                 },
//                                 child: const Text(
//                                   'Update',
//                                   style: TextStyle(
//                                       fontSize: 17, color: Colors.white),
//                                 )),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }

// Future<void> deleteWatchInLocalStorage(context, Product updatedWatch) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   List<String> watchList = prefs.getStringList('watch_list') ?? [];

//   List<Watch> watches = watchList.map((json) => Watch.fromJson(json)).toList();

//   for (int i = 0; i < watches.length; i++) {
//     if (watches[i].id == updatedWatch.id) {
//       watches.removeAt(i);
//     }
//   }

//   List<String> updatedWatchList =
//       watches.map((watch) => watch.toJson()).toList();

//   await prefs.setStringList('watch_list', updatedWatchList);
//   Navigator.pushNamed(context, '/');
// }


// //  "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.",