import 'package:aeshthatic/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'add_movies.dart';
import 'class_movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final movieListString = prefs.getString('moviesList');
    if (movieListString != null) {
      final List<dynamic> movieListJson = jsonDecode(movieListString);
      _movies = movieListJson.map((json) => Movie.fromJson(json)).toList();
    }
    setState(() {});
  }

  Future<void> _saveMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final movieListJson = _movies.map((movie) => movie.toJson()).toList();
    prefs.setString('moviesList', jsonEncode(movieListJson));
  }

  void _deleteMovie(int index) {
    setState(() {
      _movies.removeAt(index);
    });
    _saveMovies();
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watched Movies'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _movies.isEmpty
          ? Center(
              child: Text('No movies added'),
            )
          : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return Dismissible(
                  key: Key(movie.name),
                  onDismissed: (direction) {
                    _deleteMovie(index);
                  },
                  child: Card(
                    elevation: 15,
                    child: ListTile(
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteMovie(index);
                        },
                      ),
                      title: Text(
                        movie.name,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      subtitle: Text(movie.director),
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(movie.posterImage),
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        onBackgroundImageError: (error, stackTrace) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final movie = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMovieScreen()),
          );
          if (movie != null) {
            setState(() {
              _movies.add(movie);
            });
            _saveMovies();
          }
        },
        tooltip: 'Add Movie',
        child: Icon(Icons.add),
      ),
    );
  }
}
