

enum UserAvatarTypeEnum {
  emoji1,
  emoji2,
  emoji3,
  emoji4,
  emoji5;

  String get emojiPath {
    switch (this) {
      case UserAvatarTypeEnum.emoji1:
        return "assets/profile_avatars/profile_avatar_1.png";
      case UserAvatarTypeEnum.emoji2:
        return "assets/profile_avatars/profile_avatar_2.png";
      case UserAvatarTypeEnum.emoji3:
        return "assets/profile_avatars/profile_avatar_3.png";
      case UserAvatarTypeEnum.emoji4:
        return "assets/profile_avatars/profile_avatar_4.png";
      case UserAvatarTypeEnum.emoji5:
        return "assets/profile_avatars/profile_avatar_5.png";
    }
  }
}
