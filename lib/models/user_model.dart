class UserModel {
  UserModel({
    required this.uid,
    required this.name,
    required this.avatar,
    required this.phoneNumber,
    required this.isOnline,
    required this.groupId,
  });

  final String uid;
  final String name;
  final String avatar;
  final String phoneNumber;
  final bool isOnline;
  final List<String> groupId;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'avatar': avatar,
      'phoneNumber': phoneNumber,
      'isOnline': isOnline,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      avatar: map['avatar'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      isOnline: map['isOnline'] ?? false,
      groupId: List<String>.from(map['groupId']),
    );
  }
}
