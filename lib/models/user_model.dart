
class UserModel{

  String firstName = "";
  String lastName = "";
  String phoneNo = "";
  String userDOB = "";
  String userEmail = "";
  String userPassword = "";
  String? userId;
  String? imageUrl;

   UserModel.emptyConstructor();

   UserModel.addNewModel({required this.firstName, required this.lastName, required this.phoneNo, required this.userDOB, required this.userEmail, required this.userPassword, required this.userId, required this.imageUrl});

   UserModel.fromJson(Map<String, dynamic> json){
      firstName = json["firstName"] ?? '';
      lastName = json["lastName"] ?? '';
      phoneNo = json["phoneNo"] ?? '';
      userDOB = json["dateOfBirth"] ?? '';
      userEmail = json["userEmail"] ?? '';
      userPassword = json["userPassword"] ?? '';
      userId = json['userId'] ?? '';
      imageUrl = json['imageUrl'] ?? '';
   }

   Map<String, dynamic>toJson(){
      return {
        "firstName" : firstName,
        "lastName" : lastName,
        "phoneNo" : phoneNo,
        "dateOfBirth" : userDOB,
        "userEmail" : userEmail,
        "userId" : userId,
        "imageUrl" : imageUrl,
      };
   }

  @override
  String toString() {
    return 'UserModel{firstName: $firstName, lastName: $lastName, phoneNo: $phoneNo, userDOB: $userDOB, userEmail: $userEmail, userPassword: $userPassword, userId: $userId, imageUrl: $imageUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          phoneNo == other.phoneNo &&
          userDOB == other.userDOB &&
          userEmail == other.userEmail &&
          userPassword == other.userPassword &&
          imageUrl == other.imageUrl &&
          userId == other.userId;

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      phoneNo.hashCode ^
      userDOB.hashCode ^
      userEmail.hashCode ^
      userPassword.hashCode ^
      imageUrl.hashCode ^
      userId.hashCode;
}
