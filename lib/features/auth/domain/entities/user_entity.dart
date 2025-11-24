// lib/features/auth/domain/entities/user_entity.dart

class UserEntity {
  final String id;
  final String name;
  final String email;

  final String? avatar;
  final String? phone;
  final String? role;
  final bool? verified;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.phone,
    this.role,
    this.verified,
    this.createdAt,
    this.updatedAt,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
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