class ProfileModel {
  String? gmcNumber;
  String? fullName;
  String? phoneNumber;
  String? avatar;
  String? id;
  bool? isActive;
  UserRole? userRole;
  String? createdAt;
  String? updatedAt;

  ProfileModel(
      {this.gmcNumber,
        this.fullName,
        this.phoneNumber,
        this.avatar,
        this.id,
        this.isActive,
        this.userRole,
        this.createdAt,
        this.updatedAt});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    gmcNumber = json['gmc_number'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    avatar = json['avatar'];
    id = json['id'];
    isActive = json['is_active'];
    userRole = json['user_role'] != null
        ? new UserRole.fromJson(json['user_role'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gmc_number'] = this.gmcNumber;
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    data['avatar'] = this.avatar;
    data['id'] = this.id;
    data['is_active'] = this.isActive;
    if (this.userRole != null) {
      data['user_role'] = this.userRole!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UserRole {
  String? userId;
  String? roleId;
  Role? role;

  UserRole({this.userId, this.roleId, this.role});

  UserRole.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}

class Role {
  String? name;
  String? description;
  String? id;

  Role({this.name, this.description, this.id});

  Role.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['id'] = this.id;
    return data;
  }
}