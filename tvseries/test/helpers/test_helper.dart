import 'package:core/utils/network_info.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:tvseries/data/datasources/tvseries_local_data_source.dart';
import 'package:tvseries/data/datasources/tvseries_remote_data_source.dart';
import 'package:tvseries/domain/repositories/tvseries_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvseriesRepository,
  TvseriesLocalDataSource,
  TvseriesRemoteDataSource,
  DatabaseHelper,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
