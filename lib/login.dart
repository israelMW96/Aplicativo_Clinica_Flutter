import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'menuinicial.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';
  bool _obscureText = true;
  final String correctUsername = 'Brown';
  final String correctPassword = '1234';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/logo_clinica.png'),
              alignment: Alignment(0, -1),
              scale: 2),
          gradient: LinearGradient(
            colors: [Color(0xff3f8ad9), Color(0xff86fde8)],
            stops: [0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 450,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    style: GoogleFonts.titilliumWeb(),
                    decoration: InputDecoration(
                      labelText: 'Usuário',
                      labelStyle: GoogleFonts.titilliumWeb(
                          textStyle: const TextStyle(color: Colors.black)),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
                const SizedBox(
                    height: 20), // espaçamento entre as caixas de texto
                SizedBox(
                  width: 450,
                  child: TextField(
                    obscureText: _obscureText,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    style: GoogleFonts.titilliumWeb(),
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: GoogleFonts.titilliumWeb(
                          textStyle: const TextStyle(color: Colors.black)),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    height: 20), //espaçamento entre a caixa de texto e o botão
                ElevatedButton(
                  onPressed: () {
                    if (username == correctUsername &&
                        password == correctPassword) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Erro!'),
                            content:
                                const Text('Usuário e/ ou senha inválidos.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 50),
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.titilliumWeb(
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
