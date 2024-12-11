import 'dart:io';

import 'package:flutter/material.dart';

class ContactDetailsWidget extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final File? image;

  const ContactDetailsWidget({
    Key? key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      width: 180,
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1D4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: image != null
                ? Image.file(
              image!,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Image.asset(
              'assets/images/contact_1.png',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              name,
              style: const TextStyle(
                color: Color(0xFF29384D),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.email, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  email,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF29384D),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.phone, size: 16),
              const SizedBox(width: 8),
              Text(
                phoneNumber,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF29384D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
