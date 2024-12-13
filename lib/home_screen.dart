import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import 'add_contact_modal.dart';
import 'contact_details_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> contacts = [];

  void openModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFF29384D), // Set background here
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: 460,
            child: AddContactModal(
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
            ),
          ),
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two cards per row
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 160 / 270, // Correct aspect ratio
          ),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return ContactDetailsWidget(
              name: contact["name"]!,
              email: contact["email"]!,
              phoneNumber: contact["phone"]!,
              image: contact["image"]!,
    onDelete: () {
      setState(() {
        contacts.removeAt(index); // Delete the contact
      });
    },
            );
          },
        ),

      ),
      floatingActionButton: Stack(
        children: [
          if (contacts.length < 6)
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: openModal,
                child: const Icon(Icons.add, color: Color(0xFF29384D)),
                backgroundColor: const Color(0xFFFFF1D4),
              ),
            ),
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



