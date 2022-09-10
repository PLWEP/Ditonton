import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/search_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchTvseriesBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTvseries _searchTvseries;

  SearchTvseriesBloc(this._searchTvseries) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchTvseries.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
