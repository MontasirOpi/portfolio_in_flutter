import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../utils/app_theme.dart';
import '../utils/responsive.dart';

class ResumeDialog extends StatelessWidget {
  final void Function() downloadResume;

  const ResumeDialog({
    Key? key,
    required this.downloadResume,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                        onPressed: downloadResume,
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
                        onPressed: downloadResume,
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
    );
  }
} 