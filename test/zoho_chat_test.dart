import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zoho_chat/zoho_chat.dart';

void main() {
  const MethodChannel channel = MethodChannel('zoho_chat');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    //expect(await ZohoChat.platformVersion, '42');
  });
}
