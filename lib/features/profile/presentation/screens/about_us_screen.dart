import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Crafting Quality, Delivering Happiness',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Our Mission',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Text(
                'To empower creators and entrepreneurs by providing high-quality, sustainable products that bring their ideas to life. We believe in building a community driven by innovation, creativity, and unparalleled customer service.',
                style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.6),
              ),
              const SizedBox(height: 20),
              const Text(
                'Our Values',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              const _ValueItem(
                icon: Icons.verified_outlined,
                title: 'Quality First',
                description:
                    'We are committed to the highest standards in every product we craft and every service we provide.',
              ),
              const SizedBox(height: 12),
              const _ValueItem(
                icon: Icons.eco_outlined,
                title: 'Sustainability',
                description:
                    'We embrace eco-friendly practices to protect our planet for future generations.',
              ),
              const SizedBox(height: 12),
              const _ValueItem(
                icon: Icons.groups_outlined,
                title: 'Customer Centric',
                description:
                    'Our customers are at the heart of everything we do. Your success is our success.',
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF13A4EC),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text(
              'Back to Profile',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class _ValueItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ValueItem({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF13A4EC).withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.check, color: Color(0xFF13A4EC)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(description, style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.6)),
            ],
          ),
        )
      ],
    );
  }
}


