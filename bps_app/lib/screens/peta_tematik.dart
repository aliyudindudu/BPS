import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PetaTematikPage extends StatefulWidget {
  const PetaTematikPage({super.key});

  @override
  State<PetaTematikPage> createState() => _PetaTematikPageState();
}

class _PetaTematikPageState extends State<PetaTematikPage> {
  // Data statistik kecamatan, diisi manual
  final List<Map<String, dynamic>> kecamatanData = [
    {
      'kecamatan': 'Sumedang Utara',
      'laki_laki': 20000,
      'perempuan': 21000,
      'jumlah': 41000,
      'kepadatan': 1200,
      'usia_produktif': 65,
      'sumber': 'BPS 2024',
      'polygon': [
        [107.91, -6.83],
        [107.92, -6.83],
        [107.92, -6.82],
        [107.91, -6.82],
        [107.91, -6.83]
      ]
    },
    // Tambahkan kecamatan lain di sini
  ];

  bool loading = false;
  List<Map<String, dynamic>> polygons = [];

  @override
  void initState() {
    super.initState();
    _loadPolygons();
  }

  Future<void> _loadPolygons() async {
    setState(() => loading = true);
    polygons = kecamatanData.map((data) {
      return {
        'points': (data['polygon'] as List).map((e) => LatLng(e[1], e[0])).toList(),
        'properties': data,
      };
    }).toList();
    setState(() => loading = false);
  }

  void showStatPopup(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(data['kecamatan'] ?? ''),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Laki-laki: ${data['laki_laki']}'),
            Text('Perempuan: ${data['perempuan']}'),
            Text('Jumlah: ${data['jumlah']}'),
            Text('Kepadatan: ${data['kepadatan']}'),
            Text('Usia Produktif: ${data['usia_produktif']}%'),
            Text('Sumber: ${data['sumber']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  bool isPointInPolygon(LatLng point, List<LatLng> polygon) {
    int i, j = polygon.length - 1;
    bool oddNodes = false;
    for (i = 0; i < polygon.length; i++) {
      if ((polygon[i].latitude < point.latitude && polygon[j].latitude >= point.latitude ||
          polygon[j].latitude < point.latitude && polygon[i].latitude >= point.latitude) &&
          (polygon[i].longitude <= point.longitude || polygon[j].longitude <= point.longitude)) {
        if (polygon[i].longitude + (point.latitude - polygon[i].latitude) /
                (polygon[j].latitude - polygon[i].latitude) *
                (polygon[j].longitude - polygon[i].longitude) <
            point.longitude) {
          oddNodes = !oddNodes;
        }
      }
      j = i;
    }
    return oddNodes;
  }

  Color getColor(num kepadatan) {
    if (kepadatan >= 2000) return Colors.red;
    if (kepadatan >= 1000) return Colors.orange;
    if (kepadatan >= 500) return Colors.yellow;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        automaticallyImplyLeading: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Peta Tematik', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Kabupaten Sumedang', style: TextStyle(color: Colors.black54, fontSize: 13)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black, size: 32),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                center: LatLng(-6.8376, 107.9188),
                zoom: 12,
                interactiveFlags: InteractiveFlag.all,
                onTap: (tapPos, latlng) {
                  for (var poly in polygons) {
                    if (isPointInPolygon(latlng, List<LatLng>.from(poly['points']))) {
                      showStatPopup(poly['properties']);
                      break;
                    }
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.app',
                ),
                PolygonLayer(
                  polygons: polygons
                      .map((poly) => Polygon(
                            points: poly['points'],
                            color: getColor(poly['properties']['kepadatan']).withOpacity(0.6),
                            borderStrokeWidth: 2,
                            borderColor: Colors.black,
                            isFilled: true,
                            label: poly['properties']['kecamatan'],
                          ))
                      .toList(),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Lainnya',
          ),
        ],
      ),
    );
  }
}
