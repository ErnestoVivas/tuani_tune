import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'sound_recorder.dart';

class SoundRecorderManager extends StatefulWidget {
  @override
  _SoundRecorderManagerState createState() => _SoundRecorderManagerState();
}

class _SoundRecorderManagerState extends State<SoundRecorderManager> {
  late SoundRecorder _soundRecorder;
  bool _isRecording = false;
  List<FlSpot> _frequencyData = [];
  late StreamSubscription<double> _frequencySubscription;

  @override
  void initState() {
    super.initState();
    _soundRecorder = SoundRecorder();
    _listenToFrequencyChanges();
  }

  /// Escucha los cambios en la frecuencia y actualiza la gráfica
  void _listenToFrequencyChanges() {
    _frequencySubscription = _soundRecorder.frequencyStream.listen((frequency) {
      setState(() {
        _frequencyData.add(FlSpot(_frequencyData.length.toDouble(), frequency));
        if (_frequencyData.length > 30) {
          _frequencyData.removeAt(0); // Mantener solo los últimos 30 puntos
        }
      });
    });
  }

  Future<void> _startRecording() async {
    await _soundRecorder.startRecording();
    setState(() => _isRecording = true);
  }

  Future<void> _stopRecording() async {
    String? path = await _soundRecorder.stopRecording();
    setState(() => _isRecording = false);
    if (path != null) {
      print('Grabación guardada en: $path');
    }
  }

  Future<void> _playRecording() async {
    await _soundRecorder.playRecording();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grabar y Reproducir Audio')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          _buildFrequencyGraph(),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isRecording ? _stopRecording : _startRecording,
            child: Text(_isRecording ? 'Detener Grabación' : 'Iniciar Grabación'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _soundRecorder.audioPath != null ? _playRecording : null,
            child: Text('Reproducir Grabación'),
          ),
        ],
      ),
    );
  }

  Widget _buildFrequencyGraph() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: _frequencyData,
                isCurved: true,
                color: Colors.blue,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _soundRecorder.reset();
    _frequencySubscription.cancel();
    super.dispose();
  }
}