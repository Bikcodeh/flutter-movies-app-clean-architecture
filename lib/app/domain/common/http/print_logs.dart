part of 'network.dart';

void printLogs(Map<String, dynamic> logs, StackTrace? stackTrace) {
  if (kDebugMode) {
    log(
      '''
🔥------------------------------------------------------
    ${const JsonEncoder.withIndent(' ').convert(logs)}
🔥------------------------------------------------------
''',
      stackTrace: stackTrace,
    );
  }
}
