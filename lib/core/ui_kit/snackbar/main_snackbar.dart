import 'package:flutter/material.dart';
import 'package:state_selector/core/extensions/color_extension.dart';

import '../../assets/assets.gen.dart';

class MainSnackbar extends StatelessWidget {
  const MainSnackbar({
    required this.icon,
    required this.title,
    this.backgroundColor,
    this.subtitle,
    this.actionText,
    this.onTap,
    super.key,
  });

  factory MainSnackbar.error({
    required BuildContext context,
    required String title,
    String? subtitle,
  }) {
    return MainSnackbar(
      icon: Assets.icons.cross.svg(
        colorFilter: Colors.white.filter,
        height: 24,
      ),
      title: title,
      subtitle: subtitle,
      backgroundColor: Colors.red,
    );
  }

  final Widget icon;
  final String title;
  final String? subtitle;
  final String? actionText;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DefaultTextStyle(
        style: const TextStyle(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: backgroundColor ?? Colors.red,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  icon,
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              if (subtitle != null || actionText != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (subtitle != null)
                      Column(
                        children: [
                          const SizedBox(height: 6),
                          Text(
                            subtitle!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    if (actionText != null)
                      Column(
                        children: [
                          const SizedBox(height: 6),
                          Text(
                            actionText!,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
