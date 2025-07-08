import 'package:flutter/material.dart';
import '../models/research.dart';
import '../constants/theme.dart';
import 'edit.dart';

class ShowPage extends StatelessWidget {
  final Research research;
  final String token;

  const ShowPage({super.key, required this.research, required this.token});

  Widget buildField(String label, String? value) {
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
          initialValue: value ?? '-',
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
            actions: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => EditPage(token: token, research: research),
                    ),
                  );
                },
              ),
            ],
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppGradients.greenGradient,
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(
                    'Detail Penelitian',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
            buildField('Judul', research.title),
            buildField('Tahun', research.year?.toString()),
            buildField('Bidang', research.field),
            buildField('Abstrak', research.abstract),
          ],
        ),
      ),
    );
  }
}
