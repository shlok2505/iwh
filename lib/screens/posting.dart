import 'package:flutter/material.dart';
import 'package:iwh/data/footprint.dart';
import 'package:iwh/data/user.dart';
import 'package:iwh/models/presence.dart';

class PostingScreen extends StatefulWidget {
  const PostingScreen({super.key});

  @override
  State<PostingScreen> createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {
  final _experienceController = TextEditingController();
  String _placeName = 'Marine Drive, Mumbai';
  final double _latitude = 18.9431;
  final double _longitude = 72.8236;

  String _imageUrl =
      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1200&q=80';

  String _selectedMood = 'Happy';
  String _visibility = 'Only Me'; // 'Only Me', 'Friends', 'Everyone'

  final List<Map<String, String>> _moods = [
    {'label': 'Happy', 'emoji': '😃'},
    {'label': 'Calm', 'emoji': '😌'},
    {'label': 'Amazing', 'emoji': '🤩'},
    {'label': 'Nostalgic', 'emoji': '🥺'},
    {'label': 'Peaceful', 'emoji': '🌿'},
    {'label': 'Adventurous', 'emoji': '🎒'},
  ];

  @override
  void dispose() {
    _experienceController.dispose();
    super.dispose();
  }

  String get _currentDateFormatted {
    final now = DateTime.now();
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }

  String get _currentTimeFormatted {
    final time = TimeOfDay.now();
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  void _submit({required bool isFootprint}) {
    final desc = _experienceController.text.trim().isEmpty
        ? 'Exploring and soaking in the beauty of $_placeName.'
        : _experienceController.text.trim();

    final isPersonalMemory = _visibility == 'Only Me' && !isFootprint;
    final isPublicPresence = isFootprint ? true : (_visibility != 'Only Me');

    final newPresence = Presence(
      id: 'fp${DateTime.now().millisecondsSinceEpoch}',
      place: _placeName,
      date: _currentDateFormatted,
      time: _currentTimeFormatted,
      image: _imageUrl,
      isPublic: isPublicPresence,
      photoCount: 4,
      videoCount: 1,
      audioCount: 0,
      description: desc,
      companions: [],
      highlights: [_selectedMood, _placeName.split(',').first.trim()],
      audioNote: null,
      notes: isPersonalMemory ? 'Saved to personal journey memory.' : '',
      latitude: _latitude,
      longitude: _longitude,
      userName: currentUser.name,
      userProfileImage: currentUser.avatarUrl,
      isFriend: true,
      isMemory: isPersonalMemory,
      mood: _selectedMood,
      isLocationLocked: isFootprint,
    );

    footprints.insert(0, newPresence);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            isFootprint ? const Color(0xFF6E3911) : const Color(0xFF234933),
        content: Text(
          isFootprint
              ? '👣 Left as a Footprint at $_placeName! Others at this place can discover it.'
              : '💚 Saved as Presence! Added to your journey and visible anywhere.',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );

    Navigator.pop(context);
  }

  void _showChangeLocationDialog() {
    final controller = TextEditingController(text: _placeName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFFBF8F2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Change Location',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF223B2F)),
        ),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter place name',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(Icons.location_on, color: Color(0xFF2F4D3D)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFDDD5C7)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F4D3D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  _placeName = controller.text.trim();
                });
              }
              Navigator.pop(ctx);
            },
            child: const Text('Update', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showVisibilityModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFFAF6F0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Who can see this?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF223B2F),
              ),
            ),
            const SizedBox(height: 16),
            _visibilityTile(
              title: 'Only Me',
              subtitle: 'Presence is personal and private.',
              icon: Icons.lock_outline,
            ),
            _visibilityTile(
              title: 'Friends',
              subtitle: 'Visible to friends on their feed.',
              icon: Icons.people_outline,
            ),
            _visibilityTile(
              title: 'Everyone',
              subtitle: 'Public presence visible to all travelers.',
              icon: Icons.public,
            ),
          ],
        ),
      ),
    );
  }

  Widget _visibilityTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = _visibility == title;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDCEBDE) : const Color(0xFFEEEAE0),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF284D3A), size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          color: const Color(0xFF223B2F),
        ),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Color(0xFF2F4D3D))
          : null,
      onTap: () {
        setState(() => _visibility = title);
        Navigator.pop(context);
      },
    );
  }

  void _showEditPhotoDialog() {
    final controller = TextEditingController(text: _imageUrl);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFFBF8F2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Photo URL',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF223B2F)),
        ),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Paste image web URL',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F4D3D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  _imageUrl = controller.text.trim();
                });
              }
              Navigator.pop(ctx);
            },
            child: const Text('Set Photo', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- TOP BAR ----------------
              _buildTopBar(),
              const SizedBox(height: 18),

              // ---------------- PHOTO SHOWCASE ----------------
              _buildPhotoShowcase(),
              const SizedBox(height: 12),

              // ---------------- ADD MORE BUTTON ----------------
              _buildAddMoreTile(),
              const SizedBox(height: 16),

              // ---------------- EXPERIENCE CARD ----------------
              _buildExperienceCard(),
              const SizedBox(height: 14),

              // ---------------- LOCATION CARD ----------------
              _buildLocationCard(),
              const SizedBox(height: 14),

              // ---------------- MOOD / FEELINGS CARD ----------------
              _buildMoodCard(),
              const SizedBox(height: 14),

              // ---------------- VISIBILITY CARD ----------------
              _buildVisibilityCard(),
              const SizedBox(height: 22),

              // ---------------- SECTION DIVIDER ----------------
              _buildSectionDivider(),
              const SizedBox(height: 16),

              // ---------------- DUAL ACTION CARDS ----------------
              _buildDualActionCards(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CLOSE BUTTON
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE8E2D6)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.close, color: Color(0xFF223B2F), size: 20),
          ),
        ),
        const SizedBox(width: 10),

        // CENTER TITLE + SUBTITLE
        Expanded(
          child: Column(
            children: [
              const Text(
                'Share Your Moment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'serif',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                  color: Color(0xFF1E3A2D),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Capture the moment and choose\nhow you want to leave it behind.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.3,
                  color: Color(0xFF6B7C74),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),

        // DRAFTS BUTTON
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No saved drafts')),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE5DFD4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.article_outlined,
                  size: 16,
                  color: Color(0xFF2F3E3A),
                ),
                SizedBox(width: 6),
                Text(
                  'Drafts',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2F3E3A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoShowcase() {
    return Container(
      height: 225,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // IMAGE
            Image.network(
              _imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFF7A8B7E),
                child: const Center(
                  child: Icon(Icons.landscape, size: 60, color: Colors.white70),
                ),
              ),
            ),

            // TOP-LEFT EDIT PHOTO PILL
            Positioned(
              top: 12,
              left: 12,
              child: GestureDetector(
                onTap: _showEditPhotoDialog,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 15,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Edit Photo',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // TOP-RIGHT CLOSE/REMOVE BUTTON
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _imageUrl =
                        'https://images.unsplash.com/photo-1570168007204-dfb528c6958f?auto=format&fit=crop&w=1200&q=80';
                  });
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),

            // BOTTOM-RIGHT CAROUSEL DOTS
            Positioned(
              bottom: 14,
              right: 16,
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.55),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.55),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.55),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMoreTile() {
    return GestureDetector(
      onTap: _showEditPhotoDialog,
      child: CustomPaint(
        painter: _DashedRRectPainter(
          color: const Color(0xFFBAC5BC),
          borderRadius: 16,
        ),
        child: Container(
          width: 78,
          height: 78,
          alignment: Alignment.center,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Color(0xFF4A6054), size: 24),
              SizedBox(height: 2),
              Text(
                'Add More',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A6054),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEBE4D8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // QUOTE BADGE
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Color(0xFFE3EDE5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.format_quote_rounded,
              color: Color(0xFF284D3A),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // TEXT INPUT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _experienceController,
                  maxLines: 3,
                  maxLength: 500,
                  buildCounter: (
                    _, {
                    required int currentLength,
                    required bool isFocused,
                    required int? maxLength,
                  }) =>
                      Text(
                    '$currentLength/$maxLength',
                    style: const TextStyle(fontSize: 11, color: Color(0xFF9AA7A0)),
                  ),
                  style: const TextStyle(
                    fontSize: 14.5,
                    color: Color(0xFF223B2F),
                    height: 1.35,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Share your experience...',
                    hintStyle: TextStyle(
                      fontSize: 14.5,
                      color: Color(0xFF8A9A92),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
    return GestureDetector(
      onTap: _showChangeLocationDialog,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFEBE4D8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xFFE3EDE5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_on,
                color: Color(0xFF284D3A),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Where are you?',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7C74),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _placeName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF223B2F),
                    ),
                  ),
                ],
              ),
            ),
            const Row(
              children: [
                Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF284D3A),
                  ),
                ),
                SizedBox(width: 2),
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: Color(0xFF284D3A),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEBE4D8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Color(0xFFE3EDE5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  color: Color(0xFF284D3A),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'How are you feeling?',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7C74),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _moods.map((mood) {
                final isSelected = _selectedMood == mood['label'];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _selectedMood = mood['label']!);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFE4F0E6)
                            : const Color(0xFFF7F3EB),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF669472)
                              : const Color(0xFFE2DBCF),
                          width: isSelected ? 1.8 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            mood['emoji']!,
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            mood['label']!,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight:
                                  isSelected ? FontWeight.bold : FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFF1E3E2B)
                                  : const Color(0xFF4A5C52),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisibilityCard() {
    return GestureDetector(
      onTap: _showVisibilityModal,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFEBE4D8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xFFE3EDE5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_outline,
                color: Color(0xFF284D3A),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Who can see this?',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7C74),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        _visibility,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF223B2F),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _visibility == 'Only Me'
                            ? '(Presence is personal)'
                            : '(${_visibility.toLowerCase()})',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7C74),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: Color(0xFF8B9A92),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionDivider() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.auto_awesome, size: 14, color: Color(0xFF8A9A92)),
        SizedBox(width: 8),
        Text(
          'Choose how you want to share this moment',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7C74),
          ),
        ),
        SizedBox(width: 8),
        Icon(Icons.auto_awesome, size: 14, color: Color(0xFF8A9A92)),
      ],
    );
  }

  Widget _buildDualActionCards() {
    return Row(
      children: [
        // ---------------- LEFT CARD: TAKE AS PRESENCE ----------------
        Expanded(
          child: GestureDetector(
            onTap: () => _submit(isFootprint: false),
            child: Container(
              height: 188,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF3EB),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFC4DBC5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF284D3A).withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD2E6D5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFF234933),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: CustomPaint(
                          size: const Size(double.infinity, 30),
                          painter: _PresenceTrailPainter(),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    'Take as Presence',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B3B28),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Keep this memory with you. It will be part of your journey.',
                    style: TextStyle(
                      fontSize: 11.5,
                      height: 1.3,
                      color: Color(0xFF415C4B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // ---------------- RIGHT CARD: LEAVE AS FOOTPRINT ----------------
        Expanded(
          child: GestureDetector(
            onTap: () => _submit(isFootprint: true),
            child: Container(
              height: 188,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF4EB),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFEDD7C0),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF733F17).withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF6E1CC),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.directions_walk,
                          color: Color(0xFF844A1E),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: CustomPaint(
                          size: const Size(double.infinity, 30),
                          painter: _FootprintTrailPainter(),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    'Leave as Footprint',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6E3911),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Leave it at this place for others to discover in the future.',
                    style: TextStyle(
                      fontSize: 11.5,
                      height: 1.3,
                      color: Color(0xFF75553C),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------- CUSTOM PAINTERS ----------------

class _PresenceTrailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final heartPaint = Paint()..color = const Color(0xFF387A4F);
    canvas.drawCircle(Offset(6, size.height / 2), 3, heartPaint);

    final pathPaint = Paint()
      ..color = const Color(0xFF8BB594)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final path = Path();
    path.moveTo(12, size.height / 2);
    path.cubicTo(
      size.width * 0.35,
      size.height * 0.1,
      size.width * 0.65,
      size.height * 0.9,
      size.width - 4,
      size.height * 0.4,
    );

    _drawDashedPath(canvas, path, pathPaint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 3.5;
    const dashSpace = 3.0;
    double distance = 0.0;
    for (final pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final extractPath = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FootprintTrailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pathPaint = Paint()
      ..color = const Color(0xFFCFA682)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    final path = Path();
    path.moveTo(4, size.height * 0.6);
    path.cubicTo(
      size.width * 0.35,
      size.height * 0.1,
      size.width * 0.65,
      size.height * 0.85,
      size.width - 12,
      size.height * 0.35,
    );

    _drawDashedPath(canvas, path, pathPaint);

    final pinPaint = Paint()..color = const Color(0xFF8F4C1B);
    canvas.drawCircle(Offset(size.width - 6, size.height * 0.35), 3.5, pinPaint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 3.5;
    const dashSpace = 3.0;
    double distance = 0.0;
    for (final pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final extractPath = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DashedRRectPainter extends CustomPainter {
  final Color color;
  final double borderRadius;

  _DashedRRectPainter({required this.color, required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rrect);

    const dashWidth = 5.0;
    const dashSpace = 4.0;
    double distance = 0.0;
    for (final metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final extractPath = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.borderRadius != borderRadius;
}
