import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peregrino/core/extension/context.dart';
import 'package:peregrino/core/extension/duration.dart';
import 'package:peregrino/core/ui/image/image_placeholder.dart';
import 'package:peregrino/feature/home/model/audio_collection.dart';
import 'package:peregrino/feature/home/presentation/home_controller.dart';

part 'widgets/home_list_images.dart';
part 'widgets/home_list_tile.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);
    final controller = ref.watch(homeControllerProvider.notifier);

    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Peregrino'),
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout_rounded,
                color: context.colorScheme.primary,
              ),
              tooltip: 'Open shopping cart',
              onPressed: controller.logout,
            ),
          ],
        ),
        body: SafeArea(
          child: state.when(
            data: _DataWidget.new,
            error: (error, _) => const Column(
              children: [
                Icon(Icons.warning),
                Text('Algo errado ocorreu!'),
              ],
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}

class _DataWidget extends HookConsumerWidget {
  const _DataWidget(this._books);

  final List<AudioCollection> _books;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: TextField(
            controller: searchController,
            style: context.textTheme.labelSmall,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              prefixIconColor: context.colorScheme.primary,
            ),
            onChanged: (text) {
              ref
                  .read(homeControllerProvider.notifier)
                  .searchBy(searchText: text);
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _books.length,
            itemBuilder: (context, index) {
              final audioCollection = _books[index];
              return GestureDetector(
                onTap: () => ref
                    .read(homeControllerProvider.notifier)
                    .onTap(audioCollection: audioCollection),
                child: _ListTile(audioCollection: audioCollection),
              );
            },
          ),
        ),
      ],
    );
  }
}
