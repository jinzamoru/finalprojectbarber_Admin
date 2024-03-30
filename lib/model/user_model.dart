class AdminInfo {
  final String AdminId;
  final String AdminFirstName;
  final String AdminLastName;
  final String AdminEmail;
  final String AdminPassword;


  AdminInfo(
      {required this.AdminId,
     required this.AdminPassword,
      required this.AdminFirstName,
      required this.AdminLastName,
      required this.AdminEmail});
}
