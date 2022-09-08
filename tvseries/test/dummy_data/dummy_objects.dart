import 'package:tvseries/data/models/tvseries_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tvseries/domain/entities/tvseries.dart';
import 'package:tvseries/domain/entities/tvseries_detail.dart';

final testTvseries = Tvseries(
  posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
  popularity: 47.432451,
  id: 31917,
  backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
  voteAverage: 5.04,
  overview:
      "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
  firstAirDate: "2010-06-08",
  originCountry: const ["US"],
  genresId: const [18, 9648],
  originalLanguage: "en",
  voteCount: 133,
  name: "Pretty Little Liars",
  title: "Pretty Little Liars",
);

final testTvseriesList = [testTvseries];

const testTvseriesDetail = TvseriesDetail(
  backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
  genres: [Genre(id: 10765, name: "Sci-Fi & Fantasy")],
  id: 1399,
  numberOfEpisodes: 73,
  numberOfSeasons: 8,
  title: "Game of Thrones",
  overview:
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  popularity: 369.594,
  posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  status: "Ended",
  voteAverage: 8.3,
  voteCount: 11504,
);

final testWatchlistTvseries = Tvseries.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvseriesTable = TvseriesTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvseriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const testTvseriesCache = TvseriesTable(
  id: 1399,
  overview:
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  title: 'Game Of Thrones',
);

final testTvseriesCacheMap = {
  "id": 1399,
  "overview":
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  "posterPath": "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  "title": 'Game Of Thrones',
};

final testTvseriesFromCache = Tvseries.watchlist(
  id: 1399,
  overview:
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  title: 'Game Of Thrones',
);
