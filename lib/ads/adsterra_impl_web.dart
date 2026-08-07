import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

import 'adsterra_config.dart';

/// Web: container div gerenciado por HtmlElementView + script injetado
/// diretamente no DOM da página (sem iframe).
///
/// Um script de polling aguarda o container ficar pronto antes de carregar
/// o invoke.js do Adsterra, resolvendo o timing entre Flutter e DOM.
class AdsterraWebWidget extends StatefulWidget {
  final ValueChanged<bool>? onFilled;
  final bool showPlaceholder;

  const AdsterraWebWidget({super.key, this.onFilled, this.showPlaceholder = true});

  @override
  State<AdsterraWebWidget> createState() => _AdsterraWebWidgetState();
}

class _AdsterraWebWidgetState extends State<AdsterraWebWidget> {
  @override
  void initState() {
    super.initState();
    _registerViewFactory();
    _injectScript();
    _detectFill();
  }

  Future<void> _detectFill() async {
    if (widget.onFilled == null) return;
    for (var i = 0; i < 8; i++) {
      await Future.delayed(const Duration(milliseconds: 750));
      try {
        final el = html.document
            .getElementById(AdsterraConfig.nativeBannerContainerId);
        if (el != null && el.children.isNotEmpty) {
          widget.onFilled!(true);
          return;
        }
      } catch (_) {}
    }
    widget.onFilled!(false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: HtmlElementView(viewType: _viewType),
    );
  }
}

final _viewType = 'adsterra-native';

void _registerViewFactory() {
  try {
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      return html.DivElement()
        ..id = AdsterraConfig.nativeBannerContainerId
        ..style.width = '100%'
        ..style.height = '100%';
    });
  } catch (_) {}
}

void _injectScript() {
  if (html.document.querySelector('script[data-adsterra="native"]') != null) {
    return;
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final inlineScript = html.ScriptElement()
      ..setAttribute('data-adsterra', 'native')
      ..text = '''
(function(){
  var id = "${AdsterraConfig.nativeBannerContainerId}";
  var src = "${AdsterraConfig.nativeBannerScript}";
  var check = function(){
    var el = document.getElementById(id);
    if(el){
      var s = document.createElement("script");
      s.src = src;
      s.async = true;
      s.setAttribute("data-cfasync","false");
      document.body.appendChild(s);
    } else {
      setTimeout(check,100);
    }
  };
  check();
})();
''';
    html.document.body?.append(inlineScript);
  });
}
