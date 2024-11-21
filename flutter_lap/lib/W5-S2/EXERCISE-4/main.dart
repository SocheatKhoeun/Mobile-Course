import 'package:flutter/material.dart';
import 'package:flutter_lap/W5-S2/EXERCISE-4/joke.dart';

// Favorite jokes data: Stored in the favoriteIndex variable.
// Widget storing favorite joke: FavoriteJokesApp (in its state).
// Stateful widget: FavoriteJokesApp.
// Stateless widget: JokeCard.
// Widget interaction: JokeCard receives data and triggers the onFavoriteSelected callback, updating the state in FavoriteJokesApp.
// Callback function: onFavoriteSelected, used to notify and update the favorite joke.

void main() => runApp(MaterialApp(
      home: FavoriteJokesApp(),
    ));

class FavoriteJokesApp extends StatefulWidget {
  @override
  State<FavoriteJokesApp> createState() => _FavoriteJokesAppState();
}

class _FavoriteJokesAppState extends State<FavoriteJokesApp> {
  final List<Joke> jokes = List.generate(
    20,
    (index) => Joke(
      title: "Joke ${index + 1}",
      description: "description",
    ),
  );

  int? favoriteIndex;

  void setFavorite(int index) {
    setState(() {
      favoriteIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: const Text("Favorite Jokes"),
      ),
      body: ListView(
        children: [
          for (int index = 0; index < jokes.length; index++)
            JokeCard(
              joke: jokes[index],
              isFavorite: favoriteIndex == index,
              onFavoriteSelected: () => setFavorite(index),
          ),
        ],
      ),
    );
  }
}

