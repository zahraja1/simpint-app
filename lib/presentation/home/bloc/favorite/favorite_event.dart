part of 'favorite_bloc.dart';

@freezed
class FavoriteEvent with _$FavoriteEvent {
  const factory FavoriteEvent.started() = _Started;
  const factory FavoriteEvent.addFavorite(Product product) = _AddFavorite;
  const factory FavoriteEvent.removeFavorite(Product product) = _RemoveFavorite;

}