import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

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
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 && value.toInt() < labels.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                labels[value.toInt()],
                                style: GoogleFonts.cairo(fontSize: 12),
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
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 6,
                        color: Colors.redAccent,
                        width: 20,
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
                        width: 20,
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
