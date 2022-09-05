import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:flutter/cupertino.dart';

class PopularTvseriesNotifier extends ChangeNotifier {
  final GetPopularTvseries getPopularTvseries;

  PopularTvseriesNotifier(this.getPopularTvseries);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Tvseries> _tvseries = [];
  List<Tvseries> get tvseries => _tvseries;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvseries() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvseries.execute();

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
