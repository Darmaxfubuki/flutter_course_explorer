import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

const String studentName = 'I Ketut Darmawan Wirakusuma';
const String studentId = '2415051021';

void main() {
  runApp(const MyApp());
}

Future<Map<String, dynamic>> loadStudentData() async {
  final jsonString = await rootBundle.loadString(
    'assets/data/student_data.json',
  );
  return jsonDecode(jsonString) as Map<String, dynamic>;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tahap 4: Expanded, Flexible, & Wrap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
        ),
        useMaterial3: true,
      ),
      home: const Tahap4Page(),
    );
  }
}

class Tahap4Page extends StatefulWidget {
  const Tahap4Page({super.key});

  @override
  State<Tahap4Page> createState() => _Tahap4PageState();
}

class _Tahap4PageState extends State<Tahap4Page> {
  late Future<Map<String, dynamic>> studentFuture;

  // Daftar minimal 6 keahlian (Skills) sesuai instruksi modul
  final List<String> skills = [
    'Flutter',
    'Dart',
    'Responsive Design',
    'Git & GitHub',
    'REST API',
    'UI/UX Design',
    'State Management',
  ];

  @override
  void initState() {
    super.initState();
    studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text(
          'Tahap 4: Expanded & Wrap',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= Kartu Identitas =================
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 26,
                        backgroundImage:
                            AssetImage('assets/images/profile.jpeg'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              studentName,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'NIM: $studentId',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ================= BAGIAN 1: DEMO EXPANDED (FLEX 2:1) =================
              const Text(
                '1. Proporsi Panel Row (Expanded Flex 2 : 1)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // Panel A dengan Flex 2 (Mengambil 2/3 ruang)
                  Expanded(
                    flex: 2,
                    child: _buildBox(
                      label: 'Panel A (Flex: 2)',
                      description: 'Mendapat 66.6% ruang',
                      color: Colors.blue.shade100,
                      borderColor: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Panel B dengan Flex 1 (Mengambil 1/3 ruang)
                  Expanded(
                    flex: 1,
                    child: _buildBox(
                      label: 'Panel B (Flex: 1)',
                      description: 'Mendapat 33.3% ruang',
                      color: Colors.amber.shade100,
                      borderColor: Colors.amber.shade700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ================= BAGIAN 2: PERBANDINGAN WRAP VS ROW =================
              const Text(
                '2. Menggunakan Wrap (Responsif Multi-Baris)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Item chip otomatis turun ke baris berikutnya saat ruang horizontal habis:',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Wrap(
                  spacing: 8.0, // Jarak horizontal antar chip
                  runSpacing: 8.0, // Jarak vertikal antar baris chip
                  children: skills
                      .map(
                        (e) => Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.green.shade700,
                            child: const Icon(Icons.check,
                                size: 14, color: Colors.white),
                          ),
                          label: Text(e),
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.green.shade200),
                        ),
                      )
                      .toList(),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                '3. Perbandingan: Menggunakan Row Biasa',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Row biasa memaksa seluruh item dalam satu baris horizontal:',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: skills
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Chip(
                              label: Text(e),
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.red.shade200),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBox({
    required String label,
    required String description,
    required Color color,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: borderColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade800),
          ),
        ],
      ),
    );
  }
}