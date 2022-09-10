import 'package:core/styles/colors.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/utils.dart';
import 'package:about/about.dart';
import 'package:core/utils/routes.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:tvseries/presentation/pages/home_tvseries_page.dart';
import 'package:tvseries/presentation/pages/popular_tvseries_page.dart';
import 'package:tvseries/presentation/pages/top_rated_tvseries_page.dart';
import 'package:tvseries/presentation/pages/tvseries_detail_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/presentation/pages/search_page_movie.dart';
import 'package:search/presentation/pages/search_page_tvseries.dart';
import 'package:search/presentation/bloc/movie/search_movie_bloc.dart';
import 'package:search/presentation/bloc/tvseries/search_tvseries_bloc.dart';
import 'package:movie/bloc/movie_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Movie
        BlocProvider(
          create: (_) => di.locator<MovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),

        // Tvseries
        BlocProvider(
          create: (_) => di.locator<TvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvseriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvseriesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Ditonton',
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
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
          }
        },
      ),
    );
  }
}
