import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_horizen_test_app/core/theme/theme.dart';

import 'features/barber/presentation/cubit/barber_cubits.dart';
import 'features/barber/presentation/pages/barbers_page.dart';
import 'features/services/presentation/cubit/service_cubits.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ServiceCubit>()),
        BlocProvider(create: (_) => di.sl<BarberCubit>()),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          title: 'Barber App',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          home: const BarbersPage(),
        ),
      ),
    );
  }
}
