import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/tvseries/search_tvseries.dart';
import 'package:flutter/cupertino.dart';

class TvseriesSearchNotifier extends ChangeNotifier {
  final SearchTvseries searchTvseries;

  TvseriesSearchNotifier({required this.searchTvseries});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Tvseries> _searchResult = [];
  List<Tvseries> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvseriesSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTvseries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
