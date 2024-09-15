part of 'favorit_cubit.dart';

@immutable
abstract class FavoritState {}

class FavoritInitial extends FavoritState {}
class NoFavorits extends FavoritState {}
class ShowFavorits extends FavoritState {}
