import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.appBarTheme.iconTheme?.color ?? theme.iconTheme.color,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        title: Text(
          'Privacy & Policy',
          style: theme.appBarTheme.titleTextStyle,
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
              backgroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'I Understand & Agree',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
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
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8.0),
        childrenPadding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
        title: Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Text(
            content,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
