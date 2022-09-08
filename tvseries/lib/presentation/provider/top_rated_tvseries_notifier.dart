import 'package:core/utils/state_enum.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:tvseries/domain/usecases/get_top_rated_tvseries.dart';
import 'package:flutter/cupertino.dart';

class TopRatedTvseriesNotifier extends ChangeNotifier {
  final GetTopRatedTvseries getTopRatedTvseries;

  TopRatedTvseriesNotifier({required this.getTopRatedTvseries});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Tvseries> _tvseries = [];
  List<Tvseries> get tvseries => _tvseries;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvseries() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvseries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvseriesData) {
        _tvseries = tvseriesData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
