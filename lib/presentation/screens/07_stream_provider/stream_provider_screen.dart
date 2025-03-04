import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/stream_provider.dart';


class StreamProviderScreen extends StatelessWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: const StreamView(),
    );
  }
}

class StreamView extends ConsumerWidget {
  const StreamView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final usersInChat = ref.watch( userInChatProvider );

    if ( !usersInChat.hasValue ) {
      return const Center(child: CircularProgressIndicator());      
    }

    return ListView.builder(
      itemCount: usersInChat.value!.length,
      itemBuilder: (context, index) {
        final name = usersInChat.value![index];
        return ListTile(
          title: Text( name),
        );
      }
    );
  }
}