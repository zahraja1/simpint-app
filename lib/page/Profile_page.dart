import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katalog/data/dataSource/auth_local_datasource.dart';
import 'package:katalog/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:katalog/presentation/auth/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Untuk menempatkan konten di tengah secara vertikal
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50, // Mengatur ukuran CircleAvatar
                  backgroundImage: AssetImage('images/slide1.jpg'), // Ganti dengan path gambar Anda
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Jake',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'customer@gmail.com',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (_) {
                  AuthLocalDataSource().removeAuthData();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<LogoutBloc>().add(const LogoutEvent.logout());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD8B4FE), // Set the button color here
                ),
                child: const Text('Logout',style: TextStyle(color: Colors.white,)),
              );
            },
          ),
        ],
      ),
    );
  }
}
