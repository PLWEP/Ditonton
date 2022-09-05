import 'package:core/styles/text_style.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/provider/tvseries_search_notifier.dart';

class SearchPageTvseries extends StatelessWidget {
  static const routeName = '/search_tvseries';

  const SearchPageTvseries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<TvseriesSearchNotifier>(context, listen: false)
                    .fetchTvseriesSearch(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<TvseriesSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == RequestState.loaded) {
                  final result = data.searchResult;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvseries = data.searchResult[index];
                        return TvseriesCard(tvseries);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (data.state == RequestState.loaded) {
                  return const Expanded(
                    child: Center(child: Text("Kata Kunci kurang tepat nih!!")),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
