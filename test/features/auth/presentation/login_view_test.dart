import 'package:flutter/material.dart';
import 'package:flutter_project/core/widgets/custom_textfiled.dart';
import 'package:flutter_project/features/auth/presentation/screens/login_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  testWidgets('LoginView renders correctly and can tap login button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(home: LoginView());
          },
        ),
      ),
    );

    // Verify that the main widgets are rendered
    expect(find.byType(CustomTextField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);

    // Enter text into the text fields
    await tester.enterText(find.byType(CustomTextField).at(0), '1234567890');
    await tester.enterText(find.byType(CustomTextField).at(1), 'password');

    // Tap the login button
    await tester.tap(find.text('Login'));
    await tester.pump();

    // The test will pass if no exceptions are thrown.
  });
}
