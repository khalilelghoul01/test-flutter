import 'package:flutter_test/flutter_test.dart';
import 'package:test/blocs/images/images_bloc.dart';
import 'package:test/mock/api_responses.dart';
import 'package:test/model/pixabay_response_model.dart';
import 'package:test/repositories/images_api_repository.dart';

class MockApi implements ImagesApiRepository {
  @override
  Future<PixabayResponse> fetchImages(String query, int page,
      [int perPage = 20]) async {
    final mockResponse = getPage(page);
    return mockResponse;
  }
}

void main() {
  const testQuery = 'france';
  int testPage = 1;
  PixabayResponse currentPage = getPage(testPage);

  group('ImagesBloc', () {
    late MockApi mockApi;
    late ImagesBloc imagesBloc;

    setUp(() {
      mockApi = MockApi();
      imagesBloc = ImagesBloc(api: mockApi);
    });

    tearDown(() {
      imagesBloc.close();
    });

    test('initial state is ImagesInitial', () {
      expect(imagesBloc.state, equals(ImagesInitial()));
    });

    test('fetchImages emits ImagesLoaded when successful', () {
      imagesBloc.add(const FetchImagesEvent(
        query: testQuery,
      ));

      expect(
        imagesBloc.state,
        ImagesLoaded(
          images: currentPage.hits,
          hasReachedMax: false,
        ),
      );
    });
  });
}
