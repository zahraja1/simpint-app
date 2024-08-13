import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katalog/presentation/home/bloc/favorite/favorite_bloc.dart';
import 'package:katalog/variables.dart';
import 'package:katalog/widget/favorite_item.dart';
import 'package:katalog/widget/ItemScreen.dart'; // Import the ItemScreen

class FavoriteCard extends StatelessWidget {
  final FavoriteItem favorite;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onDeleteTap;

  const FavoriteCard({
    Key? key,
    required this.favorite,
    this.padding,
    this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemScreen(product: favorite.product),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            margin: padding,
            padding: const EdgeInsets.all(16.0),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Color(0xFFC7D0EB)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: '${Variables.imgBaseUrl}${favorite.product.img}',
                    width: 76,
                    height: 76,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.image_not_supported,
                      size: 80,
                    ),
                  ),
                ),
                const SizedBox(width: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      favorite.product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      favorite.product.writerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 16.0),
            child: IconButton(
              onPressed: onDeleteTap ?? () {
                context.read<FavoriteBloc>().add(FavoriteEvent.removeFavorite(favorite.product));
              },
              icon: const Icon(
                Icons.highlight_off,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
