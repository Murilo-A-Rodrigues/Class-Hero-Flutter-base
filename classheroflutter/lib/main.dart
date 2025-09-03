import 'package:flutter/material.dart';

// Classe para representar um Evento
class Event {
  final String name;
  final String date;
  final String location;

  Event({required this.name, required this.date, required this.location});
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Eventos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const EventScreen(),
    );
  }
}

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // Controladores para os campos de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Lista para armazenar os eventos cadastrados
  final List<Event> _events = [];

  // Função para adicionar um novo evento
  void _addEvent() {
    // Verifica se os campos não estão vazios
    if (_nameController.text.isNotEmpty &&
        _dateController.text.isNotEmpty &&
        _locationController.text.isNotEmpty) {
      setState(() {
        // Adiciona o novo evento à lista
        _events.add(
          Event(
            name: _nameController.text,
            date: _dateController.text,
            location: _locationController.text,
          ),
        );
        // Limpa os campos de texto após o cadastro
        _nameController.clear();
        _dateController.clear();
        _locationController.clear();
      });
    } else {
        // Mostra um aviso caso algum campo esteja vazio
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Por favor, preencha todos os campos.'))
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Eventos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Campo de texto para o Nome do Evento
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome do Evento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12.0),

            // Campo de texto para a Data
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Data',
                hintText: 'DD/MM/AAAA',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 12.0),

            // Campo de texto para o Local
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Local',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),

            // Botão para Cadastrar
            ElevatedButton(
              onPressed: _addEvent,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text('Cadastrar Evento'),
            ),
            const SizedBox(height: 20.0),

            // Título da lista de eventos
            const Text(
              'Eventos Cadastrados:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),

            // Lista de Eventos
            Expanded(
              child: ListView.builder(
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  final event = _events[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: const Icon(Icons.event),
                      title: Text(event.name),
                      subtitle: Text('${event.location} - ${event.date}'),
                    ),
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