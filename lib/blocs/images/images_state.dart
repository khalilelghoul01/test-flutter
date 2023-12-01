part of 'images_bloc.dart';

sealed class ImagesState extends Equatable {
  const ImagesState();

  @override
  List<Object> get props => [];
}

final class ImagesInitial extends ImagesState {}

final class ImagesLoading extends ImagesState {
  final List<Hit> images;
  final bool firstFetch;
  const ImagesLoading({this.images = const [], this.firstFetch = false});

  @override
  List<Object> get props => [images];
}

final class ImagesLoaded extends ImagesState {
  final List<Hit> images;
  final bool hasReachedMax;

  const ImagesLoaded({required this.images, this.hasReachedMax = false});

  @override
  List<Object> get props => [images, hasReachedMax];
}

final class ImagesError extends ImagesState {}
