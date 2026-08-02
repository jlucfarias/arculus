import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp/otp.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' hide Column;

import 'package:arculus/extensions/l10n_extension.dart';
import 'package:arculus/repositories/account_repository.dart';
import 'package:arculus/services/otp_service.dart';
import 'package:arculus/utils/app_database.dart';
import 'package:arculus/utils/app_theme.dart';

final int defaultInterval = 30;
final int defaultDigits = 6;

class SelectOption<T> {
  final T value;
  final String label;

  SelectOption({required this.value, required this.label});
}

final List<SelectOption<String>> tokenTypeOptions = [
  SelectOption(label: 'TOTP', value: 'totp'),
  //SelectOption(label: 'HOTP', value: 'hotp'),
];

final List<SelectOption<String>> algorithmOptions = [
  ...Algorithm.values.map((algorithm) {
    return SelectOption(
      label: algorithm.name,
      value: algorithm.name.toLowerCase(),
    );
  }),
];

class AccountScreen extends StatefulWidget {
  final Account? accountToEdit;

  const AccountScreen({super.key, this.accountToEdit});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _nameController = TextEditingController();
  final _issuerController = TextEditingController();
  final _secretController = TextEditingController();
  final _tokenTypeController = TextEditingController();
  final _algorithmController = TextEditingController();
  final _intervalController = TextEditingController(
    text: defaultInterval.toString(),
  );
  final _digitsController = TextEditingController(
    text: defaultDigits.toString(),
  );
  final _formKey = GlobalKey<FormState>();
  bool _showSecret = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    if (widget.accountToEdit != null) {
      final account = widget.accountToEdit!;
      _nameController.text = account.name;
      _issuerController.text = account.issuer ?? '';
      _secretController.text = account.secret;
      _tokenTypeController.text = account.tokenType;
      _algorithmController.text = account.algorithm;
      _intervalController.text = account.interval.toString();
      _digitsController.text = account.digits.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _issuerController.dispose();
    _secretController.dispose();
    _tokenTypeController.dispose();
    _algorithmController.dispose();
    _intervalController.dispose();
    _digitsController.dispose();
    super.dispose();
  }

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void _saveAccount(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final l10n = context.l10n;

    try {
      final accountRepository = context.read<AccountRepository>();
      final isEditing = widget.accountToEdit != null;
      final name = _nameController.text.trim();
      final secret = _secretController.text
          .trim()
          .replaceAll(' ', '')
          .toUpperCase();

      if (isEditing) {
        final updatedAccount = AccountsCompanion(
          id: Value(widget.accountToEdit!.id),
          name: Value(name),
          issuer: Value(_issuerController.text),
          secret: Value(secret),
          tokenType: Value(_tokenTypeController.text),
          algorithm: Value(_algorithmController.text),
          interval: Value(
            int.tryParse(_intervalController.text) ?? defaultInterval,
          ),
          digits: Value(int.tryParse(_digitsController.text) ?? defaultDigits),
        );

        await accountRepository.updateAccount(updatedAccount);
      } else {
        final account = AccountsCompanion.insert(
          name: name,
          issuer: Value(_issuerController.text),
          secret: secret,
          tokenType: _tokenTypeController.text,
          algorithm: _algorithmController.text,
          interval: int.tryParse(_intervalController.text) ?? defaultInterval,
          digits: int.tryParse(_digitsController.text) ?? defaultDigits,
        );

        await accountRepository.insertAccount(account);
      }

      if (!context.mounted) {
        return;
      }

      _goBack(context);
    } catch (e) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.accountScreen_saveAccount_saveErrorMessage),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
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
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ThemeSpacing.medium,
            vertical: ThemeSpacing.halfMedium,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: l10n.accountScreen_nameInput_label,
                    prefixIcon: Icon(Icons.account_box),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.accountScreen_nameInput_emptyErrorMessage;
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: ThemeSpacing.halfMedium),
                TextFormField(
                  controller: _issuerController,
                  decoration: InputDecoration(
                    labelText: l10n.accountScreen_issuerInput_label,
                    prefixIcon: Icon(Icons.supervisor_account),
                  ),
                ),
                const SizedBox(height: ThemeSpacing.halfMedium),
                TextFormField(
                  controller: _secretController,
                  obscureText: !_showSecret,
                  decoration: InputDecoration(
                    labelText: l10n.accountScreen_secretInput_label,
                    prefixIcon: Icon(Icons.fingerprint),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showSecret ? Icons.visibility_off : Icons.visibility,
                      ),
                      tooltip: l10n.accountScreen_secretInput_showSecretTooltip,
                      onPressed: () {
                        setState(() {
                          _showSecret = !_showSecret;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.accountScreen_secretInput_emptyErrorMessage;
                    }

                    if (!OtpService.isValidSecret(value)) {
                      return l10n.accountScreen_secretInput_invalidErrorMessage;
                    }

                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: ThemeSpacing.halfMedium),
                ExpansionTile(
                  title: Text(l10n.accountScreen_advancedExpander_label),
                  children: [
                    const SizedBox(height: ThemeSpacing.halfMedium),
                    Row(
                      children: [
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return DropdownMenu<String>(
                                enabled: tokenTypeOptions.length > 1,
                                controller: _tokenTypeController,
                                initialSelection: tokenTypeOptions.first.value,
                                label: Text(
                                  l10n.accountScreen_tokeTypeSelector_label,
                                ),
                                width: constraints.maxWidth,
                                dropdownMenuEntries: tokenTypeOptions.map((
                                  option,
                                ) {
                                  return DropdownMenuEntry(
                                    value: option.value,
                                    label: option.label,
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: ThemeSpacing.small),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return DropdownMenu<String>(
                                enabled: algorithmOptions.length > 1,
                                controller: _algorithmController,
                                initialSelection: algorithmOptions.first.value,
                                label: Text(
                                  l10n.accountScreen_algorithmSelector_label,
                                ),
                                dropdownMenuEntries: algorithmOptions.map((
                                  option,
                                ) {
                                  return DropdownMenuEntry(
                                    value: option.value,
                                    label: option.label,
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: ThemeSpacing.halfMedium),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _intervalController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              labelText: l10n.accountScreen_intervalInput_label,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return l10n
                                    .accountScreen_intervalInput_emptyErrorMessage;
                              }

                              final parsed = int.tryParse(value);

                              if (parsed == null || parsed <= 0) {
                                return l10n
                                    .accountScreen_intervalInput_invalidErrorMessage;
                              }

                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        const SizedBox(width: ThemeSpacing.small),
                        Expanded(
                          child: TextFormField(
                            controller: _digitsController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              labelText: l10n.accountScreen_digitsInput_label,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: ThemeSpacing.medium),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSaving ? null : () => _saveAccount(context),
                    icon: _isSaving
                        ? const SizedBox(
                            width: ThemeSpacing.medium,
                            height: ThemeSpacing.medium,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : null,
                    label: Text(
                      widget.accountToEdit != null
                          ? l10n.accountScreen_editAccount_confirmButton_label
                          : l10n.accountScreen_addAccount_confirmButton_label,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
