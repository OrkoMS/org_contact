class AuthUser {
  var userOid;
  var officeId;
  var user_name;
  var scope;
  var employeeId;
  var exp;
  var jti;
  var client_id;


  AuthUser(
      {this.userOid,
        this.officeId,
        this.user_name,
        this.scope,
        this.employeeId,
        this.exp,
        this.jti,
        this.client_id,
      });

  AuthUser.fromJson(Map<String, dynamic> json) {
    userOid = json['userOid'];
    officeId = json['officeId'];
    user_name = json['user_name'];
    scope = json['scope'];
    employeeId = json['employeeId'];
    exp = json['exp'];
    jti = json['jti'];
    client_id = json['client_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userOid'] = this.userOid;
    data['officeId'] = this.officeId;
    data['user_name'] = this.user_name;
    data['scope'] = this.scope;
    data['employeeId'] = this.employeeId;
    data['exp'] = this.exp;
    data['jti'] = this.jti;
    data['client_id'] = this.client_id;
    return data;
  }
}
