import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katalog/presentation/home/bloc/product/product_bloc.dart';
import 'package:katalog/presentation/home/models/product_category.dart';
import 'package:katalog/widget/Product_card.dart';
import 'package:katalog/widget/product_empty.dart';
import 'package:katalog/widget/search_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final indexValue = ValueNotifier(0);

  @override
  void initState() {
    context.read<ProductBloc>().add(const ProductEvent.fetch());
    super.initState();
  }

  void onCategoryTap(int index) {
    searchController.clear();
    indexValue.value = index;
    String category = 'satu';
    switch (index) {
      case 0:
        category = 'satu';
        break;
      case 1:
        category = 'dua';
        break;
      case 2:
        category = 'tiga';
        break;
      case 3:
        category = 'empat';
        break;
      case 4:
        category = 'lima';
        break;
    }
    context.read<ProductBloc>().add(ProductEvent.fetchByCategory(category));
  }

  @override
  Widget build(BuildContext context) {
    List<String> adImages = [
      'assets/images/1.jpg',
      'assets/images/4.png',
      'assets/images/2.jpg',
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                SearchInput(
                  controller: searchController,
                  onChanged: (value) {
                    if (value.length >= 1) {
                      context
                          .read<ProductBloc>()
                          .add(ProductEvent.searchProduct(value));
                    }
                    // ini buat ngembaliin ke halaman awal
                    if (value.isEmpty) {
                      context
                          .read<ProductBloc>()
                          .add(const ProductEvent.fetchAllFromSate());
                    }
                  },
                ),
              ],
            ),
          ),
          // iklan
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 5.5,
              child: PageView.builder(
                itemCount: adImages.length, // Ganti sesuai dengan jumlah item
                itemBuilder: (context, i) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        adImages[i],
                        height: 125,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 9, horizontal: 140),
                  decoration: BoxDecoration(
                    color: const Color(0xFF96BFF8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "G  E  N  R  E",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: List.generate(ProductCategory.values.length, (index) {
                final category = ProductCategory.values[index];
                return Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => onCategoryTap(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  Color(0xFFD8B4FE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          category.value,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0), // Tambahkan jarak horizontal di sini
                  ],
                );
              }),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox();
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (message) {
                  return Center(
                    child: Text(message),
                  );
                },
                success: (products) {
                  if (products.isEmpty) return const ProductEmpty();
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.70,
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemBuilder: (context, index) => ProductCard(
                      data: products[index],
                      onCartButton: () {},
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
