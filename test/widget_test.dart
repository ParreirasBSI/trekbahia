import 'package:flutter_test/flutter_test.dart';
import 'package:trekbahia/main.dart';

void main() {
  testWidgets('Lista de trilhas aparece na tela inicial', (tester) async {
    await tester.pumpWidget(const TrekBahia());
    await tester.pumpAndSettle();

    expect(find.text('TrekBahia'), findsOneWidget);
    expect(find.text('Cachoeira da Fumaça'), findsOneWidget);
  });
}
