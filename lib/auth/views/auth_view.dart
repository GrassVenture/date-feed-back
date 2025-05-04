import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/auth_provider.dart';

class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final auth = ref.read(authProvider.notifier);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (authState.isLoading)
              const CircularProgressIndicator()
            else if (authState.user == null)
              ElevatedButton.icon(
                onPressed: () => auth.signInWithGoogle(),
                icon: const Icon(Icons.login),
                label: const Text('Googleでログイン'),
              )
            else
              Column(
                children: [
                  Text('ようこそ、${authState.user!.displayName}さん'),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => auth.signOut(),
                    icon: const Icon(Icons.logout),
                    label: const Text('ログアウト'),
                  ),
                ],
              ),
            if (authState.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  authState.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
} 