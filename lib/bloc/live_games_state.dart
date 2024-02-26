part of 'live_games_bloc.dart';

@immutable
sealed class LiveGamesState {}

final class LiveGamesInitial extends LiveGamesState {}

final class LiveGamesLoading extends LiveGamesState {}

final class LiveGamesError extends LiveGamesState {
  final String message;

  LiveGamesError(this.message);
}

final class LiveGamesLoaded extends LiveGamesState {
  final List<GameModel> games;

  LiveGamesLoaded(this.games);
}
