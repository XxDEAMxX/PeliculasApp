
import 'package:flutter/material.dart';

class MovieSeacarhDelegate extends SearchDelegate{

  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [Text('213')];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return Text('213');
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('213');
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Text('213:$query');
    throw UnimplementedError();
  }

}