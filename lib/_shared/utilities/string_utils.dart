bool isBlank(String input) {
  return input.trim().isEmpty;
}

String capitalize(String input) {
  return input[0].toUpperCase() + input.substring(1);
}

String plural({required String text, required int value}) {
  if (value == 1) {
    return text;
  } else {
    return '$value ${text}s';
  }
}
