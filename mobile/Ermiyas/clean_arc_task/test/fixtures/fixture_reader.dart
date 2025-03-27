import 'dart:io';

Future<String> fixture(String name) async =>
    await File('test/fixtures/$name').readAsString();
