part of 'live_games_bloc.dart';

@immutable
sealed class LiveGamesEvent {}

class OnGetLiveGames extends LiveGamesEvent {}

class OnSaveGames extends LiveGamesEvent {
  final GameModel game;

  OnSaveGames(this.game);
}

class OnDeleteGames extends LiveGamesEvent {
  final GameModel game;

  OnDeleteGames(this.game);
}
