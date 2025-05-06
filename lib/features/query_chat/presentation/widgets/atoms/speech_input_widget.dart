// lib/presentation/widgets/atoms/speech_input_widget.dart
// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechInputWidget extends StatefulWidget {
  final Function(String) onResult;

  const SpeechInputWidget({super.key, required this.onResult});

  @override
  _SpeechInputWidgetState createState() => _SpeechInputWidgetState();
}

class _SpeechInputWidgetState extends State<SpeechInputWidget> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _recognizedText = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    PermissionStatus status = await Permission.microphone.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No se concedió el permiso para utilizar el micrófono"),
        ),
      );
      return;
    }

    bool available = await _speech.initialize(
      onStatus: (status) => print('Estado: $status'),
      onError: (error) => print('Error: $error'),
    );

    if (!available) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("El reconocimiento de voz no está disponible")),
      );
    }
  }

  void _startListening() async {
    await _speech.listen(
      onResult: (result) {
        setState(() {
          _recognizedText = result.recognizedWords;
        });
        widget.onResult(_recognizedText);
      },
      listenFor: Duration(seconds: 10),
      pauseFor: Duration(seconds: 3),
    );
    setState(() {
      _isListening = true;
    });
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _recognizedText.isEmpty ? "Escuchando..." : _recognizedText,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            if (!_isListening) {
              _startListening();
            } else {
              _stopListening();
            }
          },
          child: Icon(_isListening ? Icons.mic : Icons.mic_none, size: 32),
        ),
      ],
    );
  }
}
