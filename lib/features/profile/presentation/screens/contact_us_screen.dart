import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _showDemoSnack(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
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
          'Contact Us',
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
              // const Text(
              //   'Get in Touch',
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 6),
              // const Text(
              //   "We're here to help. Reach out to us through any of the methods below.",
              //   style: TextStyle(color: Colors.black54),
              // ),
              const SizedBox(height: 10),

              // Contact method cards (dummy)
              _MethodCard(
                icon: Icons.mail_outline,
                title: 'Email Us',
                subtitle: "We'll reply within 24 hours",
                onTap: () => _showDemoSnack('Opening mail app (demo)'),
              ),
              const SizedBox(height: 8),
              _MethodCard(
                icon: Icons.phone_outlined,
                title: 'Call Us',
                subtitle: 'Mon–Fri, 9am – 5pm',
                onTap: () => _showDemoSnack('Starting a call (demo)'),
              ),

              const SizedBox(height: 20),
              const Text(
                'Send us a message',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Dummy form (no HTTP)
              _LabeledTextField(controller: _nameController, hint: 'Your Name'),
              const SizedBox(height: 10),
              _LabeledTextField(
                controller: _emailController,
                hint: 'Your Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              _LabeledTextField(
                controller: _subjectController,
                hint: 'Subject',
              ),
              const SizedBox(height: 10),
              _LabeledTextField(
                controller: _messageController,
                hint: 'How can we help?',
                maxLines: 5,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => _showDemoSnack(
                    'Message sent (demo). No network call made.',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF13A4EC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Send Message',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: TextButton.icon(
                  onPressed: () => _showDemoSnack('Open FAQs (demo)'),
                  icon: const Icon(Icons.help_outline),
                  label: const Text(
                    'Have a common question? Check out our FAQs',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MethodCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF13A4EC).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.mail_outline, color: Color(0xFF13A4EC)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;

  const _LabeledTextField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF13A4EC)),
        ),
      ),
    );
  }
}
