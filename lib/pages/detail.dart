import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../models/lecturer.dart';

class DetailPage extends StatelessWidget {
  final Lecturer dosen;

  const DetailPage({super.key, required this.dosen});

  Widget buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          enabled: false,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.green),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildProfilePhoto() {
    final photoUrl = dosen.photo;

    if (photoUrl == null || photoUrl.isEmpty) {
      return CircleAvatar(
        radius: 50,
        backgroundColor: AppColors.primaryGreen,
        child: const Icon(Icons.person, size: 50, color: Colors.white),
      );
    } else {
      return CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(photoUrl),
        backgroundColor: Colors.grey[200],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppGradients.greenGradient,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    'Detail Dosen',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildProfilePhoto(),
            const SizedBox(height: 24),
            buildField('Nama', dosen.name),
            buildField('Email', dosen.email ?? '-'),
            buildField('NIP', dosen.nip ?? '-'),
            buildField('NIK', dosen.nik ?? '-'),
            buildField('Program Studi', dosen.prodi ?? '-'),
          ],
        ),
      ),
    );
  }
}
