import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models/service_record_model.dart';

class ServiceHistoryScreen extends StatefulWidget {
  const ServiceHistoryScreen({super.key});

  @override
  State<ServiceHistoryScreen> createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends State<ServiceHistoryScreen> {
  final List<ServiceRecordModel> _serviceRecords = [];

  void _addServiceRecord(String title, double cost) {
    final newRecord = ServiceRecordModel(
      title: title,
      cost: cost,
      date: DateTime.now(),
    );
    setState(() {
      _serviceRecords.add(newRecord);
    });
  }

  void _navigateToAddScreen() async {
    final result = await context.push<Map<String, dynamic>?>('/history/add');
    if (result != null && result.containsKey('title') && result.containsKey('cost')) {
      _addServiceRecord(result['title'] as String, result['cost'] as double);
    }
  }

  void _navigateToMain() {
    context.pushReplacement('/expenses');
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _serviceRecords.length,
      itemBuilder: (context, index) {
        final record = _serviceRecords[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.build),
            title: Text(record.title),
            subtitle: Text(DateFormat('dd.MM.yyyy').format(record.date)),
            trailing: Text(
              '${record.cost.toStringAsFixed(2)} руб.',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );

    if (_serviceRecords.isEmpty) {
      mainContent = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: "https://cdn-icons-png.flaticon.com/512/2621/2621723.png",
              width: 100,
              height: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'Записей об обслуживании пока нет',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('История обслуживания'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: _navigateToMain,
        ),
      ),
      body: mainContent,
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
