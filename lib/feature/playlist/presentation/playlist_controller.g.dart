// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playlistControllerHash() =>
    r'313dff8de724cbe1479a5ddbca793ac8b7dfc358';

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

abstract class _$PlaylistController
    extends BuildlessAutoDisposeAsyncNotifier<List<Audio>> {
  late final AudioCollection audioCollection;

  FutureOr<List<Audio>> build({
    required AudioCollection audioCollection,
  });
}

/// See also [PlaylistController].
@ProviderFor(PlaylistController)
const playlistControllerProvider = PlaylistControllerFamily();

/// See also [PlaylistController].
class PlaylistControllerFamily extends Family<AsyncValue<List<Audio>>> {
  /// See also [PlaylistController].
  const PlaylistControllerFamily();

  /// See also [PlaylistController].
  PlaylistControllerProvider call({
    required AudioCollection audioCollection,
  }) {
    return PlaylistControllerProvider(
      audioCollection: audioCollection,
    );
  }

  @override
  PlaylistControllerProvider getProviderOverride(
    covariant PlaylistControllerProvider provider,
  ) {
    return call(
      audioCollection: provider.audioCollection,
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
  String? get name => r'playlistControllerProvider';
}

/// See also [PlaylistController].
class PlaylistControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    PlaylistController, List<Audio>> {
  /// See also [PlaylistController].
  PlaylistControllerProvider({
    required AudioCollection audioCollection,
  }) : this._internal(
          () => PlaylistController()..audioCollection = audioCollection,
          from: playlistControllerProvider,
          name: r'playlistControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playlistControllerHash,
          dependencies: PlaylistControllerFamily._dependencies,
          allTransitiveDependencies:
              PlaylistControllerFamily._allTransitiveDependencies,
          audioCollection: audioCollection,
        );

  PlaylistControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.audioCollection,
  }) : super.internal();

  final AudioCollection audioCollection;

  @override
  FutureOr<List<Audio>> runNotifierBuild(
    covariant PlaylistController notifier,
  ) {
    return notifier.build(
      audioCollection: audioCollection,
    );
  }

  @override
  Override overrideWith(PlaylistController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlaylistControllerProvider._internal(
        () => create()..audioCollection = audioCollection,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        audioCollection: audioCollection,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PlaylistController, List<Audio>>
      createElement() {
    return _PlaylistControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlaylistControllerProvider &&
        other.audioCollection == audioCollection;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, audioCollection.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlaylistControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<Audio>> {
  /// The parameter `audioCollection` of this provider.
  AudioCollection get audioCollection;
}

class _PlaylistControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PlaylistController,
        List<Audio>> with PlaylistControllerRef {
  _PlaylistControllerProviderElement(super.provider);

  @override
  AudioCollection get audioCollection =>
      (origin as PlaylistControllerProvider).audioCollection;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
