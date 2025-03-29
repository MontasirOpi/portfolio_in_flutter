import '../models/project.dart';

class ProjectsRepository {
  // Projects data from the provided GitHub repositories
  Future<List<Project>> getProjects() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    return [
      Project(
        id: '1',
        title: 'Grocery App with BLoC',
        description: 'A grocery shopping application built with Flutter using BLoC pattern for state management. Features include product listings, shopping cart, and order management.',
        imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80',
        githubUrl: 'https://github.com/MontasirOpi/grocery_app_using_bloc',
        technologies: ['Flutter', 'Dart', 'BLoC', 'State Management'],
        date: DateTime(2023, 7, 15),
      ),
      Project(
        id: '2',
        title: 'Todo App with CSV/JSON',
        description: 'A simple Todo List App built with Flutter that allows adding, editing, and deleting todos. Features CSV persistence, JSON import, and export functionality.',
        imageUrl: 'https://images.unsplash.com/photo-1540350394557-8d14678e7f91?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80',
        githubUrl: 'https://github.com/MontasirOpi/to_do',
        technologies: ['Flutter', 'Dart', 'File I/O', 'CSV', 'JSON'],
        date: DateTime(2023, 5, 20),
      ),
      Project(
        id: '3',
        title: 'Weather App',
        description: 'A weather application built with Flutter that provides current weather information, forecasts, and location-based weather data through API integration.',
        imageUrl: 'https://images.unsplash.com/photo-1534088568595-a066f410bcda?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80',
        githubUrl: 'https://github.com/MontasirOpi/weather-app-using-flutter',
        technologies: ['Flutter', 'REST API', 'Geolocation', 'Weather API'],
        date: DateTime(2023, 3, 10),
      ),
      Project(
        id: '4',
        title: 'Fast Food App',
        description: 'A food delivery application for fast food built with Flutter. Features include menu browsing, food ordering, cart management, and order tracking.',
        imageUrl: 'https://images.unsplash.com/photo-1561758033-d89a9ad46330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80',
        githubUrl: 'https://github.com/MontasirOpi/FAST-FOOD-APP-FLUTTER',
        technologies: ['Flutter', 'UI/UX', 'Firebase', 'State Management'],
        date: DateTime(2023, 2, 5),
      ),
    ];
  }
} 