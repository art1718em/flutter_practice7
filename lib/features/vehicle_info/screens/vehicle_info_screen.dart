import 'package:flutter/material.dart';
import '../../car_expenses/state/car_expenses_container.dart';

class VehicleInfoScreen extends StatelessWidget {
  const VehicleInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Информация об автомобиле'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => const CarExpensesContainer()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Марка'),
              subtitle: Text('Skoda'),
            ),
            ListTile(
              leading: Icon(Icons.model_training),
              title: Text('Модель'),
              subtitle: Text('Octavia'),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Год выпуска'),
              subtitle: Text('2011'),
            ),
            ListTile(
              leading: Icon(Icons.pin),
              title: Text('VIN'),
              subtitle: Text('X224242Y2423Z'),
            ),
            ListTile(
              leading: Icon(Icons.local_gas_station),
              title: Text('Тип топлива'),
              subtitle: Text('Бензин'),
            ),
          ],
        ),
      ),
    );
  }
}
