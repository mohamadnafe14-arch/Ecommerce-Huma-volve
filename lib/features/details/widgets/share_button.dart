
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  final String productId;

  const ShareButton({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final productUrl =
        'https://white-shadow-b2ac.mohamadnafe14.workers.dev/products/$productId';

    return IconButton(
      onPressed: () async {
        await SharePlus.instance.share(
          ShareParams(
            text: 'شوف المنتج ده 👇\n$productUrl',
          ),
        );
      },
      icon: const Icon(Icons.share),
    );
  }
}
