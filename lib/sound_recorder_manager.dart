import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'sound_recorder.dart';

class SoundRecorderManager extends StatefulWidget {
  @override
  _SoundRecorderManagerState createState() => _SoundRecorderManagerState();
}

class _SoundRecorderManagerState extends State<SoundRecorderManager> {
  late RecorderController _recorderController;
  late PlayerController _playerController;
  bool _isRecording = false;
  String? _audioPath;
  List<FlSpot> _frequencyData = [];
  late StreamSubscription<double> _frequencySubscription;

  @override
  void initState() {
    super.initState();
    _recorderController = RecorderController();
    _playerController = PlayerController();
    _recorderController.checkPermission();
    _listenToFrequencyChanges();
  }
  
  void _listenToFrequencyChanges() {
    _frequencySubscription = SoundRecorder().frequencyStream.listen((frequency) {
      setState(() {
        _frequencyData.add(FlSpot(_frequencyData.length.toDouble(), frequency));
        if (_frequencyData.length > 30) {
          _frequencyData.removeAt(0); // Mantener solo los últimos 30 puntos
        }
      });
    });
  }


  Future<void> _startRecording() async {
    if (_recorderController.hasPermission) {
      await _recorderController.record();
      setState(() => _isRecording = true);
    }
  }

  Future<void> _stopRecording() async {
    String? path = await _recorderController.stop();
    setState(() {
      _isRecording = false;
      _audioPath = path;
    });

    if (_audioPath != null) {
      print('Grabación guardada en: $_audioPath');
      await _prepareWaveform();
    }
  }

  Future<void> _prepareWaveform() async {
    if (_audioPath == null) return;
    await _playerController.preparePlayer(
      path: _audioPath!,
      shouldExtractWaveform: true,
    );
    setState(() {});
  }

  Future<void> _playRecording() async {
    if (_audioPath == null) return;
    await _playerController.startPlayer();
  }

  @override
  void dispose() {
    _recorderController.dispose();
    _playerController.dispose();
    _frequencySubscription.cancel();
    super.dispose();
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
            onPressed: _audioPath != null ? _playRecording : null,
            child: Text('Reproducir Grabación'),
          ),
          SizedBox(height: 20),

          AudioWaveforms(
            recorderController: _recorderController,
            size: Size(MediaQuery.of(context).size.width, 50),
            waveStyle: WaveStyle(
              waveColor: Colors.blue,
              spacing: 6.0,
            ),
          ),
          SizedBox(height: 20),

          if (_audioPath != null) _buildWaveform(),
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

  Widget _buildWaveform() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AudioFileWaveforms(
        size: Size(MediaQuery.of(context).size.width, 100),
        playerController: _playerController,
        waveformType: WaveformType.long,
        enableSeekGesture: true,
        playerWaveStyle: PlayerWaveStyle(
          fixedWaveColor: Colors.blue.withOpacity(0.5),
          liveWaveColor: Colors.blue,
          spacing: 8.0,
          waveThickness: 2.0,
        ),
      ),
    );
  }
}
