import 'package:flutter/material.dart';
import '../models/user.dart';
import '../screens/profile.dart';

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback? onTap;
  final bool showFootprintStats;
  final bool isGrid;

  const UserCard({
    super.key,
    required this.user,
    this.onTap,
    this.showFootprintStats = true,
    this.isGrid = false,
  });

  IconData _getAchievementIcon(String achievement) {
    switch (achievement.toLowerCase()) {
      case 'legend':
        return Icons.star_rounded;
      case 'photo lover':
        return Icons.camera_alt_rounded;
      case 'story teller':
        return Icons.auto_stories_rounded;
      case 'social butterfly':
        return Icons.groups_rounded;
      case 'trailblazer':
        return Icons.flag_rounded;
      default:
        return Icons.explore_rounded;
    }
  }

  Color _getAchievementColor(String achievement) {
    switch (achievement.toLowerCase()) {
      case 'legend':
        return const Color(0xFFE5A00D);
      case 'photo lover':
        return const Color(0xFFE53E3E);
      case 'story teller':
        return const Color(0xFF805AD5);
      case 'social butterfly':
        return const Color(0xFF319795);
      case 'trailblazer':
        return const Color(0xFFDD6B20);
      default:
        return const Color(0xFF3182CE);
    }
  }

  @override
  Widget build(BuildContext context) {
    final achievementColor = _getAchievementColor(user.achievement);
    final achievementIcon = _getAchievementIcon(user.achievement);

    void defaultOnTap() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(user: user),
        ),
      );
    }

    if (isGrid) {
      return GestureDetector(
        onTap: onTap ?? defaultOnTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // AVATAR
              Stack(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: achievementColor.withOpacity(0.15),
                    backgroundImage: user.avatarUrl != null
                        ? NetworkImage(user.avatarUrl!)
                        : null,
                    child: user.avatarUrl == null
                        ? Text(
                            user.name.isNotEmpty
                                ? user.name.substring(0, 1).toUpperCase()
                                : 'U',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: achievementColor,
                            ),
                          )
                        : null,
                  ),
                  if (user.isFriend)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF38A169),
                          border: Border.all(color: Colors.white, width: 2.5),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 10),

              // NAME
              Text(
                user.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A202C),
                ),
              ),

              const SizedBox(height: 2),

              // USERNAME
              Text(
                '@${user.username.replaceAll('@', '')}',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 8),

              // ACHIEVEMENT BADGE
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: achievementColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      achievementIcon,
                      size: 11,
                      color: achievementColor,
                    ),
                    const SizedBox(width: 3),
                    Flexible(
                      child: Text(
                        user.achievement,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: achievementColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (showFootprintStats) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.pin_drop_outlined,
                      size: 12,
                      color: Colors.black45,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${user.footprintCount} footprints',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      );
    }

    // LIST VIEW MODE
    return GestureDetector(
      onTap: onTap ?? defaultOnTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            // AVATAR WITH BADGE
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: achievementColor.withOpacity(0.15),
                  backgroundImage: user.avatarUrl != null
                      ? NetworkImage(user.avatarUrl!)
                      : null,
                  child: user.avatarUrl == null
                      ? Text(
                          user.name.isNotEmpty
                              ? user.name.substring(0, 1).toUpperCase()
                              : 'U',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: achievementColor,
                          ),
                        )
                      : null,
                ),
                if (user.isFriend)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF38A169),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 14),

            // USER INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A202C),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '@${user.username.replaceAll('@', '')}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      // ACHIEVEMENT BADGE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: achievementColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              achievementIcon,
                              size: 12,
                              color: achievementColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              user.achievement,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: achievementColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (showFootprintStats) ...[
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.pin_drop_outlined,
                              size: 13,
                              color: Colors.black45,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${user.footprintCount} fp',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // TRAILING ACTION / ARROW
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }
}
