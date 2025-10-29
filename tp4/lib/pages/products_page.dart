import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/car_api.dart';
import 'car_details_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final CarApiService _api = CarApiService();
  late Future<List<Car>> _futureCars;
  int _currentCarouselIndex = 0;

  @override
  void initState() {
    super.initState();
    // Use Auto.dev listings API
    _futureCars = _api.fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Car>>(
        future: _futureCars,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final cars = snapshot.data ?? [];
          if (cars.isEmpty) {
            return const Center(child: Text('No cars available'));
          }

          final carouselCars = cars.take(5).toList();
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        onPageChanged: (index, reason) {
                          setState(() => _currentCarouselIndex = index);
                        },
                      ),
                      items: carouselCars.map((car) {
                        return Builder(
                          builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CarDetailsPage(car: car),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    )
                                  ],
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    car.imageUrl.isNotEmpty
                                        ? Image.network(
                                            car.imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.directions_car, size: 64)),
                                          )
                                        : const Center(child: Icon(Icons.directions_car, size: 64)),
                                    Positioned(
                                      left: 12,
                                      bottom: 12,
                                      right: 12,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          '${car.make} ${car.model} - ${car.price}',
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(carouselCars.length, (index) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentCarouselIndex == index ? Colors.blueAccent : Colors.grey.shade400,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              SliverList.builder(
                itemBuilder: (context, index) => const SizedBox.shrink(),
                itemCount: 0,
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.82,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final car = cars[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => CarDetailsPage(car: car)),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: car.imageUrl.isNotEmpty
                                    ? Image.network(
                                        car.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.directions_car)),
                                      )
                                    : const Center(child: Icon(Icons.directions_car)),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
                                child: Text(
                                  '${car.year != null ? '${car.year} ' : ''}${car.make}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  car.model,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  car.price,
                                  style: const TextStyle(
                                    color: Color(0xFF2ECC71),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                                child: SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('You bought ${car.make} ${car.model}!')),
                                      );
                                    },
                                    icon: const Icon(Icons.attach_money),
                                    label: const Text('Buy Car'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2ECC71),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: cars.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


