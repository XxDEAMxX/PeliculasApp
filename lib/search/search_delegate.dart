
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/movie_provaider.dart';

class MovieSeacarhDelegate extends SearchDelegate{

  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.clear),
      )
    ];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back)
    );
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('213');
    throw UnimplementedError();
  }

  Widget _EmptyContainer(){
    return Container(
        child: Center(
          child: Icon(Icons.search, size: 100,),
        ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if(query.isEmpty){
      return _EmptyContainer();
    }

    final movieProvider = Provider.of<MovieProvaider>(context, listen: false);

    return FutureBuilder(
      future: movieProvider.searchMovie(query),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if(!snapshot.hasData) return _EmptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(movie: movies[index]),
        ); 
      },
    );
    throw UnimplementedError();
  }

}

class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem({super.key, required this.movie});


  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';


    return ListTile(
        leading: Hero(
          tag: movie.heroId!,
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'), 
            image: NetworkImage(movie.fullPosterImg),
            width: 50,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(movie.title),
        subtitle: Text(movie.originalTitle),
        onTap: () {
          Navigator.pushNamed(context, 'details', arguments: movie  );
        },
    );
  }
}