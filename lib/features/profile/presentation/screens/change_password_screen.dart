import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  String _strengthLabel(double score) {
    if (score >= 0.8) return 'Strong';
    if (score >= 0.5) return 'Medium';
    return 'Weak';
  }

  Color _strengthColor(BuildContext context, double score) {
    final theme = Theme.of(context);
    if (score >= 0.8) return theme.colorScheme.primary;
    if (score >= 0.5) return theme.colorScheme.secondary;
    return theme.colorScheme.error;
  }

  double _passwordStrength(String value) {
    double score = 0;
    if (value.length >= 8) score += 0.25;
    if (RegExp(r"[A-Z]").hasMatch(value)) score += 0.25;
    if (RegExp(r"[0-9]").hasMatch(value)) score += 0.25;
    if (RegExp(r"[^A-Za-z0-9]").hasMatch(value)) score += 0.25;
    return score;
  }

  void _updatePasswordDemo() {
    final newPass = _newController.text;
    final confirm = _confirmController.text;
    if (newPass.isEmpty || confirm.isEmpty || _currentController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }
    if (newPass != confirm) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password updated (demo). No network call made.'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double strength = _passwordStrength(_newController.text);
    final Color barColor = _strengthColor(context, strength);
    final String label = _strengthLabel(strength);

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
          'Change Password',
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
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Create a new, strong password to keep your account secure.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),

              _PasswordField(
                label: 'Current Password',
                controller: _currentController,
                obscure: !_showCurrent,
                onToggle: () => setState(() => _showCurrent = !_showCurrent),
              ),
              const SizedBox(height: 12),

              _PasswordField(
                label: 'New Password',
                controller: _newController,
                obscure: !_showNew,
                onChanged: (_) => setState(() {}),
                onToggle: () => setState(() => _showNew = !_showNew),
              ),
              const SizedBox(height: 12),

              _PasswordField(
                label: 'Confirm New Password',
                controller: _confirmController,
                obscure: !_showConfirm,
                onToggle: () => setState(() => _showConfirm = !_showConfirm),
              ),
              const SizedBox(height: 16),

              // Strength bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: barColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: strength.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Requirements
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: const [
                  _RequirementChip(text: '8+ characters', met: true),
                  _RequirementChip(text: '1 uppercase letter', met: true),
                  _RequirementChip(text: '1 number', met: true),
                  _RequirementChip(text: '1 special character', met: false),
                ],
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: _updatePasswordDemo,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Update Password',
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

class _PasswordField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;
  final ValueChanged<String>? onChanged;

  const _PasswordField({
    required this.label,
    required this.controller,
    required this.obscure,
    required this.onToggle,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextField(
              controller: controller,
              obscureText: obscure,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: label,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: theme.iconTheme.color,
                ),
                // rely on theme's InputDecorationTheme for fill/borders
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.inputDecorationTheme.border?.borderSide.color ?? Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.inputDecorationTheme.enabledBorder?.borderSide.color ?? Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
              ),
            ),
            IconButton(
              onPressed: onToggle,
              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
                color: theme.iconTheme.color?.withOpacity(0.45) ??
                    theme.colorScheme.onSurface.withOpacity(0.45),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RequirementChip extends StatelessWidget {
  final String text;
  final bool met;

  const _RequirementChip({required this.text, required this.met});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: met
            ? theme.colorScheme.primary.withOpacity(0.12)
            : theme.colorScheme.error.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: (met ? theme.colorScheme.primary : theme.colorScheme.error)
              .withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            met ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: met ? theme.colorScheme.primary : theme.colorScheme.error,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
