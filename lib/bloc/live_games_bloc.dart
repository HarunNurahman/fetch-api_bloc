import 'package:bloc/bloc.dart';
import 'package:fetch_api_bloc/models/game_model.dart';
import 'package:fetch_api_bloc/src/api_services.dart';
import 'package:meta/meta.dart';

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
  }
}
