import 'package:flutter/material.dart';
import '../theme.dart';

class ServiceIcon extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isSelected;

  const ServiceIcon({
    super.key,
    required this.name,
    required this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.backgroundGrey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            color: isSelected ? AppColors.white : AppColors.primary,
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 13,
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}