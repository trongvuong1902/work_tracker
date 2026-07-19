import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:work_tracker/di/injection.dart';
import 'package:work_tracker/features/zentao/domain/models/zentao_bug_attachment.dart';
import 'package:work_tracker/features/zentao/domain/zentao_repository.dart';

/// Full-screen viewer for a single Zentao bug attachment. Downloads (and
/// caches) the file via [ZentaoRepository.downloadAttachment], then renders an
/// image inline or plays a video via [Chewie]. Other file types fall back to a
/// "can't preview" message.
class AttachmentViewerPage extends StatefulWidget {
  const AttachmentViewerPage({super.key, required this.attachment});

  final ZentaoBugAttachment attachment;

  @override
  State<AttachmentViewerPage> createState() => _AttachmentViewerPageState();
}

class _AttachmentViewerPageState extends State<AttachmentViewerPage> {
  File? _file;
  String? _error;
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _download();
  }

  Future<void> _download() async {
    try {
      final file = await getIt<ZentaoRepository>().downloadAttachment(
        widget.attachment,
      );
      if (!mounted) return;
      if (widget.attachment.isVideo) {
        final controller = VideoPlayerController.file(file);
        await controller.initialize();
        if (!mounted) {
          await controller.dispose();
          return;
        }
        _videoController = controller;
        _chewieController = ChewieController(
          videoPlayerController: controller,
          autoPlay: true,
          looping: false,
        );
      }
      setState(() => _file = file);
    } catch (_) {
      if (mounted) setState(() => _error = "Couldn't load this attachment.");
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          widget.attachment.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Center(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          _error!,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70),
        ),
      );
    }

    final file = _file;
    if (file == null) {
      return const CircularProgressIndicator(color: Colors.white);
    }

    if (widget.attachment.isImage) {
      return InteractiveViewer(
        child: Image.file(file, fit: BoxFit.contain),
      );
    }

    if (widget.attachment.isVideo && _chewieController != null) {
      return AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: Chewie(controller: _chewieController!),
      );
    }

    return const Padding(
      padding: EdgeInsets.all(24),
      child: Text(
        "This file type can't be previewed in the app.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
