import 'package:fetch_api_bloc/bloc/live_games_bloc.dart';
import 'package:fetch_api_bloc/cubit/genre_cubit.dart';
import 'package:fetch_api_bloc/models/game_model.dart';
import 'package:fetch_api_bloc/pages/widgets/game_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> genres = ['Shooter', 'MMOARPG', 'ARPG', 'Strategy', 'Fighting'];

  @override
  void initState() {
    context.read<LiveGamesBloc>().add(OnGetLiveGames());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Games'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<GenreCubit, String>(
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: genres.map((genre) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () {
                            context.read<GenreCubit>().onSelectedGenre(genre);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: genre == state
                                  ? Colors.blue
                                  : Colors.transparent,
                              border: Border.all(
                                color: Colors.black87,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              genre,
                              style: TextStyle(
                                color: genre == state
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<LiveGamesBloc, LiveGamesState>(
              builder: (context, state) {
                if (state is LiveGamesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is LiveGamesError) {
                  return Center(child: Text(state.message));
                }
                if (state is LiveGamesLoaded) {
                  List<GameModel> games = state.games;
                  if (games.isEmpty) {
                    return const Center(child: Text('No games found'));
                  }
                  return BlocBuilder<GenreCubit, String>(
                    builder: (context, genreState) {
                      List<GameModel> list = games
                          .where((element) => element.genre == genreState)
                          .toList();

                      return Stack(
                        children: [
                          GridView.builder(
                            itemCount: list.length,
                            padding: const EdgeInsets.all(8),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              GameModel game = list[index];
                              return GameItems(
                                game: game,
                                ontap: () {
                                  if (game.isSaved) {
                                    context
                                        .read<LiveGamesBloc>()
                                        .add(OnDeleteGames(game));
                                  } else {
                                    context
                                        .read<LiveGamesBloc>()
                                        .add(OnSaveGames(game));
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
