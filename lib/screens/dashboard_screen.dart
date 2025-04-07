import 'package:flutter/material.dart';

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
          title: const Text(
            'لوحة التحكم',
            style: TextStyle(color: Colors.black),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    'لوحة التحكم',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              _buildExpandableSection(
                'إدارة العملاء والقضايا',
                [
                  DrawerItem(
                    icon: Icons.people_outline,
                    title: 'العملاء',
                    onTap: () => _handleNavigation(0),
                  ),
                  DrawerItem(
                    icon: Icons.gavel_outlined,
                    title: 'القضايا',
                    onTap: () => _handleNavigation(1),
                  ),
                ],
              ),
              _buildExpandableSection(
                'إدارة المهام والمستندات',
                [
                  DrawerItem(
                    icon: Icons.task_outlined,
                    title: 'المهام',
                    onTap: () => _handleNavigation(2),
                  ),
                  DrawerItem(
                    icon: Icons.description_outlined,
                    title: 'المستندات',
                    onTap: () => _handleNavigation(3),
                  ),
                ],
              ),
              _buildExpandableSection(
                'الإدارة المالية',
                [
                  DrawerItem(
                    icon: Icons.receipt_outlined,
                    title: 'الفواتير',
                    onTap: () => _handleNavigation(4),
                  ),
                  DrawerItem(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'المصروفات',
                    onTap: () => _handleNavigation(5),
                  ),
                ],
              ),
              _buildExpandableSection(
                'إدارة النظام',
                [
                  DrawerItem(
                    icon: Icons.people_outline,
                    title: 'المستخدمين',
                    onTap: () => _handleNavigation(6),
                  ),
                  DrawerItem(
                    icon: Icons.admin_panel_settings_outlined,
                    title: 'الأدوار',
                    onTap: () => _handleNavigation(7),
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
    // Placeholder content - replace with actual screens
    final List<String> titles = [
      'العملاء',
      'القضايا',
      'المهام',
      'المستندات',
      'الفواتير',
      'المصروفات',
      'المستخدمين',
      'الأدوار',
    ];
    
    return Center(
      child: Text(titles[_selectedIndex]),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 14,
        ),
      ),
      onTap: onTap,
    );
  }
} 