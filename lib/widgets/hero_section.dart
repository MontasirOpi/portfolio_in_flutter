import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../utils/responsive.dart';

class HeroSection extends StatelessWidget {
  final AnimationController fadeController;
  final void Function(int) onSectionClicked;

  const HeroSection({
    super.key,
    required this.fadeController,
    required this.onSectionClicked,
  });

  @override
  Widget build(BuildContext context) {
    final Animation<double> fadeAnimation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeIn,
    );
    
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
          opacity: fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-0.5, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: fadeController,
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
                  parent: fadeController,
                  curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
                )),
                child: Text(
                  'Fahim Montasir Opi.',
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
                  parent: fadeController,
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
                  parent: fadeController,
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
                  parent: fadeController,
                  curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
                )),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () => onSectionClicked(2),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          foregroundColor: const Color.fromARGB(255, 92, 144, 113),
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
} 