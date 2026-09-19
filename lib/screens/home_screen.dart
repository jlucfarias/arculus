import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:provider/provider.dart';

import 'package:arculus/extensions/l10n_extension.dart';
import 'package:arculus/providers/token_visibility_provider.dart';
import 'package:arculus/repositories/account_repository.dart';
import 'package:arculus/repositories/folder_repository.dart';
import 'package:arculus/screens/account_screen.dart';
import 'package:arculus/screens/settings_screen.dart';
import 'package:arculus/utils/app_constants.dart';
import 'package:arculus/utils/app_database.dart';
import 'package:arculus/utils/app_theme.dart';
import 'package:arculus/widgets/token_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int?> _selectedAccountId = ValueNotifier<int?>(null);
  final ValueNotifier<int?> _selectedFolderId = ValueNotifier<int?>(null);
  final _folderNameController = TextEditingController();

  @override
  void dispose() {
    _selectedAccountId.dispose();
    _selectedFolderId.dispose();
    _folderNameController.dispose();
    super.dispose();
  }

  void _addAccount({int? accountId}) async {
    final localContext = context;
    Account? account;

    if (accountId != null) {
      final accountRepository = localContext.read<AccountRepository>();
      account = await accountRepository.getById(accountId);

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

  void _selectFolder(int folderId) {
    _selectedFolderId.value = folderId;
  }

  void _emptySelectedAccountList() {
    _selectedAccountId.value = null;
  }

  void _selectFolderAll() {
    _selectedFolderId.value = null;
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

                await accountRepository.delete(accountId);
                await accountRepository.deleteFromAllFolders(accountId);

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

  Future<void> _addFolder() async {
    final folderRepository = context.read<FolderRepository>();
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        final l10n = context.l10n;

        return AlertDialog(
          title: Text(l10n.homeScreen_addFolderDialog_title),
          content: TextField(
            controller: _folderNameController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: l10n.homeScreen_addFolderDialog_nameInput_hintText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.homeScreen_addFolderDialog_action_cancel_label),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, {
                'name': _folderNameController.text.trim(),
              }),
              child: Text(l10n.homeScreen_addFolderDialog_action_save_label),
            ),
          ],
        );
      },
    );

    _folderNameController.clear();

    if (result != null &&
        (result['name'] ?? '').isNotEmpty &&
        context.mounted) {
      await folderRepository.insert(
        FoldersCompanion(name: Value(result['name']!)),
      );
    }
  }

  Future<void> _deleteFolder({required int folderId}) async {
    //final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final l10n = context.l10n;

        return AlertDialog(
          title: Text(l10n.homeScreen_deleteFolderDialog_title),
          content: Text(l10n.homeScreen_deleteFolderDialog_content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                l10n.homeScreen_deleteFolderDialog_action_cancel_label,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: colorScheme.error),
              onPressed: () async {
                final folderRepository = context.read<FolderRepository>();

                await folderRepository.delete(folderId);

                if (!context.mounted) {
                  return;
                }

                Navigator.of(context).pop();
              },
              child: Text(
                l10n.homeScreen_deleteFolderDialog_action_delete_label,
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

  Widget _accountList(List<Account> accounts) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeSpacing.medium,
        vertical: ThemeSpacing.halfMedium,
      ),
      itemCount: accounts.length,
      itemBuilder: (ctx, i) {
        final account = accounts[i];

        return ValueListenableBuilder<int?>(
          key: ValueKey(account.id),
          valueListenable: _selectedAccountId,
          builder: (context, selectedId, child) => TokenCard(
            account: account,
            isSelected: selectedId == account.id,
            onSelect: () {
              HapticFeedback.mediumImpact();
              _selectAccount(account.id);
            },
          ),
        );
      },
    );
  }

  void _toggleCodeVisibility() {
    final tokenVisibilityProvider = context.read<TokenVisibilityProvider>();

    setState(() {
      tokenVisibilityProvider.toggleTokenVisibility();
    });
  }

  PreferredSizeWidget _buildAppBar() {
    final tokenVisibilityProvider = context.watch<TokenVisibilityProvider>();
    final accountRepository = context.read<AccountRepository>();

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
              ] else ...[
                StreamBuilder<List<(Account, List<int>)>>(
                  stream: accountRepository.watchAllWithFolderIds(),
                  builder: (context, snapshot) {
                    return ValueListenableBuilder<int?>(
                      valueListenable: _selectedFolderId,
                      builder: (context, selectedFolderId, child) {
                        final accounts = snapshot.data ?? [];
                        final bool hasContent = selectedFolderId == null
                            ? accounts.isNotEmpty
                            : accounts.any(
                                (item) => item.$2.contains(selectedFolderId),
                              );

                        if (!hasContent) {
                          return const SizedBox.shrink();
                        }

                        return IconButton(
                          style: IconButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            tokenVisibilityProvider.isTokenVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          tooltip: tokenVisibilityProvider.isTokenVisible
                              ? l10n.homeScreen_toggleVisibilityAction_tooltip_on
                              : l10n.homeScreen_toggleVisibilityAction_tooltip_off,
                          onPressed: _toggleCodeVisibility,
                        );
                      },
                    );
                  },
                ),
              ],
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

  Widget _foldersBar() {
    final accountRepository = context.read<AccountRepository>();
    final folderRepository = context.read<FolderRepository>();
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: ThemeSpacing.medium),
        scrollDirection: Axis.horizontal,
        children: [
          ValueListenableBuilder<int?>(
            valueListenable: _selectedFolderId,
            builder: (context, selectedId, child) {
              final isAllSelected = selectedId == null;

              return StreamBuilder<int>(
                stream: accountRepository.watchCount(),
                builder: (context, snapshot) {
                  final totalAccounts = snapshot.data ?? 0;

                  return ActionChip(
                    backgroundColor: isAllSelected ? colorScheme.primary : null,
                    label: Row(
                      children: [
                        Text(
                          l10n.homeScreen_foldersBar_allAccountsFolder_label,
                        ),
                        const SizedBox(width: ThemeSpacing.small),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: ThemeSpacing.xsmall,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              ThemeRadii.r150,
                            ),
                          ),
                          child: Text(
                            '$totalAccounts',
                            style: ThemeTypography.bodySm.copyWith(
                              fontWeight: ThemeTypography.bold,
                              color: isAllSelected
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                    labelStyle: ThemeTypography.bodySm.copyWith(
                      color: isAllSelected
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface,
                    ),
                    onPressed: () {
                      if (!isAllSelected) {
                        _selectFolderAll();
                      }
                    },
                  );
                },
              );
            },
          ),
          SizedBox(width: ThemeSpacing.small),
          StreamBuilder<List<dynamic>>(
            stream: folderRepository.watchAllWithAccountsCount(),
            builder: (context, snapshot) {
              final folders = snapshot.data ?? [];

              if (folders.isEmpty) {
                return const SizedBox.shrink();
              }

              return ValueListenableBuilder<int?>(
                valueListenable: _selectedFolderId,
                builder: (context, selectedId, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: folders.indexed.map((entry) {
                      final index = entry.$1;
                      final tuple = entry.$2;
                      final folder = tuple.$1;
                      final accountCount = tuple.$2;
                      final isSelected = selectedId == folder.id;
                      final isLast = index == folders.length - 1;

                      return Padding(
                        padding: EdgeInsets.only(
                          right: isLast
                              ? ThemeSpacing.xsmall
                              : ThemeSpacing.small,
                        ),
                        child: GestureDetector(
                          onLongPress: () {
                            _deleteFolder(folderId: folder.id);
                          },
                          child: ChoiceChip(
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(folder.name),
                                const SizedBox(width: ThemeSpacing.xsmall),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: ThemeSpacing.xsmall,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      ThemeRadii.r150,
                                    ),
                                  ),
                                  child: Text(
                                    '$accountCount',
                                    style: ThemeTypography.bodySm.copyWith(
                                      fontWeight: ThemeTypography.bold,
                                      color: isSelected
                                          ? colorScheme.onPrimary
                                          : colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            selected: isSelected,
                            showCheckmark: false,
                            onSelected: (bool selected) {
                              if (selected) {
                                _selectFolder(folder.id);
                              }
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              );
            },
          ),
          ActionChip(
            label: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.add)],
            ),
            labelPadding: EdgeInsets.zero,
            tooltip: l10n.homeScreen_foldersBar_addFolderButton_tooltipText,
            onPressed: () {
              _addFolder();
            },
          ),
        ],
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
        child: Column(
          children: [
            _foldersBar(),
            Expanded(
              child: StreamBuilder<List<(Account, List<int>)>>(
                stream: accountRepository.watchAllWithFolderIds(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      !snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final accounts = snapshot.data ?? [];

                  return ValueListenableBuilder<int?>(
                    valueListenable: _selectedFolderId,
                    builder: (context, selectedFolderId, child) {
                      List<Account> filteredAccounts;

                      if (selectedFolderId == null) {
                        filteredAccounts = accounts
                            .map((item) => item.$1)
                            .toList();
                      } else {
                        filteredAccounts = accounts
                            .where((item) => item.$2.contains(selectedFolderId))
                            .map((item) => item.$1)
                            .toList();
                      }

                      if (filteredAccounts.isEmpty) {
                        return _emptyList();
                      }

                      return _accountList(filteredAccounts);
                    },
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
