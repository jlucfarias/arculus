import 'package:flutter/material.dart';

import 'package:arculus/screens/add_token_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addToken(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddTokenScreen()),
    );
  }

  Widget _emptyList() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Nenhuma conta registrada',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Toque no + para adicionar uma conta',
            style: TextStyle(fontSize: 14, color: Color(0xFF8888A8)),
          ),
        ],
      ),
    );
  }

  Widget _tokenList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      itemCount: 2,
      itemBuilder: (ctx, i) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 18, 12, 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'A',
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Emissor',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text('(usuário)', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '123',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '456',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = true;

    return Scaffold(
      appBar: AppBar(
        title: Text('Arculus'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            icon: const Icon(Icons.add_rounded),
            label: Text('Adicionar'),
            onPressed: () => _addToken(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [Expanded(child: isEmpty ? _emptyList() : _tokenList())],
        ),
      ),
    );
  }
}
