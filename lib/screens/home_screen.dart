import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:arculus/providers/theme_provider.dart';
import 'package:arculus/repositories/token_repository.dart';
import 'package:arculus/screens/add_token_screen.dart';
import 'package:arculus/screens/settings_screen.dart';
import 'package:arculus/utils/app_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedTokenId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addToken(BuildContext context, {int? tokenId}) async {
    Token? token;

    if (tokenId != null) {
      final tokenRepository = context.read<TokenRepository>();
      token = await tokenRepository.getTokenById(tokenId);

      _emptySelectedTokenList();
    }

    if (!context.mounted) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTokenScreen(tokenToEdit: token)),
    );
  }

  void _selectToken(int id) {
    setState(() {
      _selectedTokenId = id;
    });
  }

  void _emptySelectedTokenList() {
    setState(() {
      _selectedTokenId = null;
    });
  }

  void _deleteToken(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir conta'),
          content: const Text(
            'Você têm certeza que deseja excluir essa conta?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                final tokenRepository = context.read<TokenRepository>();

                await tokenRepository.deleteToken(id);

                if (!context.mounted) {
                  return;
                }

                Navigator.of(context).pop();
                _emptySelectedTokenList();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
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

  Widget _tokenList(BuildContext context, List<Token> tokens) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      itemCount: tokens.length,
      itemBuilder: (ctx, i) {
        final token = tokens[i];

        return GestureDetector(
          onLongPress: () => _selectToken(token.id),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey,
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
                                (token.issuer ?? token.name)
                                    .substring(0, 1)
                                    .toUpperCase(),
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
                                token.issuer ?? token.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                token.issuer != null ? '(${token.name})' : '',
                                style: TextStyle(fontSize: 16),
                              ),
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final tokenRepository = context.read<TokenRepository>();

    return Scaffold(
      appBar: AppBar(
        leading: _selectedTokenId != null
            ? IconButton(
                onPressed: () => _emptySelectedTokenList(),
                icon: const Icon(Icons.close),
              )
            : null,
        title: _selectedTokenId == null ? Text('Arculus') : null,
        actions: [
          _selectedTokenId != null
              ? IconButton(
                  onPressed: () =>
                      _addToken(context, tokenId: _selectedTokenId!),
                  icon: const Icon(Icons.edit),
                )
              : const SizedBox.shrink(),
          _selectedTokenId != null
              ? IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteToken(context, _selectedTokenId!),
                )
              : const SizedBox.shrink(),
          _selectedTokenId == null
              ? PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'Mais opções',
                  onSelected: (String value) {
                    switch (value) {
                      case 'settings':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(),
                          ),
                        );
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'settings',
                        child: Text('Configurações'),
                      ),
                    ];
                  },
                )
              : const SizedBox.shrink(),
        ],
        backgroundColor: themeProvider.currentTheme.colors.primary,
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
        child: StreamBuilder<List<Token>>(
          stream: tokenRepository.watchAllTokens(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final tokens = snapshot.data ?? [];

            return Container(
              decoration: BoxDecoration(color: themeProvider.currentTheme.colors.background),
              child: Column(
                children: [
                  Expanded(
                    child: tokens.isEmpty
                        ? _emptyList()
                        : _tokenList(context, tokens),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
