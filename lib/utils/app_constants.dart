enum TokenType {
  totp;

  String get value => name;
  String get label => name.toUpperCase();
}

class SelectOption<T> {
  final T value;
  final String label;

  SelectOption({required this.value, required this.label});
}

class AppConstants {
  static final String title = 'Arculus';

  static final List<SelectOption<String>> tokenTypeOptions = [
    SelectOption(value: TokenType.totp.value, label: TokenType.totp.label),
  ];
}
