import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Color titleColor = Colors.black87;
    // ignore: unused_local_variable
    final Color textColor = Colors.black54;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF72C9F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          'Privacy & Policy',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Sections (accordions)
              _PolicyTile(
                title: 'Introduction',
                content:
                    'This section details the types of personal and usage data we collect to improve your shopping experience. This includes information you provide during registration, such as your name and email, and data collected automatically, like your browsing history and device information.',
              ),
              _PolicyTile(
                initiallyExpanded: true,
                title: 'Information We Collect',
                content:
                    'We collect information you provide directly to us, such as when you create an account, place an order, or contact customer support. This may include your name, email address, postal address, phone number, and payment information. We also collect information automatically as you navigate the app, including usage details, IP addresses, and information collected through cookies.',
              ),
              _PolicyTile(
                title: 'How We Use Your Information',
                content:
                    'Your information is used to fulfill your orders, process payments, communicate with you about your account, personalize your shopping experience, and improve our services. We may also use it for marketing purposes, with your consent where required.',
              ),
              _PolicyTile(
                title: 'Data Sharing & Disclosure',
                content:
                    'We do not sell your personal data. We may share information with third-party service providers for functions like payment processing and shipping. We may also disclose information if required by law.',
              ),
              _PolicyTile(
                title: 'Your Rights & Choices',
                content:
                    'You have the right to access, update, or delete your personal information. You can manage your preferences for marketing communications within your account settings.',
              ),
              _PolicyTile(
                title: 'Data Security',
                content:
                    'We implement a variety of security measures to maintain the safety of your personal information when you place an order or enter, submit, or access your personal information.',
              ),
              _PolicyTile(
                title: 'Contact Information',
                content:
                    'If you have any questions about this Privacy Policy, please contact us at support@ecommerce.app.',
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'I Understand & Agree',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PolicyTile extends StatelessWidget {
  final String title;
  final String content;
  final bool initiallyExpanded;

  const _PolicyTile({
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8.0),
        childrenPadding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        children: [
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
