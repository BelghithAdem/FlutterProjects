import 'package:flutter/material.dart';
import '../models/car.dart';

class CarDetailsPage extends StatelessWidget {
  final Car car;
  const CarDetailsPage({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${car.make} ${car.model}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: car.imageUrl.isNotEmpty
                    ? Image.network(
                        car.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.directions_car, size: 64)),
                      )
                    : const Center(child: Icon(Icons.directions_car, size: 64)),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${car.make} ${car.model}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              car.price,
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              car.description.isNotEmpty ? car.description : 'No description available.',
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Purchased ${car.make} ${car.model}!')),
                  );
                },
                child: const Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


