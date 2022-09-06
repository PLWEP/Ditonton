import 'package:core/styles/colors.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/utils.dart';
import 'package:about/about.dart';
import 'package:core/utils/routes.dart';
import 'package:core/presentation/pages/movie/movie_detail_page.dart';
import 'package:core/presentation/pages/movie/home_movie_page.dart';
import 'package:core/presentation/pages/movie/popular_movies_page.dart';
import 'package:core/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tvseries/home_tvseries_page.dart';
import 'package:core/presentation/pages/tvseries/popular_tvseries_page.dart';
import 'package:core/presentation/pages/tvseries/top_rated_tvseries_page.dart';
import 'package:core/presentation/pages/tvseries/tvseries_detail_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movie/movie_list_notifier.dart';
import 'package:core/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:core/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/tvseries/popular_tvseries_notifier.dart';
import 'package:core/presentation/provider/tvseries/top_rated_tvseries_notifier.dart';
import 'package:core/presentation/provider/tvseries/tvseries_detail_notifier.dart';
import 'package:core/presentation/provider/tvseries/tvseries_list_notifier.dart';
import 'package:core/presentation/provider/tvseries/watchlist_tvseries_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/presentation/pages/search_page_movie.dart';
import 'package:search/presentation/pages/search_page_tvseries.dart';
import 'package:search/presentation/provider/tvseries_search_notifier.dart';
import 'package:search/bloc/search_bloc.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvseriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvseriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvseriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvseriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvseriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvseriesNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'core',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        initialRoute: homeMovieRoute,
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case homeMovieRoute:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case popularMoviesRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedMovieRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case movieDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchMovieRoute:
              return CupertinoPageRoute(builder: (_) => SearchPageMovie());
            case hometvseriesRoute:
              return MaterialPageRoute(builder: (_) => HomeTvseriesPage());
            case populartvseriesRoute:
              return CupertinoPageRoute(builder: (_) => PopularTvseriesPage());
            case topRatedTvseriesRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedTvseriesPage());
            case tvseriesDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvseriesDetailPage(id: id),
                settings: settings,
              );
            case searchTvseriesRoute:
              return CupertinoPageRoute(builder: (_) => SearchPageTvseries());
            case watchlistRoute:
              return MaterialPageRoute(builder: (_) => Watchlist());
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
