import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bloc/projects/projects_bloc.dart';
import 'repositories/projects_repository.dart';
import 'screens/home_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProjectsRepository>(
          create: (context) => ProjectsRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProjectsBloc>(
            create: (context) => ProjectsBloc(
              projectsRepository: context.read<ProjectsRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Portfolio',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeData,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
