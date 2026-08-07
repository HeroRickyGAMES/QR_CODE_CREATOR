import 'package:flutter/material.dart';

/// Stub para plataformas sem suporte (não-web).
///
/// O QR Code Generator tem suporte apenas a Android e Web: no Android os
/// anúncios vêm do AdMob (mobileAds.dart) e na Web do Adsterra (impl web).
/// Este stub só existe para o build nativo não precisar de `dart:html`.
class AdsterraWebWidget extends StatefulWidget {
  final ValueChanged<bool>? onFilled;
  final bool showPlaceholder;

  const AdsterraWebWidget({super.key, this.onFilled, this.showPlaceholder = true});

  @override
  State<AdsterraWebWidget> createState() => _AdsterraWebWidgetStubState();
}

class _AdsterraWebWidgetStubState extends State<AdsterraWebWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onFilled?.call(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 60);
  }
}
