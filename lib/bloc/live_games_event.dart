part of 'live_games_bloc.dart';

@immutable
sealed class LiveGamesEvent {}

class OnGetLiveGames extends LiveGamesEvent {}
