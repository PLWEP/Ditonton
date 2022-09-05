import 'package:core/utils/state_enum.dart';
import 'package:core/utils/utils.dart';
import 'package:about/about.dart';
import 'package:core/presentation/pages/movie/home_movie_page.dart';
import 'package:core/presentation/pages/tvseries/home_tvseries_page.dart';
import 'package:core/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/tvseries/watchlist_tvseries_notifier.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tvseries_card_list.dart';
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
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, HomeTvseriesPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
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
