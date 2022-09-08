import 'package:core/utils/state_enum.dart';
import 'package:tvseries/presentation/provider/popular_tvseries_notifier.dart';
import 'package:tvseries/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTvseriesPage extends StatefulWidget {
  static const routeName = '/popular_tvseries';

  const PopularTvseriesPage({Key? key}) : super(key: key);

  @override
  PopularTvseriesPageState createState() => PopularTvseriesPageState();
}

class PopularTvseriesPageState extends State<PopularTvseriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTvseriesNotifier>(context, listen: false)
            .fetchPopularTvseries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tvseries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvseriesNotifier>(
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
