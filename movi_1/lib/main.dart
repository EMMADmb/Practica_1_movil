import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fade In Image Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fade In Image Demo'),
        ),
        body: Center(
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/loading.png', // imagen local para placeholder
            image: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', // imagen en red
            fadeInDuration: const Duration(seconds: 2),
            width: 300,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}