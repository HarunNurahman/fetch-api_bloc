import 'package:fetch_api_bloc/bloc/live_games_bloc.dart';
import 'package:fetch_api_bloc/cubit/genre_cubit.dart';
import 'package:fetch_api_bloc/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LiveGamesBloc()),
        BlocProvider(create: (context) => GenreCubit())
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
