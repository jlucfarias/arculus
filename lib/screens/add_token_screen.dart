import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' hide Column;

import 'package:arculus/utils/app_database.dart';
import 'package:arculus/repositories/token_repository.dart';

class AddTokenScreen extends StatefulWidget {
  const AddTokenScreen({super.key});

  @override
  State<AddTokenScreen> createState() => _AddTokenScreenState();
}

class _AddTokenScreenState extends State<AddTokenScreen> {
  final _nameController = TextEditingController();
  final _nameFieldKey = GlobalKey<FormFieldState>();
  final _issuerController = TextEditingController();
  final _secretController = TextEditingController();
  final _secretFieldKey = GlobalKey<FormFieldState>();
  final _intervalController = TextEditingController(text: '30');
  final _intervalFieldKey = GlobalKey<FormFieldState>();
  final _digitsController = TextEditingController(text: '6');
  final _digitsFieldKey = GlobalKey<FormFieldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _issuerController.dispose();
    _secretController.dispose();
    _intervalController.dispose();
    _digitsController.dispose();
    super.dispose();
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void _addToken(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final tokenRepository = context.read<TokenRepository>();
      final token = TokensCompanion.insert(
        name: _nameController.text,
        issuer: Value(_issuerController.text),
        secret: _secretController.text,
        interval: int.parse(_intervalController.text),
        digits: int.parse(_digitsController.text),
      );

      await tokenRepository.insertToken(token);

      if (!context.mounted) {
        return;
      }

      _goBack(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _goBack(context),
          ),
          title: Text('Adicionar conta'),
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    key: _nameFieldKey,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.account_box),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nome da conta vazio';
                      }

                      return null;
                    },
                    onChanged: (text) {
                      if (_nameFieldKey.currentState?.hasError ?? false) {
                        _nameFieldKey.currentState?.reset();
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _issuerController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Emissor',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.supervisor_account),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _secretController,
                    key: _secretFieldKey,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Segredo',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.fingerprint),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.casino_outlined),
                        color: Colors.grey,
                        tooltip: 'Gerar segredo',
                        onPressed: () => print('Segredo gerado'),
                      ),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Chave não pode estar vazia';
                      }

                      return null;
                    },
                    onChanged: (text) {
                      if (_secretFieldKey.currentState?.hasError ?? false) {
                        _secretFieldKey.currentState?.reset();
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _intervalController,
                            key: _intervalFieldKey,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Intervalo (segundos)',
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(),
                              focusedErrorBorder: OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 16,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Invervalo vazio';
                              }

                              if (int.parse(value) == 0) {
                                return 'Intervalo inválido';
                              }

                              return null;
                            },
                            onChanged: (text) {
                              if (_intervalFieldKey.currentState?.hasError ??
                                  false) {
                                _intervalFieldKey.currentState?.reset();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            controller: _digitsController,
                            key: _digitsFieldKey,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Dígitos',
                              labelStyle: TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(),
                              focusedErrorBorder: OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 16,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Dígitos vazios';
                              }

                              if (int.parse(value) == 0) {
                                return 'Dígitos inválidos';
                              }

                              return null;
                            },
                            onChanged: (text) {
                              if (_digitsFieldKey.currentState?.hasError ??
                                  false) {
                                _digitsFieldKey.currentState?.reset();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _addToken(context),
                      label: const Text('Adicionar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
