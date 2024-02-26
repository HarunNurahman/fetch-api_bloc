import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:fetch_api_bloc/models/game_model.dart';
import 'package:http/http.dart' as http;

class GameSource {
  String baseUrl = "https://www.freetogame.com/api/games";

  Future<List<GameModel>?> getLiveGames() async {
    final response = await http.get(Uri.parse(baseUrl));
    DMethod.logResponse(response);

    try {
      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        List<GameModel> games =
            list.map((e) => GameModel.fromJson(Map.from(e))).toList();
        return games;
      } else {
        return null;
      }
    } catch (e) {
      DMethod.log(e.toString());
      throw Exception(e);
    }
  }
}
