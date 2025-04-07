import 'package:alsharq_law_office_app/models/hearing.dart';
import 'package:alsharq_law_office_app/models/task.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alsharq_law_office_app/screens/task_details_screen.dart';


class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  late List<Task> tasks;
  late List<Task> filteredTasks;
  late List<Hearing> hearings;
  late List<Hearing> filteredHearings;
  
  @override
  void initState() {
    super.initState();
    tasks = [
      Task(
        id: '1',
        title: 'إعداد طلب استئناف',
        dueDate: 'مارس 25, 2025',
        status: TaskStatus.inProgress,
        priority: TaskPriority.high,
        assignedTo: 'أحمد محمد',
      ),
      Task(
        id: '2',
        title: 'اجتماع تعريفي بالعميل',
        dueDate: 'مارس 25, 2025',
        status: TaskStatus.pending,
        priority: TaskPriority.medium,
        assignedTo: 'علي أحمد',
      ),
    ];
    filteredTasks = List.from(tasks);

    hearings = [
      Hearing(
        caseNumber: 'CAS-2025-8160',
        title: 'قضية مخالفة اقامة',
        client: 'محمد عبدالله خان',
        date: 'مارس 25, 2025',
        status: HearingStatus.scheduled,
        remainingDays: 5,
      ),
      // Add more hearings as needed
    ];
    filteredHearings = List.from(hearings);
  }

  void searchTasks(String query) {
    setState(() {
      filteredTasks = tasks.where((task) {
        return task.title.contains(query) ||
               task.assignedTo.contains(query) ||
               task.dueDate.contains(query) ||
               task.status.label.contains(query) ||
               task.priority.label.contains(query);
      }).toList();
    });
  }

  void searchHearings(String query) {
    setState(() {
      filteredHearings = hearings.where((hearing) {
        return hearing.title.contains(query) ||
               hearing.client.contains(query) ||
               hearing.caseNumber.contains(query) ||
               hearing.date.contains(query) ||
               hearing.status.label.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'المؤشرات الرئيسية',
              style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildStatsCards(context),
            const SizedBox(height: 24),
            _buildCharts(context),
            const SizedBox(height: 24),
            _buildLatestTasks(),
            const SizedBox(height: 24),
            _buildUpcomingHearings(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 1200 ? 3 : width > 800 ? 2 : 1;

    final List<Map<String, dynamic>> cards = [
      {
        'title': 'إجمالي العملاء',
        'value': '11',
        'subtitle': 'العملاء المسجلين',
        'icon': Icons.people_outlined,
        'color': Colors.orange,
      },
      {
        'title': 'العملاء المميزين',
        'value': '3',
        'subtitle': 'العملاء من الدرجة الاولى',
        'icon': Icons.star_outline,
        'color': Colors.amber,
      },
      {
        'title': 'القضايا النشطة',
        'value': '1',
        'subtitle': 'الامور القانونية الجارية',
        'icon': Icons.gavel_outlined,
        'color': Colors.green,
      },
      {
        'title': 'إجمالي المستندات',
        'value': '10',
        'subtitle': 'المستندات المخزنة',
        'icon': Icons.description_outlined,
        'color': Colors.grey,
      },
      {
        'title': 'المهام المتأخرة',
        'value': '6',
        'subtitle': 'المهام التي تجاوزت موعدها',
        'icon': Icons.access_time,
        'color': Colors.red,
      },
      {
        'title': 'المهام المعلقة',
        'value': '6',
        'subtitle': 'المهام المطلوب إنجازها',
        'icon': Icons.task_outlined,
        'color': Colors.red,
      },
      {
        'title': 'إجمالي المصروفات',
        'value': 'SAR 101,310.00',
        'subtitle': 'إجمالي المصروفات لهذا العام',
        'icon': Icons.trending_down,
        'color': Colors.red,
      },
      {
        'title': 'إجمالي الإيرادات',
        'value': 'SAR 628,624.50',
        'subtitle': 'الإيرادات المحصلة',
        'icon': Icons.attach_money,
        'color': Colors.green,
      },
      {
        'title': 'الفواتير المعلقة',
        'value': '0',
        'subtitle': 'الفواتير غير المدفوعة',
        'icon': Icons.receipt_long_outlined,
        'color': Colors.orange,
      },
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: width > 1200 ? 2.2 : width > 800 ? 2.7 : 2.6,
      children: cards.map((card) => _buildStatCard(
        title: card['title'],
        value: card['value'],
        subtitle: card['subtitle'],
        icon: card['icon'],
        color: card['color'],
      )).toList(),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
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
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  value,
                  style: GoogleFonts.cairo(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      subtitle,
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      icon,
                      color: color,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.3),
                    color.withOpacity(0.1),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharts(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    return width > 800
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildTasksChart()),
              const SizedBox(width: 16),
              Expanded(child: _buildCasesChart()),
            ],
          )
        : Column(
            children: [
              _buildTasksChart(),
              const SizedBox(height: 16),
              _buildCasesChart(),
            ],
          );
  }

  Widget _buildTasksChart() {
    final List<String> labels = [
      'متأخر',
      'اليوم',
      'غداً',
      'Wed 09/04',
      'Thu 10/04',
      'Fri 11/04',
      'Sat 12/04',
      'Sun 13/04',
    ];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'المهام القادمة',
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 16/9,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 6,
                  minY: 0,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 2,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: GoogleFonts.cairo(fontSize: 12),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 && value.toInt() < labels.length) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                labels[value.toInt()],
                                style: GoogleFonts.cairo(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 2,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey[300]!,
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      );
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 6,
                          color: Colors.redAccent,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    ...List.generate(7, (index) => BarChartGroupData(
                      x: index + 1,
                      barRods: [
                        BarChartRodData(
                          toY: 0,
                          color: Colors.redAccent,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCasesChart() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'القضايا حسب الحالة',
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 16/9,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 100,
                      color: Colors.blue,
                      title: 'Pending',
                      radius: 50,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestTasks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المهام الحديثة',
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            // Search Bar
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  textAlign: TextAlign.right,
                  style: GoogleFonts.cairo(),
                  decoration: InputDecoration(
                    hintText: 'بحث...',
                    hintStyle: GoogleFonts.cairo(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: searchTasks,
                ),
              ),
            ),
            // Page Size Selector
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: 10,
                  items: [10, 25, 50, 100].map((size) {
                    return DropdownMenuItem<int>(
                      value: size,
                      child: Text(
                        '$size لكل صفحة',
                        style: GoogleFonts.cairo(),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Implement page size change
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            horizontalMargin: 0,
            columnSpacing: 24,
            columns: [
              DataColumn(
                label: Text(
                  'عنوان المهمة',
                  style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'تاريخ الاستحقاق',
                  style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'الأولوية',
                  style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'معين إلى',
                  style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'حالة المهمة',
                  style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                ),
              ),
              const DataColumn(
                label: Text(''),
              ),
            ],
            rows: filteredTasks.map((task) => _buildTaskRow(task)).toList(),
          ),
        ),
      ],
    );
  }

  DataRow _buildTaskRow(Task task) {
    return DataRow(
      cells: [
        DataCell(Text(
          task.title,
          style: GoogleFonts.cairo(),
        )),
        DataCell(Text(
          task.dueDate,
          style: GoogleFonts.cairo(),
        )),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: task.priority.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              task.priority.label,
              style: GoogleFonts.cairo(
                color: task.priority.color,
                fontSize: 12,
              ),
            ),
          ),
        ),
        DataCell(Text(
          task.assignedTo,
          style: GoogleFonts.cairo(),
        )),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: task.status.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              task.status.label,
              style: GoogleFonts.cairo(
                color: task.status.color,
                fontSize: 12,
              ),
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.visibility_outlined),
                onPressed: () => _viewTask(task),
                tooltip: 'عرض',
              ),
              IconButton(
                icon: const Icon(Icons.check_circle_outline),
                onPressed: () => _markTaskComplete(task),
                tooltip: 'تحديد كمكتمل',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingHearings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الجلسات القادمة',
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            // Search Bar
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  textAlign: TextAlign.right,
                  style: GoogleFonts.cairo(),
                  decoration: InputDecoration(
                    hintText: 'بحث...',
                    hintStyle: GoogleFonts.cairo(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: searchHearings,
                ),
              ),
            ),
            // Page Size Selector
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: 10,
                  items: [10, 25, 50, 100].map((size) {
                    return DropdownMenuItem<int>(
                      value: size,
                      child: Text(
                        '$size لكل صفحة',
                        style: GoogleFonts.cairo(),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Implement page size change
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            horizontalMargin: 0,
            columnSpacing: 24,
            columns: [
              DataColumn(
                label: Text(
                  'رقم القضية',
                  style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'عنوان القضية',
                  style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'العميل',
                  style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'التاريخ',
                  style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'الحالة',
                  style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'الايام المتبقية',
                  style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                ),
              ),
              const DataColumn(
                label: Text(''),
              ),
            ],
            rows: filteredHearings.map((hearing) => _buildHearingRow(hearing)).toList(),
          ),
        ),
      ],
    );
  }

  DataRow _buildHearingRow(Hearing hearing) {
    return DataRow(
      cells: [
        DataCell(Text(
          hearing.caseNumber,
          style: GoogleFonts.cairo(),
        )),
        DataCell(Text(
          hearing.title,
          style: GoogleFonts.cairo(),
        )),
        DataCell(Text(
          hearing.client,
          style: GoogleFonts.cairo(),
        )),
        DataCell(Text(
          hearing.date,
          style: GoogleFonts.cairo(),
        )),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: hearing.status.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              hearing.status.label,
              style: GoogleFonts.cairo(
                color: hearing.status.color,
                fontSize: 12,
              ),
            ),
          ),
        ),
        DataCell(Text(
          '${hearing.remainingDays} يوم',
          style: GoogleFonts.cairo(),
        )),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.visibility_outlined),
                onPressed: () => _viewHearing(hearing),
                tooltip: 'عرض',
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _viewTask(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailsScreen(task: task),
      ),
    );
  }

  void _markTaskComplete(Task task) {
    setState(() {
      // Remove the task from both lists
      tasks.removeWhere((t) => t.id == task.id);
      filteredTasks.removeWhere((t) => t.id == task.id);
    });
    // Here you would typically also update the backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم اكتمال المهمة بنجاح',
          style: GoogleFonts.cairo(),
          textAlign: TextAlign.right,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _viewHearing(Hearing hearing) {
    // Implement hearing view functionality
  }
}

class WavyLinePainter extends CustomPainter {
  final Color color;

  WavyLinePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height);
    
    // Create a gentle wave effect
    for (var i = 0; i < size.width; i += 30) {
      path.quadraticBezierTo(
        i + 15,
        size.height - 2,
        i + 30,
        size.height,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
