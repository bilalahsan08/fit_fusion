import 'package:flutter/material.dart';

class SettingRow extends StatelessWidget {
  final String title;
  final String icon;
  final bool isIconCircle;
  final VoidCallback onPressed;

  const SettingRow({
    super.key,
    required this.title,
    required this.icon,
    this.isIconCircle = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.05),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        splashColor: Colors.grey.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(isIconCircle ? 50 : 15),
                child: Image.asset(
                  icon,
                  width: 22,
                  height: 22,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios, // Next icon
                size: 18,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
