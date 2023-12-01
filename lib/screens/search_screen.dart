import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/blocs/images/images_bloc.dart';
import 'package:test/widgets/bottom_loader.dart';
import 'package:test/widgets/image_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late ImagesBloc _imagesBloc;
  String query = '';

  void perfomSearch() {
    String currentText = _searchController.text;
    bool shouldReset = currentText != query;
    query = currentText;
    _imagesBloc.add(FetchImagesEvent(
      query: query,
      resetPagination: shouldReset,
    ));
  }

  @override
  void initState() {
    super.initState();
    _imagesBloc = context.read<ImagesBloc>();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    const threshold = 100.0;
    final currentPosition = _scrollController.position.pixels;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    if (maxScrollExtent - currentPosition <= threshold) {
      perfomSearch();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 65, 24, 135),
        title:
            const Text('Test Technique', style: TextStyle(color: Colors.white)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) {
                perfomSearch();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Search for images',
                hintStyle: const TextStyle(color: Colors.deepPurple),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.deepPurple),
                  onPressed: () {
                    _searchController.clear();
                    perfomSearch();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<ImagesBloc, ImagesState>(
        builder: (context, state) {
          if (state is ImagesLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.images.length
                  : state.images.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.images.length
                    ? const BottomLoader()
                    : ImageItem(image: state.images[index]);
              },
            );
          } else if (state is ImagesError) {
            return const Center(child: Text('Failed to load images'));
          } else if (state is ImagesInitial) {
            return const Center(child: Text('Please enter a search term'));
          } else if (state is ImagesLoading) {
            if (state.firstFetch) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: state.images.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.images.length
                    ? const BottomLoader()
                    : ImageItem(image: state.images[index]);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
