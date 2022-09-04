import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:flutter/cupertino.dart';

class TopRatedTvseriesNotifier extends ChangeNotifier {
  final GetTopRatedTvseries getTopRatedTvseries;

  TopRatedTvseriesNotifier({required this.getTopRatedTvseries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tvseries> _tvseries = [];
  List<Tvseries> get tvseries => _tvseries;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvseries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvseries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvseriesData) {
        _tvseries = tvseriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
