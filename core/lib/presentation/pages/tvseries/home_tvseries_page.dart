import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:about/about.dart';
import 'package:core/presentation/pages/movie/home_movie_page.dart';
import 'package:core/presentation/pages/tvseries/popular_tvseries_page.dart';
import 'package:core/presentation/pages/tvseries/top_rated_tvseries_page.dart';
import 'package:core/presentation/pages/tvseries/tvseries_detail_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/presentation/provider/tvseries/tvseries_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTvseriesPage extends StatefulWidget {
  static const routeName = '/home_tvseries';

  const HomeTvseriesPage({Key? key}) : super(key: key);
  @override
  HomeTvseriesPageState createState() => HomeTvseriesPageState();
}

class HomeTvseriesPageState extends State<HomeTvseriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TvseriesListNotifier>(context, listen: false)
          ..fetchNowPlayingTvseries()
          ..fetchPopularTvseries()
          ..fetchTopRatedTvseries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, Watchlist.routeName);
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
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchTvseriesRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              Consumer<TvseriesListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return TvseriesList(data.nowPlayingTvseries);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvseriesPage.routeName),
              ),
              Consumer<TvseriesListNotifier>(builder: (context, data, child) {
                final state = data.popularTvseriesState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return TvseriesList(data.popularTvseries);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTvseriesPage.routeName),
              ),
              Consumer<TvseriesListNotifier>(builder: (context, data, child) {
                final state = data.topRatedTvseriesState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return TvseriesList(data.topRatedTvseries);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvseriesList extends StatelessWidget {
  final List<Tvseries> tvseries;

  const TvseriesList(this.tvseries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final singleTvseries = tvseries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvseriesDetailPage.routeName,
                  arguments: singleTvseries.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${singleTvseries.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvseries.length,
      ),
    );
  }
}
