// Flutter 平台通道（无原生实现时会收到友好的 PlatformException）
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PlatformChannelPage());
  }
}

class PlatformChannelPage extends StatefulWidget {
  const PlatformChannelPage({super.key});

  @override
  State<PlatformChannelPage> createState() => _PlatformChannelPageState();
}

class _PlatformChannelPageState extends State<PlatformChannelPage> {
  static const _channel = MethodChannel('com.example/native');
  String _message = 'Calling native…';

  @override
  void initState() {
    super.initState();
    _invoke();
  }

  Future<void> _invoke() async {
    try {
      final result = await _channel.invokeMethod<String>('getNativeData');
      setState(() => _message = 'Native said: $result');
    } on PlatformException catch (e) {
      setState(
        () => _message =
            'No native MethodChannel handler (expected in this demo): ${e.message}',
      );
    } catch (e) {
      setState(() => _message = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Platform channel')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SelectableText(_message),
      ),
    );
  }
}
