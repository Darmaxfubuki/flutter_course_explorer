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
      title: 'Course Explorer - Tahap 1',
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
    studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text(
          'Tahap 1: Responsive Problem',
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            }

            final data = snapshot.data!;
            final student = data['student'] as Map<String, dynamic>;
            final courses = data['courses'] as List<dynamic>;

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
                  // ================= Bagian Profile Card =================
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
                            radius: 34,
                            backgroundImage:
                                AssetImage('assets/images/profile.jpeg'),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  studentName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'NIM: $studentId',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${student['prodi'] ?? 'Pendidikan Teknik Informatika'} • Semester ${student['semester'] ?? 5}',
                                  style: TextStyle(
                                    fontSize: 11,
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

                  // ================= TAHAP 1: DEMO NYATA OVERFLOW VS RESPONSIF =================
                  // 1. KASUS MASALAH: Container width 500 di dalam UnconstrainedBox
                  // Memaksa ukuran 500 px dan memicu visual "A RenderFlex overflowed" (kuning-hitam)
                  UnconstrainedBox(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 500,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber.shade800, width: 1.5),
                      ),
                      child: Text(
                        '[Width: 500 Hard-coded OVERFLOW] $studentId - $studentName',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.amber.shade900,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 2. KASUS SOLUSI: Menggunakan width: double.infinity
                  // Mengikuti batasan lebar layar (constraints parent) tanpa menyebabkan overflow
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade800, width: 1.5),
                    ),
                    child: Text(
                      '[Width: double.infinity Fleksibel Aman] $studentId - $studentName',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.green.shade900,
                      ),
                    ),
                  ),
                  // ===========================================================================

                  const SizedBox(height: 14),

                  // Bagian Summary Row
                  Row(
                    children: [
                      _buildSummaryCard(
                        title: 'Total Topik',
                        value: '$totalCourses Materi',
                        icon: Icons.menu_book,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      _buildSummaryCard(
                        title: 'Total Beban',
                        value: '$totalCredits SKS',
                        icon: Icons.credit_card,
                        color: Colors.purple,
                      ),
                      const SizedBox(width: 8),
                      _buildSummaryCard(
                        title: 'Selesai',
                        value: '$completedCourses Topik',
                        icon: Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    'Daftar Topik Pembelajaran',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // List Item Course
                  Expanded(
                    child: ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index] as Map<String, dynamic>;
                        return _buildCourseItemCard(course);
                      },
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

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required MaterialColor color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: color.shade800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseItemCard(Map<String, dynamic> course) {
    final String status = course['status'] as String? ?? 'planned';
    final String grade = course['grade'] as String? ?? '-';
    final bool isDone = status == 'done';
    final bool isActive = status == 'active';

    Color statusColor =
        isDone ? Colors.green : (isActive ? Colors.blue : Colors.orange);
    String statusLabel =
        isDone ? 'Selesai' : (isActive ? 'Berjalan' : 'Rencana');
    IconData statusIcon = isDone
        ? Icons.check_circle
        : (isActive ? Icons.play_circle_fill : Icons.schedule);

    return Card(
      elevation: 1.2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withAlpha(30),
          child: Icon(statusIcon, color: statusColor, size: 20),
        ),
        title: Text(
          course['title'] as String? ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            '${course['code']} • ${course['credits']} SKS • Nilai: $grade',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withAlpha(25),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: statusColor.withAlpha(128)),
          ),
          child: Text(
            statusLabel,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
        ),
      ),
    );
  }
}