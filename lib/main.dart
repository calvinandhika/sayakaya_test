import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sayakaya_test/queries/all_country_query.dart';
import 'package:sayakaya_test/services/country_service.dart';

void main() {
  final HttpLink httpLink = HttpLink("https://covid19-graphql.netlify.app/");

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    ),
  );

  var app = GraphQLProvider(
    client: client,
    child: const MyApp(),
  );

  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: CovidService().performQuery(
              query: allCountryQuery,
              variables: {},
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:

                case ConnectionState.waiting:

                case ConnectionState.active:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                case ConnectionState.done:
                  return Text(snapshot.data.toString());
              }
            },
          ),
        ),
      ),
    );
  }
}
