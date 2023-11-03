// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_player_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioPlayerControllerHash() =>
    r'848925cc3c29e3514e9f99dcfc8bfbc39f0eeae2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AudioPlayerController
    extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final int index;
  late final List<Audio> audios;

  FutureOr<void> build({
    required int index,
    required List<Audio> audios,
  });
}

/// See also [AudioPlayerController].
@ProviderFor(AudioPlayerController)
const audioPlayerControllerProvider = AudioPlayerControllerFamily();

/// See also [AudioPlayerController].
class AudioPlayerControllerFamily extends Family<AsyncValue<void>> {
  /// See also [AudioPlayerController].
  const AudioPlayerControllerFamily();

  /// See also [AudioPlayerController].
  AudioPlayerControllerProvider call({
    required int index,
    required List<Audio> audios,
  }) {
    return AudioPlayerControllerProvider(
      index: index,
      audios: audios,
    );
  }

  @override
  AudioPlayerControllerProvider getProviderOverride(
    covariant AudioPlayerControllerProvider provider,
  ) {
    return call(
      index: provider.index,
      audios: provider.audios,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'audioPlayerControllerProvider';
}

/// See also [AudioPlayerController].
class AudioPlayerControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AudioPlayerController, void> {
  /// See also [AudioPlayerController].
  AudioPlayerControllerProvider({
    required int index,
    required List<Audio> audios,
  }) : this._internal(
          () => AudioPlayerController()
            ..index = index
            ..audios = audios,
          from: audioPlayerControllerProvider,
          name: r'audioPlayerControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$audioPlayerControllerHash,
          dependencies: AudioPlayerControllerFamily._dependencies,
          allTransitiveDependencies:
              AudioPlayerControllerFamily._allTransitiveDependencies,
          index: index,
          audios: audios,
        );

  AudioPlayerControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.index,
    required this.audios,
  }) : super.internal();

  final int index;
  final List<Audio> audios;

  @override
  FutureOr<void> runNotifierBuild(
    covariant AudioPlayerController notifier,
  ) {
    return notifier.build(
      index: index,
      audios: audios,
    );
  }

  @override
  Override overrideWith(AudioPlayerController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AudioPlayerControllerProvider._internal(
        () => create()
          ..index = index
          ..audios = audios,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        index: index,
        audios: audios,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AudioPlayerController, void>
      createElement() {
    return _AudioPlayerControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AudioPlayerControllerProvider &&
        other.index == index &&
        other.audios == audios;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);
    hash = _SystemHash.combine(hash, audios.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AudioPlayerControllerRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `index` of this provider.
  int get index;

  /// The parameter `audios` of this provider.
  List<Audio> get audios;
}

class _AudioPlayerControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AudioPlayerController, void>
    with AudioPlayerControllerRef {
  _AudioPlayerControllerProviderElement(super.provider);

  @override
  int get index => (origin as AudioPlayerControllerProvider).index;
  @override
  List<Audio> get audios => (origin as AudioPlayerControllerProvider).audios;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
