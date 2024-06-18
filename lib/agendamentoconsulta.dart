import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TelaAgendamento(),
    );
  }
}

class TelaAgendamento extends StatefulWidget {
  const TelaAgendamento({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TelaAgendamentoState createState() => _TelaAgendamentoState();
}

class _TelaAgendamentoState extends State<TelaAgendamento> {
  DateTime _diaSelecionado = DateTime.now();
  final Map<DateTime, Map<String, String>> _horariosSelecionados = {};
  final List<DateTime> _horarios = List.generate(
    8,
    (index) => DateTime(0, 0, 0, 8 + index, 0),
    //gera os horários para agendamento das 08h ás 15h
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamento de Consultas'),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'pt_BR',
            firstDay: DateTime.utc(2024, 5, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _diaSelecionado,
            selectedDayPredicate: (dia) {
              return isSameDay(_diaSelecionado, dia);
            },
            headerStyle: HeaderStyle(
              titleTextFormatter: (date, locale) {
                return DateFormat.yMMMM(locale).format(date).toUpperCase();
              },
              titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 65, 105, 225),
              ),
              titleCentered: true,
            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _diaSelecionado = selectedDay;
              });
            },
          ),
          Container(
            height: 10,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 65, 105, 225),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Horários disponíveis:'.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 3,
              ),
              itemCount: _horarios.length,
              itemBuilder: (context, index) {
                final horario = _horarios[index];
                final isSelected = _horariosSelecionados.containsKey(
                  DateTime(
                    _diaSelecionado.year,
                    _diaSelecionado.month,
                    _diaSelecionado.day,
                    horario.hour,
                  ),
                );
                return GestureDetector(
                  onTap: () => _onTimeSlotTap(horario),
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.green
                          : const Color.fromARGB(255, 65, 105, 225),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        '${horario.hour}:00',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onTimeSlotTap(DateTime horario) {
    final horarioSelecionado = DateTime(
      _diaSelecionado.year,
      _diaSelecionado.month,
      _diaSelecionado.day,
      horario.hour,
    );

    if (_horariosSelecionados.containsKey(horarioSelecionado)) {
      final agendamento = _horariosSelecionados[horarioSelecionado]!;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Detalhes do Agendamento'),
          content: Text(
              'Nome: ${agendamento["nome"]}\nContato: ${agendamento["contato"]}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _horariosSelecionados.remove(horarioSelecionado);
                });
                Navigator.pop(context);
              },
              child: const Text('Cancelar Agendamento'),
            ),
          ],
        ),
      );
    } else {
      final formKey = GlobalKey<FormState>();
      String nomePaciente = '';
      String contatoPaciente = '';

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirmação de Agendamento'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Deseja confirmar o horário ${horario.hour}:00?'),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Nome do Paciente:'),
                  onChanged: (nome) {
                    nomePaciente = nome;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira o nome do paciente';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Contato:'),
                  onChanged: (contato) {
                    contatoPaciente = contato;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira um número para contato';
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    _horariosSelecionados[horarioSelecionado] = {
                      "nome": nomePaciente,
                      "contato": contatoPaciente
                    };
                  });
                  Navigator.pop(context);
                  _showConfirmationDialog(
                      nomePaciente, contatoPaciente, horarioSelecionado);
                }
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      );
    }
  }

  void _showConfirmationDialog(String nome, String contato, DateTime data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agendamento confirmado'),
        content: Text(
            'Agendamento confirmado para $nome ás ${data.hour}:00. \nContato: $contato'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'))
        ],
      ),
    );
  }
}
