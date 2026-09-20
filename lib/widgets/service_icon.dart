import 'package:flutter/material.dart';
import '../theme.dart';

class ServiceIcon extends StatelessWidget {
  final String name;
  final IconData icon;

  const ServiceIcon({
    super.key,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: AppColors.backgroundGrey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: AppColors.primary, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}