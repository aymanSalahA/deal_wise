import 'package:flutter/material.dart';
import '../../data/services/product_service.dart';

class DeleteButtonWithConfirmation extends StatelessWidget {
  final String productId;
  final VoidCallback? onDeleted;
  final double size;

  const DeleteButtonWithConfirmation({
    super.key,
    required this.productId,
    this.onDeleted,
    this.size = 24,
  });

  Future<void> _confirmAndDelete(BuildContext context) async {
    final theme = Theme.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      await ProductService().deleteProduct(productId);
      onDeleted?.call();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Item deleted')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete: $e'),
            backgroundColor: theme.colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      icon: Icon(Icons.delete_outline, color: theme.colorScheme.error, size: size),
      onPressed: () => _confirmAndDelete(context),
      tooltip: 'Delete',
    );
  }
}
