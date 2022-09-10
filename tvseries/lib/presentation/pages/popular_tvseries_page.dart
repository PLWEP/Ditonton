import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/tvseries_bloc.dart';
import 'package:tvseries/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';

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
        context.read<PopularTvseriesBloc>().add(const FetchTvseriesData()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tvseries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvseriesBloc, TvseriesState>(
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
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
