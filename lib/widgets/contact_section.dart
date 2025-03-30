import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../utils/responsive.dart';

class ContactSection extends StatelessWidget {
  final AnimationController contactController;
  final Function() launchEmail;

  const ContactSection({
    Key? key,
    required this.contactController,
    required this.launchEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              parent: contactController,
              curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: contactController,
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
              parent: contactController,
              curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: contactController,
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
              parent: contactController,
              curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: contactController,
                curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
              )),
              child: ElevatedButton(
                onPressed: launchEmail,
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
} 