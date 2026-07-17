import 'package:flutter_test/flutter_test.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  test('probe workmanager call without platform setup', () async {
    try {
      await Workmanager().cancelByUniqueName('foo');
      print('no exception');
    } catch (e) {
      print('EXCEPTION: ${e.runtimeType}: $e');
    }
  });
}
