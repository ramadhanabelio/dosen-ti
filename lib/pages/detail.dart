import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../models/lecturer.dart';
import '../models/research.dart';
import '../services/api.dart';
import '../components/fab.dart';

class DetailPage extends StatefulWidget {
  final Lecturer dosen;

  const DetailPage({super.key, required this.dosen});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<List<Research>> _researchFuture;

  @override
  void initState() {
    super.initState();
    _researchFuture = ApiService.getResearchByLecturerId(widget.dosen.id);
  }

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
    final photoUrl = widget.dosen.photo;
    if (photoUrl == null || photoUrl.isEmpty) {
      return const CircleAvatar(
        radius: 50,
        backgroundColor: AppColors.primaryGreen,
        child: Icon(Icons.person, size: 50, color: Colors.white),
      );
    } else {
      final fullImageUrl = 'http://127.0.0.1:8000/storage/$photoUrl';
      return CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(fullImageUrl),
        backgroundColor: Colors.grey[200],
      );
    }
  }

  Widget buildResearchCard(Research research) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppGradients.greenGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            research.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            research.year ?? '-',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontFamily: 'PlusJakartaSans',
            ),
          ),
        ],
      ),
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
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppGradients.greenGradient,
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 3),
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
            buildField('Nama', widget.dosen.name),
            buildField('Email', widget.dosen.email ?? '-'),
            buildField('Nomor Induk Pegawai', widget.dosen.nip ?? '-'),
            buildField('Nomor Induk Karyawan', widget.dosen.nik ?? '-'),
            buildField('Program Studi', widget.dosen.prodi ?? '-'),
            const Divider(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Penelitian Dosen:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Research>>(
              future: _researchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Gagal memuat penelitian.');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('Belum ada penelitian.');
                }

                return Column(
                  children:
                      snapshot.data!
                          .map((research) => buildResearchCard(research))
                          .toList(),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: const FAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
