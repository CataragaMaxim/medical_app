import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme.dart';

class ServiceIcon extends StatelessWidget {
  final String name;
  final String iconUrl;
  final bool isSelected;
  final VoidCallback? onTap;

  const ServiceIcon({
    super.key,
    required this.name,
    required this.iconUrl,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.backgroundGrey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SvgPicture.network(
                iconUrl,
                colorFilter: isSelected
                    ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                    : null,
                placeholderBuilder: (_) => Icon(
                  Icons.medical_services,
                  color: isSelected ? Colors.white : AppColors.primary,
                ),
              ),
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
      ),
    );
  }
}