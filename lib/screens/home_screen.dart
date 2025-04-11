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
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/resume_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  // Animation controllers
  late final AnimationController _fadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..forward();

  late final Animation<double> _fadeAnimation = CurvedAnimation(
    parent: _fadeController,
    curve: Curves.easeIn,
  );

  late final AnimationController _aboutController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  late final Animation<double> _aboutFadeAnimation = CurvedAnimation(
    parent: _aboutController,
    curve: Curves.easeIn,
  );

  late final AnimationController _projectsController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  late final AnimationController _contactController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectsBloc>().add(const LoadProjects());
    });
    _scrollController.addListener(_handleScroll);
  }

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
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Navbar(
          onSectionClicked: _scrollToSection,
        ),
      ),
      drawer: Responsive.isMobile(context) ? _buildDrawer(context) : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            HeroSection(
              fadeController: _fadeController,
              onSectionClicked: _scrollToSection,
              viewResume: _viewResume,
            ),
            AboutSection(
              aboutController: _aboutController,
            ),
            ProjectsSection(
              projectsController: _projectsController,
            ),
            ContactSection(
              contactController: _contactController,
              launchEmail: _launchEmail,
            ),
            FooterSection(
              launchUrl: _launchUrl,
            ),
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
                  'Fahim Montasir Opi',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  _downloadResume();
                  Navigator.pop(context);
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
      onTap: () {
        _scrollToSection(index);
        Navigator.pop(context);
      },
    );
  }

  void _scrollToSection(int index) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    double offset = 0;
    switch (index) {
      case 0: offset = 0; break;
      case 1: offset = screenHeight * 0.9; break;
      case 2: offset = screenHeight * 1.8; break;
      case 3: offset = screenHeight * 2.7; break;
    }
    
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'montasiropi@gmail.com',
      queryParameters: {
        'subject': 'Hello from Portfolio Website',
      },
    );
    
    try {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch email: $e');
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }

  void _viewResume(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ResumeDialog(downloadResume: _downloadResume),
    );
  }

  void _downloadResume() {
    final anchor = html.AnchorElement(
      href: 'assets/cv/fahim_montasir_resume.pdf',
    );
    anchor.setAttribute('download', 'Fahim_Montasir_Opi_Resume.pdf');
    anchor.click();
  }
} 