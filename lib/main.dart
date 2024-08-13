import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katalog/data/dataSource/auth_remote_datasource.dart';
import 'package:katalog/data/dataSource/product_remote_datasource.dart';
import 'package:katalog/page/splashScreen.dart';
import 'package:katalog/presentation/auth/bloc/login/login_bloc.dart';
import 'package:katalog/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:katalog/presentation/home/bloc/favorite/favorite_bloc.dart';
import 'package:katalog/presentation/home/bloc/product/product_bloc.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductRemoteDatasource())..add(const ProductEvent.fetch()),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDataSource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.quicksand(
              color: Colors.blue,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: Colors.blue,
            ),
          ),
        ),
        home: SplashScreen(), // Mengatur SplashScreen sebagai layar awal
      ),
    );
  }
}
