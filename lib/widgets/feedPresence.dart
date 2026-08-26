import 'package:flutter/material.dart';
import '../models/presence.dart';
import '../screens/presenceSc.dart';

class FeedFootprintCard extends StatelessWidget {
  final Footprint footprint;
  final int variant;

  const FeedFootprintCard({
    super.key,
    required this.footprint,
    this.variant = 0,
  });

  int get _likeCount =>
      12 + footprint.photoCount * 7 + footprint.videoCount * 3;

  int get _commentCount => footprint.companions.length + footprint.audioCount + 2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FootprintDetail(footprint: footprint),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: CustomPaint(
          painter: _OrganicBorderPainter(variant: variant),
          child: ClipPath(
            clipper: OrganicCardClipper(variant: variant),
            child: Container(
              color: const Color(0xFFFFFDF8),
              padding: const EdgeInsets.fromLTRB(22, 22, 16, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildDetails()),
                  const SizedBox(width: 8),
                  _buildPhoto(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xFFE4EBDD),
              backgroundImage: footprint.userProfileImage != null
                  ? NetworkImage(footprint.userProfileImage!)
                  : null,
              child: footprint.userProfileImage == null
                  ? Text(
                      footprint.userName.isNotEmpty
                          ? footprint.userName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        color: Color(0xFF3D5A40),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    footprint.userName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2F3E3A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '📍 ${footprint.time} • ${footprint.place}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF6B7C74),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.more_vert, size: 18, color: Color(0xFF8A9A92)),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          footprint.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13.5,
            height: 1.35,
            color: Color(0xFF3A4742),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const Icon(Icons.favorite, size: 16, color: Color(0xFFE05A5A)),
            const SizedBox(width: 4),
            Text(
              '$_likeCount',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A5B54),
              ),
            ),
            const SizedBox(width: 14),
            const Icon(
              Icons.chat_bubble_outline,
              size: 15,
              color: Color(0xFF6B7C74),
            ),
            const SizedBox(width: 4),
            Text(
              '$_commentCount',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A5B54),
              ),
            ),
            const SizedBox(width: 14),
            const Icon(
              Icons.location_on_outlined,
              size: 16,
              color: Color(0xFF3D5A40),
            ),
            const SizedBox(width: 2),
            Flexible(
              child: Text(
                footprint.place.split(',').first,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A5B54),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhoto() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: ClipPath(
        clipper: OrganicPhotoClipper(variant: variant),
        child: SizedBox(
          width: 108,
          height: 108,
          child: Image.network(
            footprint.image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFFE4EBDD),
                child: const Icon(
                  Icons.landscape_rounded,
                  color: Color(0xFF6B7C74),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class OrganicCardClipper extends CustomClipper<Path> {
  final int variant;

  OrganicCardClipper({this.variant = 0});

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();

    if (variant.isEven) {
      path.moveTo(w * 0.07, h * 0.16);
      path.cubicTo(w * 0.01, h * 0.04, w * 0.16, 0, w * 0.34, h * 0.03);
      path.cubicTo(w * 0.58, h * 0.07, w * 0.8, 0, w * 0.93, h * 0.1);
      path.cubicTo(w * 1.04, h * 0.22, w * 0.99, h * 0.48, w * 0.97, h * 0.66);
      path.cubicTo(w * 0.95, h * 0.86, w * 1.01, h * 0.98, w * 0.84, h * 0.97);
      path.cubicTo(w * 0.58, h * 0.96, w * 0.3, h * 1.0, w * 0.1, h * 0.9);
      path.cubicTo(-0.03, h * 0.76, w * 0.0, h * 0.38, w * 0.07, h * 0.16);
    } else {
      path.moveTo(w * 0.09, h * 0.1);
      path.cubicTo(w * 0.04, 0, w * 0.22, h * 0.02, w * 0.4, h * 0.01);
      path.cubicTo(w * 0.66, 0, w * 0.86, h * 0.05, w * 0.95, h * 0.16);
      path.cubicTo(w * 1.05, h * 0.3, w * 0.98, h * 0.55, w * 0.96, h * 0.72);
      path.cubicTo(w * 0.94, h * 0.9, w * 0.98, h * 1.02, w * 0.78, h * 0.98);
      path.cubicTo(w * 0.52, h * 0.93, w * 0.26, h * 1.0, w * 0.08, h * 0.86);
      path.cubicTo(-0.04, h * 0.7, w * 0.02, h * 0.28, w * 0.09, h * 0.1);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant OrganicCardClipper oldClipper) {
    return oldClipper.variant != variant;
  }
}

class OrganicPhotoClipper extends CustomClipper<Path> {
  final int variant;

  OrganicPhotoClipper({this.variant = 0});

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();

    if (variant.isEven) {
      path.moveTo(w * 0.28, h * 0.06);
      path.cubicTo(w * 0.48, -0.04, w * 0.78, h * 0.02, w * 0.92, h * 0.2);
      path.cubicTo(w * 1.08, h * 0.4, w * 0.98, h * 0.72, w * 0.82, h * 0.9);
      path.cubicTo(w * 0.64, h * 1.08, w * 0.28, h * 0.98, w * 0.12, h * 0.78);
      path.cubicTo(-0.06, h * 0.52, w * 0.04, h * 0.18, w * 0.28, h * 0.06);
    } else {
      path.moveTo(w * 0.2, h * 0.14);
      path.cubicTo(w * 0.36, -0.02, w * 0.72, 0, w * 0.9, h * 0.18);
      path.cubicTo(w * 1.1, h * 0.38, w * 1.02, h * 0.7, w * 0.86, h * 0.88);
      path.cubicTo(w * 0.66, h * 1.08, w * 0.3, h * 1.0, w * 0.14, h * 0.76);
      path.cubicTo(-0.04, h * 0.5, 0, h * 0.28, w * 0.2, h * 0.14);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant OrganicPhotoClipper oldClipper) {
    return oldClipper.variant != variant;
  }
}

class _OrganicBorderPainter extends CustomPainter {
  final int variant;

  _OrganicBorderPainter({required this.variant});

  @override
  void paint(Canvas canvas, Size size) {
    final path = OrganicCardClipper(variant: variant).getClip(size);
    final fill = Paint()
      ..color = const Color(0xFFFFFDF8)
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = const Color(0xFFD7DDD4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    canvas.drawShadow(path, Colors.black.withValues(alpha: 0.08), 8, false);
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant _OrganicBorderPainter oldDelegate) {
    return oldDelegate.variant != variant;
  }
}
