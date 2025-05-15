import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/upload_state.dart';

final uploadNotifierProvider = NotifierProvider<UploadNotifier, UploadState>(
  UploadNotifier.new,
);

class UploadNotifier extends Notifier<UploadState> {
  @override
  UploadState build() => const UploadState();

  Future<void> uploadAudio({
    required String fileName,
    required Uint8List bytes,
    required String fileExtension,
  }) async {
    state = state.copyWith(
      isUploading: true,
      progress: 0.0,
      error: null,
      fileName: fileName,
      fileSize: bytes.length,
      status: UploadStatus.uploading,
      bytes: bytes,
    );

    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('audios/$fileName');
      final uploadTask = storageRef.putData(
        bytes,
        SettableMetadata(contentType: 'audio/$fileExtension'),
      );

      uploadTask.snapshotEvents.listen((snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        state = state.copyWith(progress: progress);
      });

      await uploadTask;
      final url = await storageRef.getDownloadURL();

      state = state.copyWith(
        isUploading: false,
        progress: 1.0,
        downloadUrl: url,
        status: UploadStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        isUploading: false,
        error: e.toString(),
        status: UploadStatus.failure,
      );
    }
  }

  void reset() {
    state = const UploadState();
  }
}
