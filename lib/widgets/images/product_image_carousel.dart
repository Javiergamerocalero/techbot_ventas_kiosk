import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/images/image_cache_provider.dart';
import 'package:ventas_kiosko/widgets/images/cached_product_image.dart';

/// Carrusel de imágenes para productos con rotación automática y controles manuales
class ProductImageCarousel extends ConsumerStatefulWidget {
  final Product product;
  final double height;
  final BorderRadius? borderRadius;

  const ProductImageCarousel({
    super.key,
    required this.product,
    required this.height,
    this.borderRadius,
  });

  @override
  ConsumerState<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends ConsumerState<ProductImageCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _autoScrollTimer;
  bool _userInteracting = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  /// Inicia el scroll automático cada 4 segundos (solo si hay múltiples imágenes)
  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    
    // Solo iniciar timer automático si hay múltiples imágenes
    final imageUrls = _getImageUrls();
    if (imageUrls.length <= 1) {
      return; // No hay necesidad de scroll automático con una sola imagen
    }
    
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!_userInteracting && mounted) {
        _nextImage();
      }
    });
  }

  /// Pausa el scroll automático temporalmente
  void _pauseAutoScroll() {
    _userInteracting = true;
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        _userInteracting = false;
      }
    });
  }

  /// Navega a la siguiente imagen
  void _nextImage() {
    if (!mounted) return;
    
    final imageUrls = _getImageUrls();
    if (imageUrls.isEmpty || imageUrls.length <= 1) return; // Protección para una sola imagen

    final nextIndex = (_currentIndex + 1) % imageUrls.length;
    _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Navega a la imagen anterior
  void _previousImage() {
    if (!mounted) return;
    
    final imageUrls = _getImageUrls();
    if (imageUrls.isEmpty || imageUrls.length <= 1) return; // Protección para una sola imagen

    final previousIndex = _currentIndex == 0 ? imageUrls.length - 1 : _currentIndex - 1;
    _pageController.animateToPage(
      previousIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Obtiene las URLs de todas las imágenes disponibles con URLs completas
  List<String> _getImageUrls() {
    final List<String> urls = [];
    
    // Agregar imágenes del array ordenadas por prioridad
    if (widget.product.images.isNotEmpty) {
      final sortedImages = widget.product.sortedImages;
      for (final imageData in sortedImages) {
        final partialUrl = imageData['url'] as String?;
        if (partialUrl != null && partialUrl.isNotEmpty) {
          urls.add(partialUrl); // Solo la URL parcial, se completará en el widget
        }
      }
    }
    
    // Si no hay imágenes en el array, usar thumbnail
    if (urls.isEmpty && widget.product.thumbnail.isNotEmpty) {
      urls.add(widget.product.thumbnail);
    }
    
    return urls;
  }

  /// Construye la URL completa para una imagen específica
  String? _buildFullImageUrl(String partialUrl, WidgetRef ref) {
    try {
      final baseUrl = ref.read(baseUrlProvider);
      
      if (partialUrl.startsWith('http')) {
        return partialUrl; // Ya es una URL completa
      }
      
      // Construir URL completa
      final cleanBaseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
      final cleanPartialUrl = partialUrl.startsWith('/') ? partialUrl.substring(1) : partialUrl;
      
      return '$cleanBaseUrl/$cleanPartialUrl';
    } catch (e) {
      print('Error construyendo URL: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final imageUrls = _getImageUrls();

    // Si no hay imágenes, mostrar placeholder
    if (imageUrls.isEmpty) {
      return Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: widget.borderRadius,
        ),
        child: Icon(
          Icons.fastfood_outlined,
          size: d.iconSizeL * 2,
          color: colorScheme.onSurface.withValues(alpha: 0.4),
        ),
      );
    }

    // Si solo hay una imagen, mostrar sin controles (imagen estática)
    if (imageUrls.length == 1) {
      return Container(
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white, // Fondo blanco para mejor contraste
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
          child: CachedProductImage(
            product: widget.product,
            height: widget.height,
            width: double.infinity,
            fit: BoxFit.contain, // Mostrar imagen completa sin recortar
          ),
        ),
      );
    }

    // Carrusel completo con múltiples imágenes
    return Stack(
      children: [
        // PageView con imágenes mejoradas
        Container(
          height: widget.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white, // Fondo blanco para mejor contraste
            borderRadius: widget.borderRadius ?? BorderRadius.zero,
          ),
          child: ClipRRect(
            borderRadius: widget.borderRadius ?? BorderRadius.zero,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                final imageUrls = _getImageUrls();
                final partialUrl = imageUrls[index];
                final fullUrl = _buildFullImageUrl(partialUrl, ref);
                
                if (fullUrl == null) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: d.iconSizeL,
                      color: colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  );
                }
                
                return CachedNetworkImage(
                  imageUrl: fullUrl,
                  width: double.infinity,
                  height: widget.height,
                  fit: BoxFit.contain, // Mostrar imagen completa sin recortar
                  placeholder: (context, url) => Container(
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.image_outlined,
                      size: d.iconSizeL,
                      color: colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: d.iconSizeL,
                      color: colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                  fadeInDuration: const Duration(milliseconds: 300),
                  fadeOutDuration: const Duration(milliseconds: 150),
                  memCacheWidth: (widget.height * 3).toInt(), // Resolución 3x
                  memCacheHeight: (widget.height * 3).toInt(),
                  filterQuality: FilterQuality.high,
                );
              },
            ),
          ),
        ),
        
        // Botón anterior (posicionado más abajo para evitar badges)
        Positioned(
          left: d.spacingM,
          top: widget.height / 2 + d.spacingXL * 2, // Más abajo para dar espacio a badges
          child: GestureDetector(
              onTap: () {
                _pauseAutoScroll();
                _previousImage();
              },
              child: Container(
                width: d.iconSizeL,
                height: d.iconSizeL,
                decoration: BoxDecoration(
                  color: colorScheme.surface.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.onSurface.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.chevron_left,
                  color: colorScheme.onSurface,
                  size: d.iconSizeM,
                ),
              ),
            ),
          ),
        
        // Botón siguiente (posicionado más abajo para evitar badges)
        Positioned(
          right: d.spacingM,
          top: widget.height / 2 + d.spacingXL * 2, // Más abajo para dar espacio a badges
          child: GestureDetector(
            onTap: () {
              _pauseAutoScroll();
              _nextImage();
            },
            child: Container(
              width: d.iconSizeL,
              height: d.iconSizeL,
              decoration: BoxDecoration(
                color: colorScheme.surface.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.onSurface.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.chevron_right,
                color: colorScheme.onSurface,
                size: d.iconSizeM,
              ),
            ),
          ),
        ),
        
        // Indicadores de página (más separados)
        if (imageUrls.length > 1)
          Positioned(
            bottom: d.spacingL,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageUrls.asMap().entries.map((entry) {
                return Container(
                  width: _currentIndex == entry.key ? d.spacingM : d.spacingS,
                  height: d.spacingS,
                  margin: EdgeInsets.symmetric(horizontal: d.spacingXS / 2),
                  decoration: BoxDecoration(
                    color: _currentIndex == entry.key
                        ? colorScheme.primary
                        : colorScheme.onSurface.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(d.spacingS / 2),
                  ),
                );
              }).toList(),
            ),
          ),
        
      ],
    );
  }
}
