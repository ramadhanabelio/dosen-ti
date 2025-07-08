import 'package:dosen_ti/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/research.dart';
import '../models/lecturer.dart';
import 'create.dart';
import 'show.dart';
import 'login.dart';
import '../services/api.dart';

class DashboardPage extends StatefulWidget {
  final Lecturer lecturer;
  final String token;

  const DashboardPage({super.key, required this.lecturer, required this.token});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<List<Research>> _researchFuture;

  @override
  void initState() {
    super.initState();
    _loadResearch();
  }

  void _loadResearch() {
    _researchFuture = ApiService.getMyResearch(widget.token);
  }

  void _navigateToCreate() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CreatePage(token: widget.token)),
    );
    setState(() => _loadResearch());
  }

  void _navigateToShow(Research research) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ShowPage(research: research, token: widget.token),
      ),
    ).then((_) => setState(() => _loadResearch()));
  }

  void _deleteResearch(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Konfirmasi Hapus'),
            content: const Text(
              'Apakah Anda yakin ingin menghapus penelitian ini?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Hapus'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await ApiService.deleteResearch(widget.token, id);
      setState(() => _loadResearch());
    }
  }

  void _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Keluar'),
            content: const Text('Anda yakin ingin keluar?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Keluar'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }

  Widget buildItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value ?? '-', style: const TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }

  Widget buildProfilePhoto() {
    final photoUrl = widget.lecturer.photo;
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
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => _deleteResearch(research.id),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Hapus',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => _navigateToShow(research),
        child: Container(
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
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    'images/white.png', // sesuaikan dengan asetmu
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    research.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tahun: ${research.year ?? '-'}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  if (research.field != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Bidang: ${research.field}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
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
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppGradients.greenGradient,
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(
                        'Dashboard Dosen',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 40,
                    child: IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: _logout,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryGreen,
        onPressed: _navigateToCreate,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProfilePhoto(),
            const SizedBox(height: 24),
            buildItem('Nama', widget.lecturer.name),
            buildItem('NIP', widget.lecturer.nip),
            buildItem('NIK', widget.lecturer.nik),
            buildItem('Email', widget.lecturer.email),
            buildItem('Program Studi', widget.lecturer.prodi),
            const SizedBox(height: 20),
            const Divider(),
            const Text(
              'Penelitian Saya:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Research>>(
                future: _researchFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Gagal memuat data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Belum ada penelitian'));
                  }

                  return ListView(
                    children: snapshot.data!.map(buildResearchCard).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
