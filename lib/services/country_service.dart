import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sayakaya_test/models/country_model.dart';

class CovidService {
  late GraphQLClient _client;

  CovidService() {
    HttpLink link = HttpLink('https://covid19-graphql.netlify.app/');

    _client = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    );
  }

  Future<CountryModel> performQuery({
    required String query,
    required Map<String, dynamic> variables,
  }) async {
    try {
      QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables,
      );

      final result = await _client.query(options);

      return CountryModel.fromJson(result.data!);
    } catch (_) {
      rethrow;
    }
  }
}
