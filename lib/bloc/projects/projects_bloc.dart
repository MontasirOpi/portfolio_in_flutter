import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/projects_repository.dart';
import 'projects_event.dart';
import 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final ProjectsRepository _projectsRepository;
  
  ProjectsBloc({required ProjectsRepository projectsRepository}) 
      : _projectsRepository = projectsRepository,
        super(const ProjectsInitial()) {
    on<LoadProjects>(_onLoadProjects);
    on<RefreshProjects>(_onRefreshProjects);
  }

  Future<void> _onLoadProjects(
    LoadProjects event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(const ProjectsLoading());
    try {
      final projects = await _projectsRepository.getProjects();
      emit(ProjectsLoaded(projects));
    } catch (e) {
      emit(ProjectsError(e.toString()));
    }
  }

  Future<void> _onRefreshProjects(
    RefreshProjects event,
    Emitter<ProjectsState> emit,
  ) async {
    try {
      final projects = await _projectsRepository.getProjects();
      emit(ProjectsLoaded(projects));
    } catch (e) {
      emit(ProjectsError(e.toString()));
    }
  }
} 