class Car {
  final String id; // VIN or listing ID
  final String model;
  final String make;
  final String price; // May be unavailable in VIN decode; keep as string
  final String imageUrl; // May be empty when not provided
  final String description;
  final int? year;

  Car({
    required this.id,
    required this.model,
    required this.make,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.year,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    // Handle Auto.dev listings shape (records[])
    final String primaryPhoto = (json['primaryPhotoUrl'] ?? json['thumbnailUrlLarge'] ?? json['thumbnailUrl'] ?? '').toString();
    String firstImage = primaryPhoto;
    if (firstImage.isEmpty && json['photoUrls'] is List && (json['photoUrls'] as List).isNotEmpty) {
      final first = (json['photoUrls'] as List).first;
      if (first is String) firstImage = first;
    }

    final String vinOrId = (json['vin'] ?? json['id'] ?? '').toString();
    final String yearStr = (json['year'] ?? '').toString();
    final String mileage = (json['mileageHumanized'] ?? json['mileage'] ?? '').toString();
    final String city = (json['city'] ?? '').toString();

    return Car(
      id: vinOrId,
      model: (json['model'] ?? 'Unknown Model').toString(),
      make: (json['make'] ?? '').toString(),
      price: (json['price'] ?? 'N/A').toString(),
      imageUrl: firstImage,
      description: [
        if (yearStr.isNotEmpty) yearStr,
        if (mileage.isNotEmpty) mileage,
        if (city.isNotEmpty) city,
      ].join(' • '),
      year: int.tryParse(yearStr),
    );
  }
}


