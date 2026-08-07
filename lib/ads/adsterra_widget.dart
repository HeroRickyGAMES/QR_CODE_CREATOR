import 'package:flutter/material.dart';

import 'adsterra_config.dart';
import 'adsterra_impl_stub.dart'
    if (dart.library.html) 'adsterra_impl_web.dart';

/// Renderiza anúncio do Adsterra.
///
/// Usa import condicional para que o build nativo (Android) não
/// precise de `dart:html`.
class AdsterraWidget extends StatelessWidget {
  final ValueChanged<bool>? onFilled;
  final bool showPlaceholder;

  const AdsterraWidget({super.key, this.onFilled, this.showPlaceholder = true});

  @override
  Widget build(BuildContext context) {
    if (!AdsterraConfig.enabled) return const SizedBox.shrink();
    return AdsterraWebWidget(
      onFilled: onFilled,
      showPlaceholder: showPlaceholder,
    );
  }
}
