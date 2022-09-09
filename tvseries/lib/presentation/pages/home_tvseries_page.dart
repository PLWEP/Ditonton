import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/widgets/drawer.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/bloc/tvseries_bloc.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:flutter/material.dart';

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
    Future.microtask(() => {
          context.read<TvseriesBloc>().add(const FetchTvseriesData()),
          context.read<PopularTvseriesBloc>().add(const FetchTvseriesData()),
          context.read<TopRatedTvseriesBloc>().add(const FetchTvseriesData()),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationMenu(currentRoute: 'tvseries'),
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
              BlocBuilder<TvseriesBloc, TvseriesState>(
                builder: (context, state) {
                  if (state is LoadingData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvseriesHasData) {
                    final result = state.result;
                    return TvseriesList(result);
                  } else {
                    return const Text("Failed");
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, populartvseriesRoute),
              ),
              BlocBuilder<PopularTvseriesBloc, TvseriesState>(
                builder: (context, state) {
                  if (state is LoadingData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvseriesHasData) {
                    final result = state.result;
                    return TvseriesList(result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, topRatedTvseriesRoute),
              ),
              BlocBuilder<TopRatedTvseriesBloc, TvseriesState>(
                builder: (context, state) {
                  if (state is LoadingData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvseriesHasData) {
                    final result = state.result;
                    return TvseriesList(result);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
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
                  tvseriesDetailRoute,
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
