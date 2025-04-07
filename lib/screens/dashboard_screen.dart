import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dashboard_content.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          title: Text(
            _getScreenTitle(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg', // Make sure to add your logo image
                      height: 60,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'مكتب الشرق للمحاماه',
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              DrawerItem(
                icon: Icons.dashboard_outlined,
                title: 'لوحة التحكم',
                onTap: () => _handleNavigation(0),
              ),
              _buildExpandableSection(
                'إدارة العملاء والقضايا',
                [
                  DrawerItem(
                    icon: Icons.people_outline,
                    title: 'العملاء',
                    onTap: () => _handleNavigation(1),
                  ),
                  DrawerItem(
                    icon: Icons.gavel_outlined,
                    title: 'القضايا',
                    onTap: () => _handleNavigation(2),
                  ),
                ],
              ),
              _buildExpandableSection(
                'إدارة المهام والمستندات',
                [
                  DrawerItem(
                    icon: Icons.task_outlined,
                    title: 'المهام',
                    onTap: () => _handleNavigation(3),
                  ),
                  DrawerItem(
                    icon: Icons.description_outlined,
                    title: 'المستندات',
                    onTap: () => _handleNavigation(4),
                  ),
                ],
              ),
              _buildExpandableSection(
                'الإدارة المالية',
                [
                  DrawerItem(
                    icon: Icons.receipt_outlined,
                    title: 'الفواتير',
                    onTap: () => _handleNavigation(5),
                  ),
                  DrawerItem(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'المصروفات',
                    onTap: () => _handleNavigation(6),
                  ),
                ],
              ),
              _buildExpandableSection(
                'إدارة النظام',
                [
                  DrawerItem(
                    icon: Icons.people_outline,
                    title: 'المستخدمين',
                    onTap: () => _handleNavigation(7),
                  ),
                  DrawerItem(
                    icon: Icons.admin_panel_settings_outlined,
                    title: 'الأدوار',
                    onTap: () => _handleNavigation(8),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: _buildContent(),
      ),
    );
  }

  String _getScreenTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'لوحة التحكم';
      case 1:
        return 'العملاء';
      case 2:
        return 'القضايا';
      // ... add other cases for different screens
      default:
        return 'لوحة التحكم';
    }
  }

  Widget _buildExpandableSection(String title, List<DrawerItem> items) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
      ),
      children: items,
    );
  }

  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close drawer after selection
  }

  Widget _buildContent() {
    if (_selectedIndex == 0) {
      return const DashboardContent();
    }
    // Return other screens based on _selectedIndex
    return Center(
      child: Text('Content for index $_selectedIndex'),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final double horizontalPadding;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.horizontalPadding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(
        title,
        style: GoogleFonts.cairo(
          color: Colors.grey[800],
          fontSize: 14,
        ),
      ),
      onTap: onTap,
    );
  }
} 