import 'package:flutter/material.dart';
import 'infografis_detail_page.dart';

class InfografisPage extends StatelessWidget {
  InfografisPage({super.key});

  final List<String> infografisImages = [
    'assets/images/infografis.jfif',
    'assets/images/infografis1.webp',
    'assets/images/infografis2.jfif',
    'assets/images/infografis3.jfif',
    'assets/images/infografis4.jfif',
    'assets/images/cover.jfif',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Infografis', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: GridView.builder(
          itemCount: infografisImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3/4,
          ),
          itemBuilder: (context, idx) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfografisDetailPage(
                      imagePath: infografisImages[idx],
                      allImages: infografisImages,
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
                child: Image.asset(infografisImages[idx], fit: BoxFit.cover),
              ),
            );
          },
        ),
      ),
    );
  }
}
