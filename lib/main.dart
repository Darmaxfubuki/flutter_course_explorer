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
      title: 'Tahap 11: Adaptive Navigation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
        ),
        useMaterial3: true,
      ),
      home: const AdaptiveMainShell(),
    );
  }
}

// ================= SHELL UTAMA DENGAN ADAPTIVE NAVIGATION =================
class AdaptiveMainShell extends StatefulWidget {
  const AdaptiveMainShell({super.key});

  @override
  State<AdaptiveMainShell> createState() => _AdaptiveMainShellState();
}

class _AdaptiveMainShellState extends State<AdaptiveMainShell> {
  int _selectedIndex = 0; // State index aktif tetap tersimpan saat resize/rotasi
  late Future<Map<String, dynamic>> _studentFuture;

  @override
  void initState() {
    super.initState();
    _studentFuture = loadStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _studentFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final data = snapshot.data!;
        final courses = data['courses'] as List<dynamic>;

        // Tiga halaman utama
        final List<Widget> pages = [
          HomeTab(courses: courses),
          CoursesTab(courses: courses),
          const ProfileTab(),
        ];

        // ================= IMPLEMENTASI TAHAP 11: LAYOUTBUILDER SHELL =================
        return LayoutBuilder(
          builder: (context, constraints) {
            final bool isCompactOrMedium = constraints.maxWidth < 840;

            // KONDISI 1: COMPACT & MEDIUM (< 840 px) -> Menggunakan NavigationBar di bawah
            if (isCompactOrMedium) {
              return Scaffold(
                backgroundColor: const Color(0xFFF5F7FB),
                appBar: AppBar(
                  title: Text(
                    'Tahap 11: Adaptive Nav (< 840px)',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
                body: SafeArea(child: pages[_selectedIndex]),
                bottomNavigationBar: NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.school_outlined),
                      selectedIcon: Icon(Icons.school),
                      label: 'Courses',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
              );
            }

            // KONDISI 2: EXPANDED (>= 840 px) -> Menggunakan NavigationRail di samping kiri
            return Scaffold(
              backgroundColor: const Color(0xFFF5F7FB),
              body: SafeArea(
                child: Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (index) {
                        setState(() => _selectedIndex = index);
                      },
                      labelType: NavigationRailLabelType.all,
                      leading: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage('assets/images/profile.jpeg'),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              studentId,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home_outlined),
                          selectedIcon: Icon(Icons.home),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.school_outlined),
                          selectedIcon: Icon(Icons.school),
                          label: Text('Courses'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.person_outline),
                          selectedIcon: Icon(Icons.person),
                          label: Text('Profile'),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            color: Colors.blue.shade700,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Tahap 11: Adaptive Nav (Expanded >= 840px)',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '$studentName ($studentId)',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: pages[_selectedIndex]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        // ==============================================================================
      },
    );
  }
}

// 1. KONTEN TAB HOME
class HomeTab extends StatelessWidget {
  final List<dynamic> courses;
  const HomeTab({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    final int totalCredits = courses.fold<int>(
      0,
      (sum, item) => sum + (item['credits'] as int? ?? 0),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/images/profile.jpeg'),
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
                        Text(
                          'NIM: $studentId',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'S1 Pendidikan Teknik Informatika • Semester 5',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.blue.shade800,
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
          const Text(
            'Ringkasan Perkuliahan',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Total Topik',
                  '${courses.length} Materi',
                  Icons.menu_book,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricCard(
                  'Total SKS',
                  '$totalCredits SKS',
                  Icons.credit_card,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
      String title, String val, IconData icon, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.shade100),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(
            val,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color.shade800,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// 2. KONTEN TAB COURSES
class CoursesTab extends StatelessWidget {
  final List<dynamic> courses;
  const CoursesTab({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daftar Topik Pembelajaran',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Katalog Kursus Mahasiswa: $studentName ($studentId)',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index] as Map<String, dynamic>;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.school, size: 20)),
                    title: Text(
                      course['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${course['code']} • ${course['credits']} SKS',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 3. KONTEN TAB PROFILE
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile.jpeg'),
                ),
                const SizedBox(height: 14),
                Text(
                  studentName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'NIM: $studentId',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Divider(height: 28),
                const Text('Program Studi: S1 Pendidikan Teknik Informatika'),
                const SizedBox(height: 4),
                const Text('Fakultas: Teknik dan Kejuruan'),
                const SizedBox(height: 4),
                const Text('Status: Mahasiswa Aktif'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}