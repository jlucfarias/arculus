import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:arculus/extensions/l10n_extension.dart';
import 'package:arculus/providers/theme_provider.dart';
import 'package:arculus/repositories/account_repository.dart';
import 'package:arculus/screens/account_screen.dart';
import 'package:arculus/screens/settings_screen.dart';
import 'package:arculus/utils/app_constants.dart';
import 'package:arculus/utils/app_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedAccountId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addAccount({int? accountId}) async {
    final localContext = context;
    Account? account;

    if (accountId != null) {
      final accountRepository = localContext.read<AccountRepository>();
      account = await accountRepository.getAccountById(accountId);

      _emptySelectedAccountList();
    }

    if (!localContext.mounted) {
      return;
    }

    Navigator.push(
      localContext,
      MaterialPageRoute(
        builder: (screenContext) => AccountScreen(accountToEdit: account),
      ),
    );
  }

  void _selectAccount(int accountId) {
    setState(() {
      _selectedAccountId = accountId;
    });
  }

  void _emptySelectedAccountList() {
    setState(() {
      _selectedAccountId = null;
    });
  }

  void _deleteAccount({required int accountId}) {
    final l10n = context.l10n;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.homeScreen_deleteAccountDialog_title),
          content: Text(l10n.homeScreen_deleteAccountDialog_content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                l10n.homeScreen_deleteAccountDialog_cancelButton_label,
              ),
            ),
            TextButton(
              onPressed: () async {
                final accountRepository = context.read<AccountRepository>();

                await accountRepository.deleteAccount(accountId);

                if (!context.mounted) {
                  return;
                }

                Navigator.of(context).pop();
                _emptySelectedAccountList();
              },
              child: Text(
                l10n.homeScreen_deleteAccountDialog_confirmButton_label,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _emptyList() {
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.homeScreen_emptyAccountList_title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.homeScreen_emptyAccountList_description,
            style: TextStyle(fontSize: 14, color: Color(0xFF8888A8)),
          ),
        ],
      ),
    );
  }

  Widget _accountList(List<Account> accounts) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      itemCount: accounts.length,
      itemBuilder: (ctx, i) {
        final account = accounts[i];

        return GestureDetector(
          onLongPress: () => _selectAccount(account.id),
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
                                (account.issuer ?? account.name)
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
                                account.issuer ?? account.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                account.issuer != null ? '(${account.name})' : '',
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

  Widget? _buildEmptyAccountSelection() {
    if (_selectedAccountId != null) {
      return IconButton(
        onPressed: () => _emptySelectedAccountList(),
        icon: const Icon(Icons.close),
      );
    }

    return null;
  }

  Widget? _buildTitle() {
    if (_selectedAccountId == null) {
      return Text(AppConstants.title);
    }

    return null;
  }

  Widget _buildEditSelectedAccountAction() {
    if (_selectedAccountId != null) {
      return IconButton(
        onPressed: () => _addAccount(accountId: _selectedAccountId!),
        icon: const Icon(Icons.edit),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildDeleteSelectedAccountAction() {
    if (_selectedAccountId != null) {
      return IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _deleteAccount(accountId: _selectedAccountId!),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildOptionsMenuAction() {
    if (_selectedAccountId != null) {
      return const SizedBox.shrink();
    }

    final l10n = context.l10n;

    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      tooltip: l10n.homeScreen_optionsMenuAction_tooltipText,
      onSelected: (String value) {
        switch (value) {
          case 'settings':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'settings',
            child: Text(l10n.homeScreen_optionsMenuAction_settingsItemLabel),
          ),
        ];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final accountRepository = context.read<AccountRepository>();
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        leading: _buildEmptyAccountSelection(),
        title: _buildTitle(),
        actions: [
          _buildEditSelectedAccountAction(),
          _buildDeleteSelectedAccountAction(),
          _buildOptionsMenuAction(),
        ],
        backgroundColor: themeProvider.currentTheme.colors.primary,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.homeScreen_floatActionButton_label),
            onPressed: () => _addAccount(),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<Account>>(
          stream: accountRepository.watchAllAccounts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final accounts = snapshot.data ?? [];

            return Container(
              decoration: BoxDecoration(
                color: themeProvider.currentTheme.colors.background,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: accounts.isEmpty ? _emptyList() : _accountList(accounts),
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
