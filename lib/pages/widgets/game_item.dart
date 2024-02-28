import 'package:extended_image/extended_image.dart';
import 'package:fetch_api_bloc/models/game_model.dart';
import 'package:flutter/material.dart';

class GameItems extends StatelessWidget {
  const GameItems({
    super.key,
    required this.game,
    required this.ontap,
  });

  final GameModel game;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ExtendedImage.network(
            game.thumbnail!,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment(0, -0.3),
                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
              ),
            ),
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(8),
              child: Text(
                game.title ?? "",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Positioned(
          right: 4,
          child: IconButton.filledTonal(
            onPressed: ontap,
            icon: game.isSaved
                ? const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )
                : const Icon(
                    Icons.star_outline,
                    color: Colors.white,
                  ),
          ),
        ),
      ],
    );
  }
}
