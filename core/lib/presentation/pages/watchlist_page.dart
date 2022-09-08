import 'package:core/presentation/widgets/drawer.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/utils/utils.dart';
import 'package:movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:tvseries/presentation/provider/watchlist_tvseries_notifier.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:tvseries/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Watchlist extends StatefulWidget {
  static const routeName = '/watchlist';

  const Watchlist({Key? key}) : super(key: key);

  @override
  WatchlistState createState() => WatchlistState();
}

class WatchlistState extends State<Watchlist> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvseriesNotifier>(context, listen: false)
          .fetchWatchlistTvseries();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvseriesNotifier>(context, listen: false)
        .fetchWatchlistTvseries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      drawer: const NavigationMenu(currentRoute: 'watchlist'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child:
                  Consumer2<WatchlistMovieNotifier, WatchlistTvseriesNotifier>(
                builder: (context, movieData, tvseriesData, child) {
                  if (movieData.watchlistState == RequestState.loading ||
                      tvseriesData.watchlistState == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (movieData.watchlistState == RequestState.loaded &&
                      tvseriesData.watchlistState == RequestState.loaded) {
                    var counterIndex = 0;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        if (index < movieData.watchlistMovies.length) {
                          final movie = movieData.watchlistMovies[index];
                          return MovieCard(movie);
                        } else {
                          final tvseries =
                              tvseriesData.watchlistTvseries[counterIndex];
                          counterIndex++;
                          return TvseriesCard(tvseries);
                        }
                      },
                      itemCount: movieData.watchlistMovies.length +
                          tvseriesData.watchlistTvseries.length,
                    );
                  } else if (movieData.watchlistState == RequestState.empty &&
                      tvseriesData.watchlistState == RequestState.empty) {
                    return const Center(
                      child: Text("Watchlist masih kosong :("),
                    );
                  } else {
                    return Center(
                      key: const Key('error_message'),
                      child:
                          Text("${movieData.message}\n${tvseriesData.message}"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
