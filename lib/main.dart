import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:book_library/common/src/routing/router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) {
        return const ProviderScope(child: MyApp());
      },
    ),
  );

  await Hive.initFlutter();
  await Hive.openBox('saveBox');
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.kanitTextTheme().apply(bodyColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}
