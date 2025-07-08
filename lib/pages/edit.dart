import 'package:flutter/material.dart';
import '../models/research.dart';
import '../services/api.dart';
import '../constants/theme.dart';

class EditPage extends StatefulWidget {
  final String token;
  final Research research;

  const EditPage({super.key, required this.token, required this.research});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController titleController;
  late TextEditingController yearController;
  late TextEditingController fieldController;
  late TextEditingController abstractController;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.research.title);
    yearController = TextEditingController(
      text: widget.research.year.toString(),
    );
    fieldController = TextEditingController(text: widget.research.field ?? '');
    abstractController = TextEditingController(
      text: widget.research.abstract ?? '',
    );
  }

  Future<void> handleUpdate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await ApiService.updateResearch(widget.token, widget.research.id, {
        'title': titleController.text,
        'year': int.parse(yearController.text),
        'field': fieldController.text,
        'abstract': abstractController.text,
      });

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mengedit: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
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
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
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
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppGradients.greenGradient,
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(
                    'Edit Penelitian',
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildField('Judul', titleController),
              buildField(
                'Tahun',
                yearController,
                keyboardType: TextInputType.number,
              ),
              buildField('Bidang', fieldController),
              buildField('Abstrak', abstractController, maxLines: 3),
              ElevatedButton(
                onPressed: isLoading ? null : handleUpdate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:
                    isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                          'Simpan Perubahan',
                          style: TextStyle(color: Colors.white),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
