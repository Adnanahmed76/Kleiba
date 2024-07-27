class Movie {
  final String name;
  final String director;
  final String posterImage;

  Movie({
    required this.name,
    required this.director,
    required this.posterImage,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'director': director,
        'posterImage': posterImage,
      };

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        name: json['name'],
        director: json['director'],
        posterImage: json['posterImage'],
      );
}
