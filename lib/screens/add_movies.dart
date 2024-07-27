import 'package:flutter/material.dart';
import 'class_movie.dart';


class AddMovieScreen extends StatefulWidget {
  @override
  _AddMovieScreenState createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _directorController = TextEditingController();
  final _posterImageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _directorController,
                decoration: InputDecoration(
                  labelText: 'Director',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a director';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _posterImageController,
                decoration: InputDecoration(
                  labelText: 'Enter Poster Url',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a poster image URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
        // In your AddMovieScreen
ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      final movie = Movie(
        name: _nameController.text,
        director: _directorController.text,
        posterImage: _posterImageController.text,
      );
      Navigator.pop(context, movie); // Return the new movie object
    }
  },
  child: Text('Add Movie'),
)
            ],
          ),
        ),
      ),
    );
  }
}