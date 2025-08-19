import 'package:flutter/material.dart';
import 'package:naked/core/theme/app_colors.dart';
import 'package:naked/features/home/view/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naked',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.backgroundDark,
          onSurface: AppColors.backgroundDarker,
        ),
      ),
      home: const HomePage(),
    );
  }
}
