import 'dart:async' as async;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

/// Fondo de la [HomeScreen]: reproduce un MP4 local en loop mute si el
/// operador cargó uno desde Config → Kiosco. Si no hay video (o el
/// archivo no existe), cae al carrusel de imágenes por defecto.
///
/// Per Javier 2026-08-24: agregar video alternativo al carrusel de
/// imágenes (mismo patrón que en delibakery). El video se copia a
/// almacenamiento privado del app al elegirlo desde config; la key
/// `standby_video_path` en SharedPreferences guarda la ruta absoluta.
class StandbyBackground extends StatefulWidget {
  final List<String> carouselImages;
  final Duration slideEvery;

  const StandbyBackground({
    super.key,
    required this.carouselImages,
    this.slideEvery = const Duration(seconds: 4),
  });

  @override
  State<StandbyBackground> createState() => _StandbyBackgroundState();
}

class _StandbyBackgroundState extends State<StandbyBackground> {
  static const String _videoPathKey = 'standby_video_path';

  VideoPlayerController? _videoController;
  bool _videoReady = false;
  bool _videoAttempted = false;

  PageController? _pageController;
  async.Timer? _slideTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(_videoPathKey);
    _videoAttempted = true;
    if (path != null && path.isNotEmpty && File(path).existsSync()) {
      await _initVideo(path);
    } else {
      _initCarousel();
    }
    if (mounted) setState(() {});
  }

  Future<void> _initVideo(String path) async {
    try {
      final controller = VideoPlayerController.file(File(path));
      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0);
      await controller.play();
      _videoController = controller;
      _videoReady = true;
    } catch (_) {
      // Cualquier fallo (codec no soportado, archivo corrupto) cae al
      // carrusel para que el kiosco no quede en negro.
      _videoController?.dispose();
      _videoController = null;
      _videoReady = false;
      _initCarousel();
    }
  }

  void _initCarousel() {
    _pageController = PageController();
    _slideTimer = async.Timer.periodic(widget.slideEvery, (timer) {
      if (!mounted || _pageController == null) return;
      _currentPage = (_currentPage + 1) % widget.carouselImages.length;
      if (_pageController!.hasClients) {
        _pageController!.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _slideTimer?.cancel();
    _pageController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    if (!_videoAttempted) {
      // Mientras averiguamos si hay video, mostrar la primera imagen
      // para evitar flash en negro.
      return Image.asset(
        widget.carouselImages.first,
        fit: BoxFit.cover,
        width: screen.width,
        height: screen.height,
      );
    }
    if (_videoReady && _videoController != null) {
      return SizedBox(
        width: screen.width,
        height: screen.height,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _videoController!.value.size.width,
            height: _videoController!.value.size.height,
            child: VideoPlayer(_videoController!),
          ),
        ),
      );
    }
    return SizedBox(
      width: screen.width,
      height: screen.height,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.carouselImages.length,
        onPageChanged: (index) => _currentPage = index,
        itemBuilder: (context, index) {
          return Image.asset(
            widget.carouselImages[index],
            fit: BoxFit.cover,
            width: screen.width,
            height: screen.height,
          );
        },
      ),
    );
  }
}
