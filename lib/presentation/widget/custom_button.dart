import 'package:flutter/material.dart';

import '../../config/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.label, required this.onTab})
      : super(key: key);
  final String label;
  final Function onTab;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () => onTab(),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
