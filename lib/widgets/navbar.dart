import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/responsive.dart';
import '../utils/app_theme.dart';
import 'dart:html' as html;

class Navbar extends StatelessWidget {
  final Function(int) onSectionClicked;
  
  const Navbar({
    Key? key,
    required this.onSectionClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo and name section
          Row(
            children: [
              // Flutter Logo with animation
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.rotate(
                    angle: value * 2 * 3.14,
                    child: child,
                  );
                },
                child: const FlutterLogo(
                  size: 30,
                  style: FlutterLogoStyle.markOnly,
                ),
              ),
              const SizedBox(width: 10),
              // Dart Logo
              Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0175C2), // Dart blue color
                ),
                child: const Center(
                  child: Text(
                    "D",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Montasir Opi',
                style: TextStyle(
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 18 : 22,
                ),
              ),
            ],
          ),
          
          // Right side - either menu button or social icons
          if (isMobile)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: AppTheme.secondaryColor,
                  size: 28,
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            )
          else
            _buildSocialIcons(),
        ],
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      children: [
        _buildResumeButton(),
        _buildTechIcon("Flutter", const FlutterLogo(size: 22), "https://flutter.dev"),
        _buildTechIcon("Dart", _buildDartLogo(), "https://dart.dev"),
        _buildSocialIcon(FontAwesomeIcons.github, 'https://github.com/MontasirOpi'),
        _buildSocialIcon(FontAwesomeIcons.linkedin, 'https://www.linkedin.com/in/fahim-montasir-opi-161b65256/'),
        _buildSocialIcon(FontAwesomeIcons.twitter, 'https://twitter.com'),
      ],
    );
  }

  Widget _buildDartLogo() {
    return Container(
      height: 22,
      width: 22,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF0175C2), // Dart blue color
      ),
      child: const Center(
        child: Text(
          "D",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTechIcon(String tooltip, Widget icon, String url) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: () => _launchUrl(url),
          borderRadius: BorderRadius.circular(20),
          child: icon,
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: IconButton(
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(),
        tooltip: url.split('//')[1].split('/')[0].replaceAll('www.', ''),
        icon: FaIcon(
          icon,
          color: AppTheme.textColor,
          size: 20,
        ),
        onPressed: () => _launchUrl(url),
      ),
    );
  }

  Widget _buildResumeButton() {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: ElevatedButton.icon(
        onPressed: () => _downloadResume(),
        icon: const Icon(Icons.description_outlined, size: 16),
        label: const Text('Resume'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.secondaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
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

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }
}

class NavbarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const NavbarItem({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24),
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Text(
          title,
          style: const TextStyle(
            color: AppTheme.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
} 