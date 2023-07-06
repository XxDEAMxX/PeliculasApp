import 'package:flutter/material.dart';
import 'package:peliculas/providers/movie_provaider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MovieProvaider>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en Cines'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.search)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [

          CardSwiper( movies: moviesProvider.onDisplayMovie),
          MovieSlider(movies: moviesProvider.popularMovies, title: 'Populares',)
        ],
      ),
      )
    );
  }
}