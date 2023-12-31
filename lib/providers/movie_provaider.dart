import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/search_response.dart';

class MovieProvaider extends ChangeNotifier{

  final String _apyKey = 'd287ae41c26b2a23263da1170886435b';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'es-Es';

  List<Movie> onDisplayMovie = []; 
  List<Movie> popularMovies = []; 
  Map<int, List<Cast>> moviesCast = {};
  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;


  MovieProvaider(){
    print('MoviesProvaider inicializado');
    getOnDisplayMovie();
    getPopularMovies();
  }

  Future<String> _getJsonData (String endPoint, [int page = 1]) async{

      final url = Uri.https(_baseUrl, endPoint, {
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

  Future<List<Movie>> searchMovie(String query) async{
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apyKey,
      'language': _lenguage,
      'query': query
    });

    final response = await http.get(url);
    final searchReponse = SearchReponse.fromJson(response.body) ;   

    return searchReponse.results;
  }

  void getSuggestionsByQuery(String searchTerm){

    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final result = await searchMovie(value);
      this._suggestionStreamController.add(result);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), ( _ ) { 
      debouncer.value = searchTerm;
     });

    Future.delayed(Duration(milliseconds: 301))..then((_) => timer.cancel());

  } 

}