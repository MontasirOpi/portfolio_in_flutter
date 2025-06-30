import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../bloc/projects/projects_bloc.dart';
import '../bloc/projects/projects_state.dart';
import '../utils/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  final AnimationController projectsController;

  const ProjectsSection({
    super.key,
    required this.projectsController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.backgroundColor,
            AppTheme.primaryColor.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeTransition(
            opacity: CurvedAnimation(
              parent: projectsController,
              curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-0.3, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: projectsController,
                curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
              )),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.secondaryColor.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.work_outline,
                      color: AppTheme.secondaryColor,
                      size: 28,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'My Projects',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<ProjectsBloc, ProjectsState>(
            builder: (context, state) {
              if (state is ProjectsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppTheme.secondaryColor),
                  ),
                );
              } else if (state is ProjectsLoaded) {
                return Responsive.responsiveBuilder(
                  context: context,
                  mobile: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.projects.length,
                    itemBuilder: (context, index) {
                      return FadeTransition(
                        opacity: CurvedAnimation(
                          parent: projectsController,
                          curve: Interval(
                            0.3 + (index * 0.1).clamp(0.0, 0.7),
                            0.7 + (index * 0.1).clamp(0.0, 0.3),
                            curve: Curves.easeIn,
                          ),
                        ),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: projectsController,
                            curve: Interval(
                              0.3 + (index * 0.1).clamp(0.0, 0.7),
                              0.7 + (index * 0.1).clamp(0.0, 0.3),
                              curve: Curves.easeOut,
                            ),
                          )),
                          child: ProjectCard(project: state.projects[index]),
                        ),
                      );
                    },
                  ),
                  desktop: StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: List.generate(
                      state.projects.length,
                      (index) => FadeTransition(
                        opacity: CurvedAnimation(
                          parent: projectsController,
                          curve: Interval(
                            0.3 + (index * 0.1).clamp(0.0, 0.7),
                            0.7 + (index * 0.1).clamp(0.0, 0.3),
                            curve: Curves.easeIn,
                          ),
                        ),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(
                              index % 2 == 0 ? -0.3 : 0.3,
                              0.2,
                            ),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: projectsController,
                            curve: Interval(
                              0.3 + (index * 0.1).clamp(0.0, 0.7),
                              0.7 + (index * 0.1).clamp(0.0, 0.3),
                              curve: Curves.easeOut,
                            ),
                          )),
                          child: ProjectCard(project: state.projects[index]),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (state is ProjectsError) {
                return Center(
                  child: Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    'No projects available',
                    style: TextStyle(color: AppTheme.lightTextColor),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
} 