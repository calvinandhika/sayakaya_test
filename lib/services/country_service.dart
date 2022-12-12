import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sayakaya_test/models/country_model.dart';
import 'package:sayakaya_test/models/global_data_model.dart';
import 'package:sayakaya_test/queries/all_country_query.dart';
import 'package:sayakaya_test/queries/global_total_query.dart';
import 'package:sayakaya_test/queries/search_country_query.dart';

class CountryService {
  late GraphQLClient _client;

  CountryService() {
    HttpLink link = HttpLink('https://covid19-graphql.netlify.app/');

    _client = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    );
  }

  Future<GlobalDataModel> getGlobalData() async {
    try {
      QueryOptions options = QueryOptions(
        document: gql(globalTotalQuery),
        variables: const {},
      );

      final result = await _client.query(options);

      return GlobalDataModel.fromJson(result.data!);
    } catch (e) {
      rethrow;
    }
  }

  Future<CountryModel> getAllCountries({
    required String? countryResultParametersSortInput,
  }) async {
    try {
      QueryOptions options = QueryOptions(
        document: gql(allCountryQuery),
        variables: {
          'sortBy': countryResultParametersSortInput,
        },
      );

      final result = await _client.query(options);

      return CountryModel.fromJson(result.data!);
    } catch (_) {
      rethrow;
    }
  }

  Future<CountryModelData> searchCountry({
    required String country,
    required String? filterBy,
  }) async {
    try {
      QueryOptions options = QueryOptions(
        document: gql(searchCountryQuery),
        variables: {
          'country': country,
          'filterBy': filterBy,
        },
      );

      final result = await _client.query(options);

      return CountryModelData.fromJson(result.data!['country']);
    } catch (_) {
      rethrow;
    }
  }
}
