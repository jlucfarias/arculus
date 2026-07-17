import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' hide Column;

import 'package:arculus/extensions/l10n_extension.dart';
import 'package:arculus/providers/theme_provider.dart';
import 'package:arculus/utils/app_database.dart';
import 'package:arculus/repositories/account_repository.dart';

class AccountScreen extends StatefulWidget {
  final Account? accountToEdit;

  const AccountScreen({super.key, this.accountToEdit});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
  bool _showSecret = false;

  @override
  void initState() {
    super.initState();

    if (widget.accountToEdit != null) {
      final account = widget.accountToEdit!;
      _nameController.text = account.name;
      _issuerController.text = account.issuer ?? '';
      _secretController.text = account.secret;
      _intervalController.text = account.interval.toString();
      _digitsController.text = account.digits.toString();
    }
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

  void _saveAccount(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final accountRepository = context.read<AccountRepository>();
      final isEditing = widget.accountToEdit != null;

      if (isEditing) {
        final updatedAccount = AccountsCompanion(
          id: Value(widget.accountToEdit!.id),
          name: Value(_nameController.text),
          issuer: Value(_issuerController.text),
          secret: Value(_secretController.text),
          interval: Value(int.parse(_intervalController.text)),
          digits: Value(int.parse(_digitsController.text)),
        );

        await accountRepository.updateAccount(updatedAccount);
      } else {
        final account = AccountsCompanion.insert(
          name: _nameController.text,
          issuer: Value(_issuerController.text),
          secret: _secretController.text,
          interval: int.parse(_intervalController.text),
          digits: int.parse(_digitsController.text),
        );

        await accountRepository.insertAccount(account);
      }

      if (!context.mounted) {
        return;
      }

      _goBack(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themProvider = context.watch<ThemeProvider>();
    final l10n = context.l10n;

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
          title: Text(
            widget.accountToEdit != null
                ? l10n.accountScreen_editAccount_title
                : l10n.accountScreen_addAccount_title,
          ),
          backgroundColor: themProvider.currentTheme.colors.primary,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: themProvider.currentTheme.colors.background,
            ),
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
                        labelText: l10n.accountScreen_nameInput_label,
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
                          return l10n.accountScreen_nameInput_emptyErrorMessage;
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
                        labelText: l10n.accountScreen_issuerInput_label,
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
                        labelText: l10n.accountScreen_secretInput_label,
                        labelStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.fingerprint),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showSecret
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          color: Colors.grey,
                          tooltip:
                              l10n.accountScreen_secretInput_showSecretTooltip,
                          onPressed: () {
                            setState(() {
                              _showSecret = !_showSecret;
                            });
                          },
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
                          return l10n
                              .accountScreen_secretInput_emptyErrorMessage;
                        }

                        // return l10n.accountScreen_secretInput_invalidErrorMessage

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
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText:
                                    l10n.accountScreen_intervalInput_label,
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
                                  return l10n
                                      .accountScreen_intervalInput_emptyErrorMessage;
                                }

                                if (int.parse(value) == 0) {
                                  return l10n
                                      .accountScreen_intervalInput_invalidErrorMessage;
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
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: l10n.accountScreen_digitsInput_label,
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
                                  return l10n
                                      .accountScreen_digitsInput_emptyErrorMessage;
                                }

                                if (int.parse(value) == 0) {
                                  return l10n
                                      .accountScreen_digitsInput_invalidErrorMessage;
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
                        onPressed: () => _saveAccount(context),
                        label: Text(
                          widget.accountToEdit != null
                              ? l10n.accountScreen_editAccount_confirmButton_label
                              : l10n.accountScreen_addAccount_confirmButton_label,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              themProvider.currentTheme.colors.primary,
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
      ),
    );
  }
}
