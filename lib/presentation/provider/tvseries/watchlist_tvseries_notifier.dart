import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/tvseries/get_watchlist_tvseries.dart';
import 'package:flutter/cupertino.dart';

class WatchlistTvseriesNotifier extends ChangeNotifier {
  var _watchlistTvseries = <Tvseries>[];
  List<Tvseries> get watchlistTvseries => _watchlistTvseries;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvseriesNotifier({required this.getWatchlistTvseries});

  final GetWatchlistTvseries getWatchlistTvseries;

  Future<void> fetchWatchlistTvseries() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvseries.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvseriesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvseries = tvseriesData;
        notifyListeners();
      },
    );
  }
}
