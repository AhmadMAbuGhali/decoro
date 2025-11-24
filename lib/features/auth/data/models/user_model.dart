import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    super.phone,
    super.role,
    super.verified,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      phone: json['phone'],
      role: json['role'],
      verified: json['verified'],
      createdAt:
      json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt:
      json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatar": avatar,
    "phone": phone,
    "role": role,
    "verified": verified,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}