import 'package:flutter/material.dart';

class HistoricoPacientes extends StatelessWidget {
  const HistoricoPacientes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Pacientes'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff3f8ad9), Color(0xff86fde8)],
          stops: [0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildPacienteCard(
                context,
                'João da Silva',
                '15/05/2024',
                'Conjuntivite',
                'Paciente se queixava de ardência e dificuldade para manter os olhos abertos.'),
            const SizedBox(height: 20),
            _buildPacienteCard(
                context,
                'Maria Oliveira',
                '12/05/2024',
                'Miopia',
                'Realizados exames que constam miopia em ambos os olhos .'),
            const SizedBox(height: 20),
            _buildPacienteCard(context, 'Marcio', '05/05/2024', 'Ciclope',
                'O individuo relata que possui apenas um olho no centro da testa.'),
            const SizedBox(height: 20),
            _buildPacienteCard(context, 'Marcelo', '05/05/2024', 'Ciclope',
                'O individuo relata que possui apenas um olho no centro da testa.'),
          ],
        ),
      ),
    );
  }

  Widget _buildPacienteCard(BuildContext context, String nome, String data,
      String diagnostico, String info) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.blueAccent,
                size: 30,
              ),
              const SizedBox(width: 10),
              _buildText(nome, 20, FontWeight.bold, Colors.black),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_today,
                  color: Colors.blueAccent, size: 20),
              const SizedBox(width: 10),
              _buildText(data, 16, FontWeight.normal, Colors.black),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.medical_services,
                  color: Colors.blueAccent, size: 20),
              const SizedBox(width: 10),
              _buildText(diagnostico, 16, FontWeight.normal, Colors.black),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.info_outline,
                    color: Colors.blueAccent, size: 24),
                onPressed: () => _showInfoDialog(context, diagnostico, info),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String diagnostico, String info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(diagnostico),
          content: Text(info),
          actions: [
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
