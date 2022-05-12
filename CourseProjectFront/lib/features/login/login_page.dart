import 'package:books_front/main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildField(loginController, 'Логин'),
            buildField(passwordController, 'Пароль', obscureText: true),
            const SizedBox(height: 16),
            Container(
              constraints: const BoxConstraints(maxWidth: 420),
              child: ElevatedButton(
                onPressed: () {
                  Future.delayed(
                    Duration.zero,
                    () async {
                      if (loginController.text == 'admin' &&
                          passwordController.text == 'admin') {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const Dialog(
                              child: Center(
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          },
                        );
                        await Future.delayed(const Duration(seconds: 2));
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ),
                        );
                      }
                    },
                  );
                },
                child: const Text('Войти'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildField(TextEditingController controller, String hint,
    {bool onlyInt = false, bool obscureText = false}) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
    child: Container(
      constraints: const BoxConstraints(maxWidth: 420),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value != null) {
            if (value.isEmpty) {
              return 'Поле не может быть пустым';
            }
            if (onlyInt && int.tryParse(value) == null) {
              return 'Должно быть целым числом';
            }
          }
        },
        decoration: InputDecoration(hintText: hint),
        obscureText: obscureText,
      ),
    ),
  );
}
