import 'package:flutter_test/flutter_test.dart';
import 'package:appbaru/main.dart';

void main() {
  testWidgets('Aplikasi merender LoginScreen dengan benar', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verifikasi bahwa teks judul LoginScreen muncul
    expect(find.text('Selamat Datang! 👋'), findsOneWidget);
    expect(find.text('Masuk Sekarang'), findsOneWidget);
  });
}
