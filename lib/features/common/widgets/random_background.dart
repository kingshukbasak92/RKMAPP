import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

class RandomBackground extends StatefulWidget {
  final double opacity;
  // If provided, uses this image path directly (must be in assets).
  final String? fixedImageAsset;
  const RandomBackground({super.key, this.opacity = 0.25, this.fixedImageAsset});

  @override
  State<RandomBackground> createState() => _RandomBackgroundState();
}

class _RandomBackgroundState extends State<RandomBackground> {
  static List<String>? _cachedImages;
  String? _selected;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ensure we only load once per widget lifecycle
    if (!_loaded) {
      _loaded = true;
      _pick();
    }
  }

  Future<void> _pick() async {
    // If a fixed asset is provided, use it after validating in the manifest
    if (widget.fixedImageAsset != null && widget.fixedImageAsset!.isNotEmpty) {
      try {
        final manifestRaw = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
        final Map<String, dynamic> manifest = json.decode(manifestRaw) as Map<String, dynamic>;
        if (manifest.containsKey(widget.fixedImageAsset)) {
          _selected = widget.fixedImageAsset;
          if (mounted) setState(() {});
          return;
        } else {
          debugPrint('[RandomBackground] Fixed asset not found in manifest: ${widget.fixedImageAsset}');
        }
      } catch (e) {
        debugPrint('[RandomBackground] Error validating fixed asset: $e');
      }
    }
    try {
      if (_cachedImages == null) {
        final manifestRaw = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
        final Map<String, dynamic> manifest = json.decode(manifestRaw) as Map<String, dynamic>;
        final allAssets = manifest.keys.toList();
        _cachedImages = allAssets
            .where((p) => p.startsWith('assets/images/screen_background/') &&
                (p.endsWith('.png') || p.endsWith('.jpg') || p.endsWith('.jpeg') || p.endsWith('.webp')))
            .toList();
        
        // Fallback: if screen_background is empty, use images from assets/images/
        if (_cachedImages!.isEmpty) {
          _cachedImages = allAssets
              .where((p) => p.startsWith('assets/images/') && 
                  !p.contains('screen_background') && 
                  !p.contains('icons') &&
                  (p.endsWith('.png') || p.endsWith('.jpg') || p.endsWith('.jpeg') || p.endsWith('.webp')))
              .toList();
          debugPrint('[RandomBackground] Using fallback images from assets/images/');
        }
        
        debugPrint('[RandomBackground] Discovered ${_cachedImages!.length} background images.');
      }

      if (_cachedImages != null && _cachedImages!.isNotEmpty) {
        final rnd = Random();
        _selected = _cachedImages![rnd.nextInt(_cachedImages!.length)];
        debugPrint('[RandomBackground] Selected background: $_selected');
      } else {
        debugPrint('[RandomBackground] No images found under assets/images/screen_background/.');
      }
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('[RandomBackground] Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_selected == null) return const SizedBox.shrink();
    return Opacity(
      opacity: widget.opacity,
      child: Image.asset(
        _selected!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
