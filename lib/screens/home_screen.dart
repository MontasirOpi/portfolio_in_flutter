import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:html' as html;
import '../bloc/projects/projects_bloc.dart';
import '../bloc/projects/projects_event.dart';
import '../bloc/projects/projects_state.dart';
import '../utils/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/navbar.dart';
import '../widgets/project_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load projects when screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectsBloc>().add(const LoadProjects());
    });
    
    // Setup scroll listener for animations
    _scrollController.addListener(_handleScroll);
  }
  
  // Add scroll listener method
  void _handleScroll() {
    final screenHeight = MediaQuery.of(context).size.height;
    if (_scrollController.offset > screenHeight * 0.7 && !_aboutController.isAnimating && !_aboutController.isCompleted) {
      _aboutController.forward();
    }
    if (_scrollController.offset > screenHeight * 1.6 && !_projectsController.isAnimating && !_projectsController.isCompleted) {
      _projectsController.forward();
    }
    if (_scrollController.offset > screenHeight * 2.5 && !_contactController.isAnimating && !_contactController.isCompleted) {
      _contactController.forward();
    }
  }

  // Animation controllers and animations
  late final AnimationController _fadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..forward();

  late final Animation<double> _fadeAnimation = CurvedAnimation(
    parent: _fadeController,
    curve: Curves.easeIn,
  );

  // About section animations
  late final AnimationController _aboutController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  late final Animation<double> _aboutFadeAnimation = CurvedAnimation(
    parent: _aboutController,
    curve: Curves.easeIn,
  );

  // Projects section animations
  late final AnimationController _projectsController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  // Contact section animations
  late final AnimationController _contactController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    _aboutController.dispose();
    _projectsController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leadingWidth: 0,
        titleSpacing: 16,
        title: Navbar(
          onSectionClicked: _scrollToSection,
        ),
      ),
      endDrawer: _buildDrawer(context),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildAboutSection(context),
            _buildProjectsSection(context),
            _buildContactSection(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.primaryColor,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppTheme.cardColor,
              ),
              child: Center(
                child: Text(
                  'Montasir Opi',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            _buildDrawerItem(context, 'Home', 0, Icons.home),
            _buildDrawerItem(context, 'About', 1, Icons.person),
            _buildDrawerItem(context, 'Projects', 2, Icons.work),
            _buildDrawerItem(context, 'Contact', 3, Icons.email),
            const Divider(color: AppTheme.secondaryColor),
            // Resume download button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  _downloadResume();
                  Navigator.pop(context); // Close drawer after downloading
                },
                icon: const Icon(Icons.file_download),
                label: const Text('Download Resume'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(color: AppTheme.secondaryColor),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                      color: AppTheme.textColor,
                    ),
                    onPressed: () => _launchUrl('https://github.com/MontasirOpi'),
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: AppTheme.textColor,
                    ),
                    onPressed: () => _launchUrl('https://www.linkedin.com/in/fahim-montasir-opi-161b65256/'),
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.twitter,
                      color: AppTheme.textColor,
                    ),
                    onPressed: () => _launchUrl('https://twitter.com'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, int index, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.secondaryColor),
      title: Text(title, style: const TextStyle(color: AppTheme.textColor)),
      onTap: () => _scrollToSection(index),
    );
  }

  void _scrollToSection(int index) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    double offset = 0;
    switch (index) {
      case 0: // Home
        offset = 0;
        break;
      case 1: // About
        offset = screenHeight * 0.9;
        break;
      case 2: // Projects
        offset = screenHeight * 1.8;
        break;
      case 3: // Contact
        offset = screenHeight * 2.7;
        break;
    }
    
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
    
    // Close drawer if it's open - use Navigator.maybeOf to avoid errors
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: Responsive.getScreenHeight(context) * 0.9,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.backgroundColor,
            AppTheme.primaryColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-0.5, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _fadeController,
                  curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
                )),
                child: Text(
                  'Hello, my name is',
                  style: TextStyle(
                    color: AppTheme.secondaryColor,
                    fontSize: Responsive.isMobile(context) ? 16 : 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _fadeController,
                  curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
                )),
                child: Text(
                  'Montasir Opi.',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.isMobile(context) ? 40 : 60,
                        shadows: [
                          Shadow(
                            color: AppTheme.secondaryColor.withOpacity(0.4),
                            offset: const Offset(2, 2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                ),
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _fadeController,
                  curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
                )),
                child: Text(
                  'I build mobile applications.',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: AppTheme.lightTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.isMobile(context) ? 30 : 48,
                      ),
                ),
              ),
              const SizedBox(height: 30),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.5),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _fadeController,
                  curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
                )),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.cardColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppTheme.secondaryColor.withOpacity(0.2),
                    ),
                  ),
                  width: Responsive.isMobile(context)
                      ? Responsive.getScreenWidth(context) * 0.9
                      : Responsive.getScreenWidth(context) * 0.5,
                  child: Text(
                    'I am a Flutter developer specializing in building exceptional mobile applications. '
                    'Currently, I\'m focused on creating user-friendly and performant cross-platform apps.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.lightTextColor,
                          height: 1.6,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _fadeController,
                  curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
                )),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () => _scrollToSection(2),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          backgroundColor: AppTheme.secondaryColor,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          elevation: 8,
                          shadowColor: AppTheme.secondaryColor.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Check out my work'),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 18),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () => _viewResume(context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          backgroundColor: AppTheme.cardColor,
                          foregroundColor: AppTheme.secondaryColor,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          elevation: 8,
                          shadowColor: AppTheme.primaryColor.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: AppTheme.secondaryColor, width: 2),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('View Resume'),
                            SizedBox(width: 8),
                            Icon(Icons.description_outlined, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.cardColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
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
            opacity: _aboutFadeAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-0.3, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _aboutController,
                curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
              )),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 5,
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'About Me',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Responsive.responsiveBuilder(
            context: context,
            mobile: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _aboutController,
                    curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _aboutController,
                      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
                    )),
                    child: _buildProfileImage(),
                  ),
                ),
                const SizedBox(height: 30),
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _aboutController,
                    curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _aboutController,
                      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
                    )),
                    child: _buildAboutText(context),
                  ),
                ),
              ],
            ),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _aboutController,
                      curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
                    ),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-0.3, 0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: _aboutController,
                        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
                      )),
                      child: _buildProfileImage(),
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                Expanded(
                  flex: 3,
                  child: FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _aboutController,
                      curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
                    ),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.3, 0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: _aboutController,
                        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
                      )),
                      child: _buildAboutText(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.cardColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppTheme.secondaryColor.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: AppTheme.cardColor.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            'Hello! I\'m Montasir, a mobile app developer specializing in Flutter. I enjoy creating useful applications that solve real-world problems and provide great user experiences.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textColor,
                  height: 1.6,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
          ),
        ),
        const SizedBox(height: 25),
        Text(
          'I\'ve developed various applications ranging from e-commerce and grocery shopping apps to productivity tools and weather applications. I have a strong focus on clean code architecture and effective state management using BLoC pattern.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.lightTextColor,
                height: 1.6,
                fontSize: 15,
                letterSpacing: 0.3,
              ),
        ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppTheme.secondaryColor.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.code,
                    color: AppTheme.secondaryColor,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Technologies I work with:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildSkillItem('Flutter'),
                  _buildSkillItem('Dart'),
                  _buildSkillItem('BLoC Pattern'),
                  _buildSkillItem('Firebase'),
                  _buildSkillItem('REST APIs'),
                  _buildSkillItem('UI/UX Design'),
                  _buildSkillItem('CSV/JSON'),
                  _buildSkillItem('State Management'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillItem(String skill) {
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppTheme.secondaryColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: AppTheme.secondaryColor,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            skill,
            style: const TextStyle(
              color: AppTheme.textColor,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(150),
        border: Border.all(
          color: AppTheme.secondaryColor,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.secondaryColor.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(150),
        child: Image.asset(
          'assets/images/opi.jpg',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            debugPrint('Error loading image: $error');
            return Image.network(
              'https://images.unsplash.com/photo-1511367461989-f85a21fda167',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: AppTheme.cardColor,
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
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
              parent: _projectsController,
              curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-0.3, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _projectsController,
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
                          parent: _projectsController,
                          curve: Interval(
                            0.3 + (index * 0.1).clamp(0.0, 0.7), // Staggered animation
                            0.7 + (index * 0.1).clamp(0.0, 0.3),
                            curve: Curves.easeIn,
                          ),
                        ),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _projectsController,
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
                          parent: _projectsController,
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
                            parent: _projectsController,
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

  Widget _buildContactSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.4),
            AppTheme.backgroundColor,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: CurvedAnimation(
              parent: _contactController,
              curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _contactController,
                curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
              )),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppTheme.secondaryColor.withOpacity(0.3)),
                ),
                child: Text(
                  'Get In Touch',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          FadeTransition(
            opacity: CurvedAnimation(
              parent: _contactController,
              curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _contactController,
                curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
              )),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.secondaryColor.withOpacity(0.1)),
                ),
                width: Responsive.isMobile(context)
                    ? Responsive.getScreenWidth(context) * 0.9
                    : Responsive.getScreenWidth(context) * 0.5,
                child: Text(
                  'I\'m currently looking for new opportunities, my inbox is always open. '
                  'Whether you have a question or just want to say hi, I\'ll try my best to get back to you!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.lightTextColor,
                        height: 1.6,
                        letterSpacing: 0.5,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          FadeTransition(
            opacity: CurvedAnimation(
              parent: _contactController,
              curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _contactController,
                curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
              )),
              child: ElevatedButton(
                onPressed: () => _launchEmail(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: AppTheme.secondaryColor,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                  elevation: 8,
                  shadowColor: AppTheme.secondaryColor.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.email_outlined),
                    SizedBox(width: 10),
                    Text('Say Hello'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.github,
                  color: AppTheme.textColor,
                ),
                onPressed: () => _launchUrl('https://github.com/MontasirOpi'),
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.linkedin,
                  color: AppTheme.textColor,
                ),
                onPressed: () => _launchUrl('https://www.linkedin.com/in/fahim-montasir-opi-161b65256/'),
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.twitter,
                  color: AppTheme.textColor,
                ),
                onPressed: () => _launchUrl('https://twitter.com'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Designed & Built by Montasir Opi',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 10),
          Text(
            '© ${DateTime.now().year} All Rights Reserved',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'fahimmontasiropi@gmail.com',
      queryParameters: {
        'subject': 'Hello from Portfolio Website',
      },
    );
    
    try {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Handle error gracefully
      debugPrint('Could not launch email: $e');
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Handle error gracefully
      debugPrint('Could not launch $url: $e');
    }
  }

  void _viewResume(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(
          horizontal: Responsive.isMobile(context) ? 20 : 40,
          vertical: Responsive.isMobile(context) ? 20 : 40,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: Responsive.getScreenHeight(context) * 0.8,
            maxWidth: Responsive.getScreenWidth(context) * 0.8,
          ),
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.secondaryColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppTheme.secondaryColor.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title bar with close and download buttons
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  border: Border(
                    bottom: BorderSide(color: AppTheme.secondaryColor.withOpacity(0.3), width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Resume - Fahim Montasir Opi',
                      style: TextStyle(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _downloadResume(),
                          tooltip: 'Download Resume',
                          icon: Icon(
                            Icons.download,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          tooltip: 'Close',
                          icon: Icon(
                            Icons.close,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // PDF viewer (showing a placeholder with download button for now)
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.picture_as_pdf,
                          size: 100,
                          color: AppTheme.secondaryColor.withOpacity(0.7),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Resume Available for Download',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'The PDF is ready to be downloaded to your device.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.lightTextColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () => _downloadResume(),
                          icon: const Icon(Icons.download),
                          label: const Text('Download Resume'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Note: For web security reasons, direct PDF viewing is limited. Please use the download button to view the full resume.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.lightTextColor,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _downloadResume() {
    final anchor = html.AnchorElement(
      href: 'assets/cv/fahim%20montasir%20opi%20.pdf',
    );
    anchor.download = 'Fahim_Montasir_Opi_Resume.pdf';
    anchor.click();
  }
} 