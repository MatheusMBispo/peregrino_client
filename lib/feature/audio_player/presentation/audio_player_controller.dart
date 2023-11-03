import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:peregrino/core/logger/loggy_types.dart';
import 'package:peregrino/feature/playlist/model/audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_player_controller.g.dart';

enum AudioPlayerStatus { play, pause }

@riverpod
class AudioPlayerController extends _$AudioPlayerController
    with ControllerLoggy {
  final _player = AudioPlayer();
  AudioPlayerStatus _currentStatus = AudioPlayerStatus.play;
  Duration currentDuration = Duration.zero;
  int _currentIndex = 0;
  List<Audio> _audios = [];

  @override
  Future<void> build({
    required int index,
    required List<Audio> audios,
  }) async {
    _currentIndex = index;
    _audios = audios;

    _player.positionStream.listen((position) {
      currentDuration = position;
      _notify();
    });

    await _loadUrl();
  }

  Duration totalDuration() {
    return _player.duration ?? Duration.zero;
  }

  void seek(Duration duration) {
    _player.seek(duration);
  }

  Future<void> _loadUrl() async {
    final url = getCurrentDetail()?.audioUrl;
    if (url == null) {
      return;
    }

    await _player.setUrl(url);
  }

  Future<void> toggle() async {
    switch (_currentStatus) {
      case AudioPlayerStatus.play:
        await play();
        break;
      case AudioPlayerStatus.pause:
        await pause();
        break;
    }
  }

  Future<void> pause() async {
    _currentStatus = AudioPlayerStatus.play;
    _notify();
    await _player.pause();
  }

  Future<void> play() async {
    _currentStatus = AudioPlayerStatus.pause;
    _notify();
    await _player.play();
  }

  Future<void> stop() async {
    _currentStatus = AudioPlayerStatus.play;
    _notify();
    await _player.stop();
  }

  IconData currentIcon() {
    switch (_currentStatus) {
      case AudioPlayerStatus.play:
        return Icons.play_arrow_rounded;
      case AudioPlayerStatus.pause:
        return Icons.pause;
    }
  }

  Audio? getCurrentDetail() {
    return _audios.elementAtOrNull(_currentIndex);
  }

  Future<void> goNext() async {
    if (_currentIndex >= _audios.length - 1) {
      return;
    }

    final lastState = _currentStatus;
    await pause();
    _currentIndex++;
    await _loadUrl();
    if (lastState == AudioPlayerStatus.pause) {
      await play();
    }
    _notify();
  }

  Future<void> goPrevious() async {
    if (_currentIndex <= 0) {
      return;
    }

    final lastState = _currentStatus;
    await pause();
    _currentIndex--;
    await _loadUrl();
    if (lastState == AudioPlayerStatus.pause) {
      await play();
    }

    _notify();
  }

  void _notify() {
    state = const AsyncValue.data(null);
  }
}
