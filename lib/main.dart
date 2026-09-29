import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

// Function asynchronous untuk memuat data JSON statik
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
      title: 'Learning Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
        ),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<Map<String, dynamic>> studentFuture;

  @override
  void initState() {
    super.initState();
    // Inisialisasi future tepat satu kali di initState()
    studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text(
          'Learning Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: studentFuture,
          builder: (context, snapshot) {
            // 1. Kondisi Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // 2. Kondisi Error
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Gagal memuat data:\n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            }

            // 3. Kondisi Data Sukses
            final data = snapshot.data!;
            final student = data['student'] as Map<String, dynamic>;
            final courses = data['courses'] as List<dynamic>;

            // Kalkulasi ringkasan data (Summary)
            final int totalCourses = courses.length;
            final int totalCredits = courses.fold<int>(
              0,
              (sum, item) => sum + (item['credits'] as int? ?? 0),
            );
            final int completedCourses =
                courses.where((item) => item['status'] == 'done').length;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= Bagian 1: Identity & Profile Card =================
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 36,
                            backgroundImage:
                                AssetImage('assets/images/profile.jpeg'),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student['name'] as String? ?? 'I Ketut Darmawan Wirakusuma',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'NIM: ${student['nim'] ?? '2415051021'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Menampilkan Prodi dan Semester 5 tanpa error null
                                Text(
                                  '${student['prodi'] ?? 'Pendidikan Teknik Informatika'} • Semester ${student['semester'] ?? 5}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ================= Bagian 2: Summary Row (3 Cards) =================
                  Row(
                    children: [
                      _buildSummaryCard(
                        title: 'Total Topik',
                        value: '$totalCourses Materi',
                        icon: Icons.menu_book,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 10),
                      _buildSummaryCard(
                        title: 'Total Beban',
                        value: '$totalCredits SKS',
                        icon: Icons.credit_card,
                        color: Colors.purple,
                      ),
                      const SizedBox(width: 10),
                      _buildSummaryCard(
                        title: 'Selesai',
                        value: '$completedCourses Topik',
                        icon: Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Header List
                  const Text(
                    'Daftar Topik Pembelajaran',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ================= Bagian 3: ListView.builder (Scrollable) =================
                  Expanded(
                    child: ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index] as Map<String, dynamic>;
                        return _buildCourseItemCard(course);
                      },
                    ),
                  ),

                  const SizedBox(height: 6),
                  Center(
                    child: Text(
                      'Data list dimuat secara real-time dari JSON statik',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // REUSABLE FUNCTION 1: Kartu Ringkasan
  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required MaterialColor color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: color.shade800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // REUSABLE FUNCTION 2: Item List Card dengan Conditional UI
  Widget _buildCourseItemCard(Map<String, dynamic> course) {
    final String status = course['status'] as String? ?? 'planned';
    final String grade = course['grade'] as String? ?? '-';
    final bool isDone = status == 'done';
    final bool isActive = status == 'active';

    Color statusColor;
    String statusLabel;
    IconData statusIcon;

    if (isDone) {
      statusColor = Colors.green;
      statusLabel = 'Selesai';
      statusIcon = Icons.check_circle;
    } else if (isActive) {
      statusColor = Colors.blue;
      statusLabel = 'Berjalan';
      statusIcon = Icons.play_circle_fill;
    } else {
      statusColor = Colors.orange;
      statusLabel = 'Rencana';
      statusIcon = Icons.schedule;
    }

    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withAlpha(30),
          child: Icon(statusIcon, color: statusColor),
        ),
        title: Text(
          course['title'] as String? ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            '${course['code']} • ${course['credits']} SKS • Nilai: $grade',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withAlpha(25),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: statusColor.withAlpha(128)),
          ),
          child: Text(
            statusLabel,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ),
      ),
    );
  }
}