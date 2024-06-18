import 'package:flutter/material.dart';

class PerfilMedico extends StatelessWidget {
  const PerfilMedico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Médico'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff091e3a), Color(0xff2f80ed), Color(0xff2d9ee0)],
          stops: [0, 0.5, 1],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAvatar(),
            const SizedBox(height: 20),
            _buildInfoCard('Dr. Mano Brown', 'Oftalmologista', 'CRM: 666',
                'Contato: 4002-8922'),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return const CircleAvatar(
      radius: 70,
      backgroundColor: Colors.white,
      backgroundImage: AssetImage('assets/images/avatar.jpg'),
    );
  }

  Widget _buildInfoCard(
      String name, String specialty, String crm, String contact) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildText(name, 24, FontWeight.bold, Colors.black),
          const SizedBox(height: 10),
          _buildText(specialty, 18, FontWeight.normal, Colors.black),
          const SizedBox(height: 10),
          _buildText(crm, 16, FontWeight.normal, Colors.black),
          const SizedBox(height: 10),
          _buildText(contact, 16, FontWeight.normal, Colors.black),
        ],
      ),
    );
  }

  Widget _buildText(
      String text, double fontSize, FontWeight fontWeight, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
