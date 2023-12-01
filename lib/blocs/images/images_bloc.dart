import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test/model/hit_model.dart';
import 'package:test/repositories/images_api_repository.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final ImagesApiRepository api;
  bool isFetching = false;

  ImagesBloc({
    required this.api,
  }) : super(ImagesInitial()) {
    on<FetchImagesEvent>(_onFetchImages);
  }

  void _onFetchImages(FetchImagesEvent event, Emitter<ImagesState> emit) async {
    if (isFetching ||
        (state is ImagesLoaded && (state as ImagesLoaded).hasReachedMax)) {
      return;
    }

    final currentState = state;
    int page = 1;
    const perPage = 20;
    List<Hit> images = [];

    if (currentState is ImagesLoaded && !event.resetPagination) {
      images = currentState.images;
      page = (images.length ~/ perPage) + 1;
    }
    emit(ImagesLoading(images: images, firstFetch: page == 1));
    isFetching = true;

    try {
      final newImages = await api.fetchImages(event.query, page, perPage);
      emit(ImagesLoaded(
          images: images + newImages.hits,
          hasReachedMax: newImages.hits.isEmpty));
    } catch (_) {
      emit(ImagesError());
    }

    isFetching = false;
  }
}
