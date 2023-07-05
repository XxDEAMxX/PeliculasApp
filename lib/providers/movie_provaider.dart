import 'package:flutter/material.dart';

class MovieProvaider extends ChangeNotifier{
  MovieProvaider(){
    print('MoviesProvaider inicializado');
    this.getOnDisplayMovie();
  }

  getOnDisplayMovie(){
    print('getOnDisplayMovies');
  }

}