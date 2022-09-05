import 'package:core/utils/state_enum.dart';
import 'package:core/presentation/provider/tvseries/top_rated_tvseries_notifier.dart';
import 'package:core/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedTvseriesPage extends StatefulWidget {
  static const routeName = '/top_rated_tvseries';

  const TopRatedTvseriesPage({Key? key}) : super(key: key);

  @override
  TopRatedTvseriesPageState createState() => TopRatedTvseriesPageState();
}

class TopRatedTvseriesPageState extends State<TopRatedTvseriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTvseriesNotifier>(context, listen: false)
            .fetchTopRatedTvseries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvseriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = data.tvseries[index];
                  return TvseriesCard(tvseries);
                },
                itemCount: data.tvseries.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
