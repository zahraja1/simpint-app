part of 'favorite_bloc.dart';

@freezed
class FavoriteState with _$FavoriteState {
  const factory FavoriteState.initial() = _Initial;
  const factory FavoriteState.loading() = _Loading;
  const factory FavoriteState.success(List<FavoriteItem> product) = _Success;
  const factory FavoriteState.error(String message) = _Error;
}
