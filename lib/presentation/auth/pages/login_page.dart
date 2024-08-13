import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:katalog/data/dataSource/auth_local_datasource.dart';
import 'package:katalog/page/screens.dart';
import 'package:katalog/presentation/auth/bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 138, 159, 213),
              Color.fromARGB(255, 187, 227, 245)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 80.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                                    const SizedBox(height: 8.0),
                  FadeTransition(
                    opacity: _animation,
                    child: const Center(
                      child: Text(
                        'Simpint',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            FadeTransition(
              opacity: _animation,
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 253, 251, 251)),
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 86, 81, 81)),
                  prefixIcon: Icon(Icons.email, color: const Color.fromARGB(255, 249, 247, 247)),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 236, 233, 233).withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: const Color.fromARGB(255, 14, 14, 14)),
              ),
            ),
            const SizedBox(height: 12.0),
            FadeTransition(
              opacity: _animation,
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 246, 243, 243)),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 86, 81, 81)),
                  prefixIcon: Icon(Icons.lock, color: const Color.fromARGB(255, 248, 246, 246)),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 236, 233, 233).withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: const Color.fromARGB(255, 12, 12, 12)),
              ),
            ),
            const SizedBox(height: 24.0),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  success: (authResponseModel) {
                    AuthLocalDataSource().saveAuthData(authResponseModel);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Screens(),
                      ),
                    );
                  },
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                );
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(
                                LoginEvent.login(
                                  email: usernameController.text,
                                  password: passwordController.text,
                                ),
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          shadowColor: Colors.black45,
                          elevation: 5,
                        ),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
