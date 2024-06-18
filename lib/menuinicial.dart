import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'perfilmedico.dart';
import 'historicopacientes.dart';
import 'agendamentoconsulta.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clínica Médica'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff3f8ad9), Color(0xff86fde8)],
            stops: [0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50), // Espaçamento no topo
            const MiniProfile(),
            const SizedBox(
                height: 20), // Espaçamento entre o perfil e os botões
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 320,
                  //height: 500,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    padding: const EdgeInsets.all(10),
                    children: [
                      MenuButton(
                        title: 'Agendamento',
                        icon: Icons.calendar_today,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TelaAgendamento(),
                            ),
                          );
                        },
                      ),
                      MenuButton(
                        title: 'Histórico',
                        icon: Icons.history,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HistoricoPacientes()),
                          );
                        },
                      ),
                      MenuButton(
                        title: 'Perfil',
                        icon: Icons.person,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PerfilMedico()),
                          );
                        },
                      ),
                      MenuButton(
                        title: 'Sair',
                        icon: Icons.exit_to_app,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        color: Colors.red, // Botão de sair em vermelho
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiniProfile extends StatelessWidget {
  const MiniProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 300,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
                'assets/images/avatar.jpg'), // Adicionando a imagem do avatar
          ),
          const SizedBox(width: 10),
          Text(
            'Bem-vindo, Dr. Brown!',
            style: GoogleFonts.titilliumWeb(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  const MenuButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: color != null ? Colors.white : Colors.black,
          backgroundColor: color ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Bordas arredondadas
            side: BorderSide(
                color: color ?? Colors.transparent), // Borda opcional
          ),
          elevation: 5, // Elevação para efeito de sombra
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: color != null ? Colors.white : Colors.black, size: 30),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.titilliumWeb(
                textStyle: TextStyle(
                    color: color != null ? Colors.white : Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
