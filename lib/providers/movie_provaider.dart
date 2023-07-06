import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieProvaider extends ChangeNotifier{

  String _apyKey = 'd287ae41c26b2a23263da1170886435b';
  String _baseUrl = 'api.themoviedb.org';
  String _lenguage = 'es-Es';

  MovieProvaider(){
    print('MoviesProvaider inicializado');
    this.getOnDisplayMovie();
  }

  getOnDisplayMovie()  async{
    var url = Uri.https(this._baseUrl, '3/movie/now_playing', {
      'api_key': _apyKey,
      'language': _lenguage,
      'page': '1'
    });

    final response = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(response.body);


    print(decodeData['dates']);
  }

}