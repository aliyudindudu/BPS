import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show rootBundle, ByteData;
import 'dart:typed_data';

class TabelStatistikDetailPage extends StatefulWidget {
  final String title;
  final String date;
  final String category;
  final String fileAssetPath;

  const TabelStatistikDetailPage({
    super.key,
    required this.title,
    required this.date,
    required this.category,
    required this.fileAssetPath,
  });

  @override
  State<TabelStatistikDetailPage> createState() => _TabelStatistikDetailPageState();
}

class _TabelStatistikDetailPageState extends State<TabelStatistikDetailPage> {
  List<List<Data?>> _tableData = [];

  @override
  void initState() {
    super.initState();
    _loadExcelData();
  }

  Future<void> _loadExcelData() async {
    try {
      debugPrint('Membaca file asset: \\${widget.fileAssetPath}');
      final ByteData data = await rootBundle.load(widget.fileAssetPath);
      final Excel excel = Excel.decodeBytes(data.buffer.asUint8List());

      if (excel.tables.isEmpty) {
        debugPrint('Tidak ada sheet di file Excel');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File Excel tidak memiliki sheet')),
        );
        return;
      }

      final Sheet? sheet = excel.tables[excel.tables.keys.first];
      if (sheet == null || sheet.rows.isEmpty) {
        debugPrint('Sheet kosong');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sheet pada file Excel kosong')),
        );
        return;
      }
      setState(() {
        _tableData = sheet.rows;
      });
    } catch (e) {
      debugPrint('Error loading Excel file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membaca file Excel: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Detail Statistik', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.date, style: const TextStyle(fontSize: 15, color: Colors.grey)),
            const SizedBox(height: 8),
            Text(widget.category, style: const TextStyle(fontSize: 15, color: Colors.blue)),
            const SizedBox(height: 24),
            const Text('Data Tabel:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Expanded(
              child: _tableData.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: _buildColumns(),
                        rows: _buildRows(),
                        headingRowColor: MaterialStateProperty.all(Colors.blue.shade100),
                        dataRowColor: MaterialStateProperty.all(Colors.white),
                        border: TableBorder.all(width: 0.5, color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    if (_tableData.isEmpty) return [];
    // Kolom diambil dari baris kedua (index 1) jika ada, agar header lebih informatif
    final headerRow = _tableData.length > 1 ? _tableData[1] : _tableData.first;
    return headerRow.map((cell) {
      return DataColumn(
        label: Center(
          child: Text(
            cell?.value.toString() ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
          ),
        ),
      );
    }).toList();
  }

  List<DataRow> _buildRows() {
    if (_tableData.length <= 2) return [];
    // Baris pertama dan kedua dianggap header, data mulai dari index 2
    return List.generate(_tableData.length, (rowIdx) {
      final row = _tableData[rowIdx];
      // Header baris 0 dan 1
      if (rowIdx == 0 || rowIdx == 1) {
        return DataRow(
          color: MaterialStateProperty.all(Colors.blue.shade100),
          cells: row.map((cell) {
            return DataCell(
              Center(
                child: Text(
                  cell?.value.toString() ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                ),
              ),
            );
          }).toList(),
        );
      }
      // Data
      return DataRow(
        cells: row.map((cell) {
          return DataCell(
            Center(
              child: Text(
                cell?.value.toString() ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          );
        }).toList(),
      );
    }).skip(2).toList();
  }
}
