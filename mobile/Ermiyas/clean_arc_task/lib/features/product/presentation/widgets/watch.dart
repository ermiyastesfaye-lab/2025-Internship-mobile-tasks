import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_7/features/product/domain/entities/product.dart';
import 'package:task_7/features/product/presentation/bloc/product_bloc.dart';
import 'package:task_7/features/product/presentation/widgets/loading.dart';
import 'package:task_7/features/product/presentation/widgets/message_display.dart';
import 'package:task_7/features/product/presentation/pages/watch_detail.dart';

class WatchGrid extends StatefulWidget {
  const WatchGrid({super.key});

  @override
  State<WatchGrid> createState() => _WatchGridState();
}

class _WatchGridState extends State<WatchGrid> {
  List<Product> _watchList = [];
  void initState() {
    super.initState();
    _loadWatches();
  }

  Future<void> _loadWatches() async {
    BlocProvider.of<ProductBloc>(context).add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is Empty) {
          return MessageDisplay(
            message: 'Start searching!',
          );
        } else if (state is Loading) {
          return LoadingWidget();
        } else if (state is Error) {
          return MessageDisplay(
            message: state.message,
          );
        } else if (state is ProductsLoaded) {
          _watchList = state.products;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10, crossAxisSpacing: 20, crossAxisCount: 2),
            itemCount: _watchList.length,
            itemBuilder: (context, index) {
              final watch = _watchList[index];
              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => WatchDetail(watch: watch),
                  //   ),
                  // );
                },
                child: Card(
                    color: const Color.fromARGB(255, 61, 69, 78),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 61, 69, 78),
                          borderRadius: BorderRadius.circular(30)),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                watch.imageUrl,
                                width: double.infinity,
                                height: 90,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/watch5.webp',
                                    width: 100,
                                    height: 100,
                                  );
                                },
                              ),
                            ),
                            Text(watch.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${watch.price}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
