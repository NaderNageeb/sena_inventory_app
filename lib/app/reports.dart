import 'package:flutter/material.dart';
import 'package:sena_inventory/components/Drawer.dart';

import 'reports/donebill.dart';
import 'reports/expences_report.dart';
import 'reports/pending_bill.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Reports'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.monetization_on_sharp)),
            Tab(icon: Icon(Icons.check_circle)),
            Tab(icon: Icon(Icons.pending)),
            // Tab(icon: Icon(Icons.person), text: 'Profile'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ExpencesReports(),
          DoneBill(),
          PendingBill(),
          // Center(child: Text('Profile')),
        ],
      ),
    );
  }
}
