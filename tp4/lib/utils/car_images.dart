class CarImages {
  static const String _generic = 'https://images.unsplash.com/photo-1549923746-c502d488b3ea?w=800&q=80&auto=format&fit=crop';

  static final Map<String, String> modelToImage = {
    'camry': 'https://images.unsplash.com/photo-1619767886558-efdc259cde1b?w=800&q=80&auto=format&fit=crop',
    'corolla': 'https://images.unsplash.com/photo-1559400066-9d8163b7a8a6?w=800&q=80&auto=format&fit=crop',
    'rav4': 'https://images.unsplash.com/photo-1602714896641-13b9813b3546?w=800&q=80&auto=format&fit=crop',
    'prius': 'https://images.unsplash.com/photo-1626489314078-bd1b2c718376?w=800&q=80&auto=format&fit=crop',
    'highlander': 'https://images.unsplash.com/photo-1622289225315-38d73b50fbe8?w=800&q=80&auto=format&fit=crop',
  };

  static String forModel(String model) {
    final key = model.toLowerCase();
    return modelToImage[key] ?? _generic;
  }
}


