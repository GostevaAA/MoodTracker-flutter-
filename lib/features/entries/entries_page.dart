import 'package:flutter/material.dart';

class EntriesPage extends StatelessWidget {
  const EntriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Все записи')),
      body: const Center(
        child: Text('Список всех записей скоро появится'),
      ),
    );
  }
}
