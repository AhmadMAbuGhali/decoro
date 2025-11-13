import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_colors.dart';

class LoginToggle extends StatelessWidget {
  final bool isEmailSelected;
  final ValueChanged<bool> onChanged;

  const LoginToggle({
    super.key,
    required this.isEmailSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        children: [
          _buildOption(context, 'Email', isEmailSelected, true),
          _buildOption(context, 'Phone', !isEmailSelected, false),
        ],
      ),
    );
  }

  Expanded _buildOption(
      BuildContext context, String text, bool isActive, bool value) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isActive
                ? [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.25),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ]
                : [],
          ),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.grey.shade700,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}