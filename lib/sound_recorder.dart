import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

class SoundRecorder {
  final audioRecord = AudioRecorder();
  final player = AudioPlayer();
  bool _isRecording = false;
  bool _isPlayingAudio = false;
  String? _audioPath;
  StreamController<double> _frequencyStreamController = StreamController<double>.broadcast();

  /// Getter para obtener la frecuencia en tiempo real
  Stream<double> get frequencyStream => _frequencyStreamController.stream;

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String filePath = '${appDocDir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.wav';
        _isRecording = true;
        await audioRecord.start(
          const RecordConfig(
            encoder: AudioEncoder.wav,
            sampleRate: 24000,
            numChannels: 1,
          ),
          path: filePath,
        );
      } else {
        throw Exception('No tienes permisos para grabar audio.');
      }
    } catch (e) {
      debugPrint('Error al iniciar la grabación: $e');
    }
  }

  Future<String?> stopRecording() async {
    try {
      if (_isRecording) {
        _audioPath = await audioRecord.stop();
        _isRecording = false;
        return _audioPath;
      }
      return null;
    } catch (e) {
      debugPrint('Error al detener la grabación: $e');
      return null;
    }
  }

  /// Reproduce la grabación y emite la frecuencia en tiempo real
  Future<void> playRecording() async {
    if (_audioPath != null) {
      _isPlayingAudio = true;
      await player.play(DeviceFileSource(_audioPath!));

      // Simula frecuencias mientras el audio se reproduce
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (!_isPlayingAudio) {
          timer.cancel();
        } else {
          double simulatedFrequency = _generateSimulatedFrequency();
          _frequencyStreamController.add(simulatedFrequency);
        }
      });

      player.onPlayerComplete.listen((event) {
        _isPlayingAudio = false;
      });
    } else {
      debugPrint('No hay grabación disponible.');
    }
  }

  double _generateSimulatedFrequency() {
    return 80 + Random().nextDouble() * 600; // Frecuencia simulada entre 80Hz y 680Hz
  }

  void reset() {
    _audioPath = null;
    _isRecording = false;
    _frequencyStreamController.close();
  }

  String? get audioPath => _audioPath;
}
