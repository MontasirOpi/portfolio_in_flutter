import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/app_theme.dart';

class FooterSection extends StatelessWidget {
  final Function(String) launchUrl;

  const FooterSection({
    super.key,
    required this.launchUrl,
  });

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => launchUrl('https://github.com/MontasirOpi'),
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.linkedin,
                  color: AppTheme.textColor,
                ),
                onPressed: () => launchUrl('https://www.linkedin.com/in/fahim-montasir-opi-161b65256/'),
              ),
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.twitter,
                  color: AppTheme.textColor,
                ),
                onPressed: () => launchUrl('https://twitter.com'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Designed & Built by Fahim Montasir Opi',
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
} 