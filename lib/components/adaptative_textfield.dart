import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(String) onSubmitted;
  final TextInputType? keyboardType;

  AdaptativeTextField({
    required this.controller,
    required this.label,
    required this.onSubmitted,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: const EdgeInsets.only(
						bottom: 10,
					),
          child: CupertinoTextField(
              controller: controller,
						keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              placeholder: label,
						padding: const EdgeInsets.symmetric(
							horizontal: 6,
							vertical: 12,
						),
            ),
        )
        : TextField(
            controller: controller,
						keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
