import 'dart:async';
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

class RecaptchaController {
  _RecaptchaWidgetState? _state;

  Future<String?> execute() async {
    if (_state != null) {
      return await _state!._execute();
    }
    return null;
  }
}

class RecaptchaWidget extends StatefulWidget {
  final RecaptchaController controller;

  const RecaptchaWidget({super.key, required this.controller});

  @override
  State<RecaptchaWidget> createState() => _RecaptchaWidgetState();
}

class _RecaptchaWidgetState extends State<RecaptchaWidget> {
  late String _viewId;
  StreamSubscription? _messageSubscription;
  Completer<String>? _completer;

  @override
  void initState() {
    super.initState();
    widget.controller._state = this;
    _viewId = 'recaptcha-web-${DateTime.now().millisecondsSinceEpoch}';
    
    // Register the iframe view factory
    ui_web.platformViewRegistry.registerViewFactory(
      _viewId,
      (int viewId) => html.IFrameElement()
        ..width = '100%'
        ..height = '100%'
        ..src = 'recaptcha.html'
        ..style.border = 'none'
        ..style.visibility = 'hidden', // Use visibility hidden instead of display none ensures it loads
    );

    // Listen for messages from the flutter_bootstrap.js or iframe
    _messageSubscription = html.window.onMessage.listen((event) {
      if (event.data is Map && event.data['recaptchaToken'] != null) {
        debugPrint('RecaptchaWidget: Received token from iframe');
        if (_completer != null && !_completer!.isCompleted) {
          _completer!.complete(event.data['recaptchaToken']);
        }
      }
    });
  }

  Future<String> _execute() async {
    debugPrint('RecaptchaWidget: Executing...');
    _completer = Completer<String>();
    
    final iframes = html.document.querySelectorAll('iframe');
    bool found = false;
    for (var iframe in iframes) {
      if (iframe is html.IFrameElement && iframe.src?.contains('recaptcha.html') == true) {
        debugPrint('RecaptchaWidget: Found iframe, sending execute message');
        iframe.contentWindow?.postMessage({'action': 'execute'}, '*');
        found = true;
      }
    }
    
    if (!found) {
      debugPrint('RecaptchaWidget: ReCAPTCHA iframe not found in DOM!');
    }

    return _completer!.future;
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Non-zero sized widget to ensure it stays in the DOM active
    return SizedBox(
      height: 1, 
      width: 1,
      child: HtmlElementView(viewType: _viewId),
    );
  }
}
