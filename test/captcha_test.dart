import 'package:flutter_test/flutter_test.dart';
import 'package:insurance_flutter/utils/captcha.dart';

void main() {
  test('Captcha generates 6 characters', () {
    final captcha = CaptchaUtils.generateCaptcha();
    expect(captcha.length, 6);
  });

  test('Captcha contains valid characters', () {
    final captcha = CaptchaUtils.generateCaptcha();
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789';
    for (int i = 0; i < captcha.length; i++) {
      expect(chars.contains(captcha[i]), true);
    }
  });
}
