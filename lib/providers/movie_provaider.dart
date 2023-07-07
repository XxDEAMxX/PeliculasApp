import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MovieProvaider extends ChangeNotifier{

  final String _apyKey = 'd287ae41c26b2a23263da1170886435b';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'es-Es';

  List<Movie> onDisplayMovie = []; 
  List<Movie> popularMovies = []; 
  Map<int, List<Cast>> moviesCast = {};
  int _popularPage = 0;

  MovieProvaider(){
    print('MoviesProvaider inicializado');
    getOnDisplayMovie();
    getPopularMovies();
  }

  Future<String> _getJsonData (String endPoint, [int page = 1]) async{

      var url = Uri.https(_baseUrl, endPoint, {
      'api_key': _apyKey,
      'language': _lenguage,
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;   
  }

  getOnDisplayMovie()  async{

    final jsonData = await _getJsonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
     
    onDisplayMovie = nowPlayingResponse.results;

    notifyListeners();

  }


  getPopularMovies() async{

    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
      
    final popularResponse = PopularResponse.fromJson(jsonData);
     
    popularMovies = [ ...popularMovies, ...popularResponse.results ];

    notifyListeners();
  }

  Future <List<Cast>> getMovieCast(int movieId) async{

    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    print('pidiendo info de los servidores');
    final jsonData = await _getJsonData('3/movie/$movieId/credits', _popularPage);
    final creditsReponse = CreditsReponse.fromJson(jsonData);
    moviesCast[movieId] = creditsReponse.cast;
    return creditsReponse.cast;
  }

}