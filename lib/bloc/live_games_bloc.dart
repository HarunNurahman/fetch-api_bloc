import 'package:fetch_api_bloc/models/game_model.dart';
import 'package:fetch_api_bloc/src/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'live_games_event.dart';
part 'live_games_state.dart';

class LiveGamesBloc extends Bloc<LiveGamesEvent, LiveGamesState> {
  LiveGamesBloc() : super(LiveGamesInitial()) {
    on<LiveGamesEvent>((event, emit) async {
      emit(LiveGamesLoading());

      final result = await GameSource().getLiveGames();

      if (result == null) {
        emit(LiveGamesError('Something went wrong'));
      } else {
        emit(LiveGamesLoaded(result));
      }
    });

    on<OnSaveGames>((event, emit) {
      final games = (state as LiveGamesLoaded).games;
      GameModel selectedGame = event.game.copyWith(isSaved: true);

      int index = games.indexWhere((element) => element.id == selectedGame.id);
      games[index] = selectedGame;

      emit(LiveGamesLoaded(games));
    });

    on<OnDeleteGames>((event, emit) {
      final games = (state as LiveGamesLoaded).games;
      GameModel selectedGame = event.game.copyWith(isSaved: true);

      int index = games.indexWhere((element) => element.id == selectedGame.id);
      games[index] = selectedGame;

      emit(LiveGamesLoaded(games));
    });

    // on<OnSaveGames>((event, emit) {
    //   emit(LiveGamesLoading());

    //   final games = (state as LiveGamesLoaded).games;
    //   GameModel selectedGame = event.game.copyWith(isSaved: true);

    //   int index = games.indexWhere((element) => element.id == selectedGame.id);
    //   games[index] = selectedGame;

    //   emit(LiveGamesLoaded(games));
    // });

    // on<OnDeleteGames>((event, emit) {
    //   emit(LiveGamesLoading());

    //   final games = (state as LiveGamesLoaded).games;
    //   GameModel selectedGame = event.game.copyWith(isSaved: false);

    //   int index = games.indexWhere((element) => element.id == selectedGame.id);
    //   games[index] = selectedGame;

    //   emit(LiveGamesLoaded(games));
    // });
  }
}
