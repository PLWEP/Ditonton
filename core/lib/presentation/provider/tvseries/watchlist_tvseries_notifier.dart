import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_watchlist_tvseries.dart';
import 'package:flutter/cupertino.dart';

class WatchlistTvseriesNotifier extends ChangeNotifier {
  var _watchlistTvseries = <Tvseries>[];
  List<Tvseries> get watchlistTvseries => _watchlistTvseries;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvseriesNotifier({required this.getWatchlistTvseries});

  final GetWatchlistTvseries getWatchlistTvseries;

  Future<void> fetchWatchlistTvseries() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTvseries.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvseriesData) {
        _watchlistState = RequestState.loaded;
        _watchlistTvseries = tvseriesData;
        notifyListeners();
      },
    );
  }
}
