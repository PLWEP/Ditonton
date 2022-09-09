import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/bloc/tvseries_bloc.dart';
import 'package:tvseries/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';

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
        context.read<TopRatedTvseriesBloc>().add(const FetchTvseriesData()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvseriesBloc, TvseriesState>(
          builder: (context, state) {
            if (state is LoadingData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvseriesHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = result[index];
                  return TvseriesCard(tvseries);
                },
                itemCount: result.length,
              );
            } else if (state is ErrorData) {
              return Expanded(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else {
              return Expanded(
                child: Container(),
              );
            }
          },
        ),
      ),
    );
  }
}
