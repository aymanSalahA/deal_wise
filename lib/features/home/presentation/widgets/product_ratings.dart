import 'package:flutter/material.dart';

class ProductRatingData {
  final double rating;
  final int reviewsCount;
  final Map<int, double> ratingDistribution;

  ProductRatingData({
    required this.rating,
    required this.reviewsCount,
    required this.ratingDistribution,
  });
}

class ProductRatings extends StatelessWidget {
  final double rating;
  final int reviewsCount;
  final Map<int, double> ratingDistribution;

  const ProductRatings({
    super.key,
    required this.rating,
    required this.reviewsCount,
    required this.ratingDistribution,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ratings & Reviews',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View All',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rating.toStringAsFixed(1),
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'out of 5',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '$reviewsCount reviews',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: ratingDistribution.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          Text(
                            '${entry.key}★',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: entry.value,
                              backgroundColor: theme.colorScheme.onSurface.withOpacity(0.12),
                              color: theme.colorScheme.secondary,
                              minHeight: 8,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// الصفحة الرئيسية
class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  // محاكاة جلب البيانات من API
  Future<ProductRatingData> fetchRatingData() async {
    await Future.delayed(const Duration(seconds: 2)); // محاكاة وقت التحميل
    return ProductRatingData(
      rating: 4.3,
      reviewsCount: 120,
      ratingDistribution: {5: 0.6, 4: 0.25, 3: 0.1, 2: 0.03, 1: 0.02},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Page')),
      body: FutureBuilder<ProductRatingData>(
        future: fetchRatingData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          final data = snapshot.data!;
          return ProductRatings(
            rating: data.rating,
            reviewsCount: data.reviewsCount,
            ratingDistribution: data.ratingDistribution,
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: ProductPage()));
}
