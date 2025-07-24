import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const KillApp());

class KillApp extends StatelessWidget {
  const KillApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: ElevatedButton(
            autofocus: true,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 120),
              textStyle: const TextStyle(fontSize: 32),
            ),
            onPressed: _kill,
            child: const Text('Nettoyer'),
          ),
        ),
      ),
    );
  }

  Future<void> _kill() async {
    final res = await Process.run('pm', ['list', 'packages', '-3']);
    for (final line in LineSplitter.split(res.stdout as String)) {
      final pkg = line.replaceFirst('package:', '').trim();
      if (pkg.isNotEmpty) Process.run('am', ['force-stop', pkg]);
    }
    SystemNavigator.pop();
  }
}
