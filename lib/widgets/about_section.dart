import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../utils/responsive.dart';

class AboutSection extends StatelessWidget {
  final AnimationController aboutController;

  const AboutSection({
    super.key,
    required this.aboutController,
  });

  @override
  Widget build(BuildContext context) {
    final Animation<double> aboutAnimation = CurvedAnimation(
      parent: aboutController,
      curve: Curves.easeIn,
    );
    
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
            opacity: aboutAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-0.3, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: aboutController,
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
                    parent: aboutController,
                    curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: aboutController,
                      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
                    )),
                    child: _buildProfileImage(),
                  ),
                ),
                const SizedBox(height: 30),
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: aboutController,
                    curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: aboutController,
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
                      parent: aboutController,
                      curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
                    ),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-0.3, 0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: aboutController,
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
                      parent: aboutController,
                      curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
                    ),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.3, 0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: aboutController,
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
} 