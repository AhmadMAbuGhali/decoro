void doNothing() {}

Future<void> wait(int ms) async =>
    await Future.delayed(Duration(milliseconds: ms));

T? safe<T>(T Function() run) {
  try {
    return run();
  } catch (_) {
    return null;
  }
}