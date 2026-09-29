import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_typography.dart';

/// Komponen Visual Custom: Auth Header
/// Menampilkan icon branding aplikasi beserta judul dan deskripsi halaman.
class AuthHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container Logo / Icon Modern
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primaryLight.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Icon(
            icon,
            size: 28,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: AppTypography.headingLarge,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: AppTypography.bodyMedium,
        ),
      ],
    );
  }
}
