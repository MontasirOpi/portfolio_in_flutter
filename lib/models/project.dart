import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String githubUrl;
  final List<String> technologies;
  final DateTime date;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.githubUrl,
    required this.technologies,
    required this.date,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        githubUrl,
        technologies,
        date,
      ];
} 