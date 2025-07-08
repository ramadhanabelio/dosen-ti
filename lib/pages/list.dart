import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../models/lecturer.dart';
import '../services/api.dart';
import '../components/fab.dart';
import 'detail.dart';

class ListPage extends StatefulWidget {
  final String prodi;

  const ListPage({super.key, required this.prodi});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<Lecturer>> _lecturers;

  @override
  void initState() {
    super.initState();
    _lecturers = ApiService.getLecturersByProdi(widget.prodi);
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
                    widget.prodi,
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
      body: FutureBuilder<List<Lecturer>>(
        future: _lecturers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final dosenList = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dosenList.length,
              itemBuilder: (context, index) {
                final dosen = dosenList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(dosen: dosen),
                      ),
                    );
                  },
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
                            opacity: 0.3,
                            child: Image.asset(
                              'images/white.png',
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
                              dosen.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'NIP. ${dosen.nip ?? "-"}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Gagal memuat dosen'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: const FAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
