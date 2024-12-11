import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List to store contact details
  List<Map<String, dynamic>> contacts = [];

  void openModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddContactModal(
          onSave: (String newName, String newEmail, String newPhone, File? newImage) {
            if (contacts.length < 6) {
              setState(() {
                contacts.add({
                  "name": newName,
                  "email": newEmail,
                  "phone": newPhone,
                  "image": newImage,
                });
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("You can only add up to 6 contacts."),
                ),
              );
            }
          },
        );
      },
    );
  }

  void deleteAllContacts() {
    setState(() {
      contacts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF29384D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF29384D),
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Image.asset('assets/images/route.png', fit: BoxFit.fill),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: contacts.isEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/empty_list.json'),
            const Text(
              'No Contacts Added',
              style: TextStyle(
                color: Color(0xFFFFF1D4),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
            : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two widgets per row
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 3 / 4, // Aspect ratio for the cards
          ),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return ContactDetailsWidget(
              name: contact["name"],
              email: contact["email"],
              phoneNumber: contact["phone"],
              image: contact["image"],
            );
          },
        ),
      ),
      floatingActionButton: Stack(
        children: [
          // Add Contact Button
          if (contacts.length < 6)
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: openModal,
                child: const Icon(Icons.add, color: Colors.white),
                backgroundColor: const Color(0xFF4CAF50),
              ),
            ),
          // Delete All Contacts Button
          Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton(
              onPressed: deleteAllContacts,
              child: const Icon(Icons.delete, color: Colors.white),
              backgroundColor: const Color(0xFFF93E3E),
            ),
          ),
        ],
      ),
    );
  }
}

class AddContactModal extends StatelessWidget {
  final Function(String, String, String, File?) onSave;

  const AddContactModal({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Call onSave with new data
                onSave(
                  nameController.text,
                  emailController.text,
                  phoneController.text,
                  null, // Placeholder for image upload logic
                );
                Navigator.of(context).pop(); // Close modal
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

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
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Image.asset(
              'assets/images/contact_1.png',
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF29384D),
              fontSize: 14,
              fontWeight: FontWeight.w500,
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
