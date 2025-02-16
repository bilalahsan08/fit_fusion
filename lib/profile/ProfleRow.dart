import 'package:flutter/material.dart';

class ProfileRow extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onPressed;

  const ProfileRow({
    super.key,
    required this.title,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey.withOpacity(0.05),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onPressed,
            splashColor: Colors.grey.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align title and value
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
