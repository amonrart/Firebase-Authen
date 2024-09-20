import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/auth-service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Container(
          height: 350,
          width: 300,
          padding: const EdgeInsets.all(18),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 40),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: "Email", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Password", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  if (passwordController.text.length < 8) {
                    setState(() {
                      errorMessage =
                          "Password must be at least 8 characters long.";
                    });
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    setState(() {
                      errorMessage = "Passwords do not match.";
                    });
                  } else {
                    var res = await AuthService().register(
                        email: emailController.text,
                        password: passwordController.text);
                    if (res == 'success') {
                      Navigator.pop(context); // Go back to Sign In screen
                    } else {
                      setState(() {
                        errorMessage = res;
                      });
                    }
                  }
                },
                child: const Text("Sign Up"),
              ),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
