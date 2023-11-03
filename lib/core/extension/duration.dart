extension Format on Duration {
  String format() => toString().split('.').first.padLeft(8, '0');
}
