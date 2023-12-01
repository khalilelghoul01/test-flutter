part of 'images_bloc.dart';

sealed class ImagesEvent extends Equatable {
  const ImagesEvent();

  @override
  List<Object> get props => [];
}

final class FetchImagesEvent extends ImagesEvent {
  final String query;
  final bool resetPagination;

  const FetchImagesEvent({required this.query, this.resetPagination = false});

  @override
  List<Object> get props => [query];
}
