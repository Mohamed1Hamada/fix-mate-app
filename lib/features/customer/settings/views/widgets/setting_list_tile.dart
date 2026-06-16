import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsListTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.kPrimaryColor, width: 1)),
      margin: EdgeInsets.symmetric(vertical: SizeConfig.height * 0.006),
      child: ListTile(
        leading: Icon(icon, color: AppColors.kPrimaryColor),
        title: Text(
          title,
          style: AppTextStyles.title16BlackW500,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: SizeConfig.width * 0.05,
        ),
        onTap: onTap,
      ),
    );
  }
}
