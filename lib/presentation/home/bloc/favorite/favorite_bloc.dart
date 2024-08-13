import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:katalog/data/models/response/product_response_model.dart';
import 'package:katalog/widget/favorite_item.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';
part 'favorite_bloc.freezed.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(const _Success([])) {
    on<_AddFavorite>((event, emit) {
      var currentState = state as _Success;
      List<FavoriteItem> newFavorites = [...currentState.product];
      emit(const _Loading());
      
      // Menambahkan item favorit
      newFavorites.add(FavoriteItem(product: event.product));

      emit(_Success(newFavorites));
    });

    on<_RemoveFavorite>((event, emit) {
      var currentState = state as _Success;
      List<FavoriteItem> newFavorites = [...currentState.product];
      emit(const _Loading());
      
      // Menghapus item favorit
      newFavorites.removeWhere((item) => item.product == event.product);

      emit(_Success(newFavorites));
    });

    on<_Started>((event, emit) {
      emit(const _Loading());
      emit(const _Success([]));
    });
  }
}
