import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

class InfografisDetailPage extends StatelessWidget {
  final String imagePath;
  final List<String> allImages;
  const InfografisDetailPage({super.key, required this.imagePath, required this.allImages});

  Future<void> _downloadImage(BuildContext context) async {
    try {
      final byteData = await rootBundle.load(imagePath);
      final bytes = byteData.buffer.asUint8List();
      final fileName = p.basename(imagePath);
      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory('/storage/emulated/0/Download');
      } else {
        downloadsDir = Directory.systemTemp;
      }
      final file = File(p.join(downloadsDir.path, fileName));
      await file.writeAsBytes(bytes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gambar berhasil diunduh ke folder Download!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengunduh gambar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: const SizedBox(),
        title: const Text('Detail Infografis', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black, size: 32),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: Image.asset(imagePath, fit: BoxFit.contain),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                      ),
                      onPressed: () => _downloadImage(context),
                      child: const Text('Unduh', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Lainnya', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: allImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, idx) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfografisDetailPage(
                            imagePath: allImages[idx],
                            allImages: allImages,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Image.asset(allImages[idx], fit: BoxFit.cover),
                    ),
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
