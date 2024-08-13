import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katalog/presentation/home/bloc/favorite/favorite_bloc.dart';
import 'package:katalog/widget/favorite_card.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products'),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          return state.maybeWhen(
            success: (favorites) {
              if (favorites.isEmpty) {
                return Center(
                  child: Text('No favorite products added.'),
                );
              }

              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final favorite = favorites[index];
                  return FavoriteCard(
                    favorite: favorite,
                    padding: const EdgeInsets.all(8.0),
                  );
                },
              );
            },
            orElse: () => Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
