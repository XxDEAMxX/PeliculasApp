import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MovieProvaider extends ChangeNotifier{

  final String _apyKey = 'd287ae41c26b2a23263da1170886435b';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'es-Es';

  MovieProvaider(){
    print('MoviesProvaider inicializado');
    this.getOnDisplayMovie();
  }

  getOnDisplayMovie()  async{
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apyKey,
      'language': _lenguage,
      'page': '1'
    });

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    print(nowPlayingResponse.results[1].title);


  }

}