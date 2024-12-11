import 'package:clean/core/theme/theme.dart';
import 'package:clean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean/features/auth/presentation/pages/signin_page.dart';
import 'package:clean/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  try {
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => serviceLocator<AuthBloc>(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e) {
    debugPrint('Supabase initialization failed: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const SignInPage(),
    );
  }
}
