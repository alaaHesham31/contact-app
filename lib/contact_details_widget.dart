import 'dart:io';

import 'package:flutter/material.dart';

class ContactDetailsWidget extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final File? image;
  final VoidCallback onDelete;


  const ContactDetailsWidget({
    Key? key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.image,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 160,
      height: 270,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1D4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Stack(
            children:[ClipRRect(
      borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(16), topRight: Radius.circular(16)),
    child: image != null
    ? Image.file(
    image!,
    height: 170,
    width: double.infinity,
    fit: BoxFit.cover,
    )
        : Image.asset(
    'assets/images/contact_1.png',
    height: 170,
    width: double.infinity,
    fit: BoxFit.cover,
    ),
    ), Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1D4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Color(0xFF29384D),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),],
          ),

          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
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
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:onDelete,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF93E3E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.delete, color: Colors.white, size: 18,),
                        SizedBox(width: 4),
                        Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
