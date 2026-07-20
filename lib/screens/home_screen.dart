import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:arculus/extensions/l10n_extension.dart';
import 'package:arculus/repositories/account_repository.dart';
import 'package:arculus/screens/account_screen.dart';
import 'package:arculus/screens/settings_screen.dart';
import 'package:arculus/utils/app_constants.dart';
import 'package:arculus/utils/app_database.dart';
import 'package:arculus/utils/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int?> _selectedAccountId = ValueNotifier<int?>(null);

  @override
  void dispose() {
    _selectedAccountId.dispose();
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
    _selectedAccountId.value = accountId;
  }

  void _emptySelectedAccountList() {
    _selectedAccountId.value = null;
  }

  void _deleteAccount({required int accountId}) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

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
              style: TextButton.styleFrom(foregroundColor: colorScheme.error),
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
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.homeScreen_emptyAccountList_title,
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: ThemeSpacing.small),
          Text(
            l10n.homeScreen_emptyAccountList_description,
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard(Account account, bool isSelected) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: ThemeSpacing.halfMedium),
      child: Card(
        color: isSelected ? colorScheme.primaryContainer : colorScheme.surface,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onLongPress: () {
            HapticFeedback.mediumImpact();
            _selectAccount(account.id);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: ThemeSpacing.medium, vertical: ThemeSpacing.halfMedium),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      (account.issuer ?? account.name)
                          .substring(0, 1)
                          .toUpperCase(),
                      style: textTheme.headlineLarge?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: ThemeSpacing.medium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            account.issuer ?? account.name,
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (account.issuer != null) ...[
                            const SizedBox(width: 10),
                            Text(
                              account.issuer != null ? '(${account.name})' : '',
                              style: textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                      Row(
                        children: [
                          Text('123', style: textTheme.displayMedium),
                          const SizedBox(width: ThemeSpacing.small),
                          Text('456', style: textTheme.displayMedium),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _accountList(List<Account> accounts) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: ThemeSpacing.medium, vertical: ThemeSpacing.halfMedium),
      itemCount: accounts.length,
      itemBuilder: (ctx, i) {
        final account = accounts[i];

        return ValueListenableBuilder<int?>(
          key: ValueKey(account.id),
          valueListenable: _selectedAccountId,
          builder: (context, selectedId, child) =>
              _buildAccountCard(account, selectedId == account.id),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: ValueListenableBuilder<int?>(
        valueListenable: _selectedAccountId,
        builder: (context, selectedId, child) {
          final l10n = context.l10n;
          final isSelected = selectedId != null;

          return AppBar(
            automaticallyImplyLeading: false,
            leading: isSelected
                ? IconButton(
                    onPressed: () => _emptySelectedAccountList(),
                    icon: const Icon(Icons.close),
                  )
                : null,
            title: !isSelected
                ? Text(AppConstants.title)
                : const SizedBox.shrink(),
            actions: [
              if (isSelected) ...[
                IconButton(
                  onPressed: () => _addAccount(accountId: selectedId),
                  icon: const Icon(Icons.edit),
                  tooltip: l10n.homeScreen_editAction_tooltipText,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteAccount(accountId: selectedId),
                  tooltip: l10n.homeScreen_deleteAction_tooltipText,
                ),
              ] else
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  tooltip: l10n.homeScreen_optionsMenuAction_tooltipText,
                  popUpAnimationStyle: AnimationStyle(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
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
                      PopupMenuItem<String>(
                        value: 'settings',
                        child: Text(
                          l10n.homeScreen_optionsMenuAction_settingsItemLabel,
                        ),
                      ),
                    ];
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountRepository = context.read<AccountRepository>();
    final l10n = context.l10n;

    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.homeScreen_floatActionButton_label),
        onPressed: () => _addAccount(),
      ),
      body: SafeArea(
        child: StreamBuilder<List<Account>>(
          stream: accountRepository.watchAllAccounts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final accounts = snapshot.data ?? [];

            return Column(
              children: [
                Expanded(
                  child: accounts.isEmpty
                      ? _emptyList()
                      : _accountList(accounts),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
