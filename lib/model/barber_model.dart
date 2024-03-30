class BarberModel {
  String shopName;
  BarberInfo barber;
  String seats;
  String description;
  double rating;
  int goodReviews;
  int totalScore;
  int satisfaction;
  String image;
  Location location;
  ShopStatus shopStatus;

  BarberModel(
      {required this.shopName,
      required this.barber,
      required this.seats,
      required this.description,
      required this.rating,
      required this.goodReviews,
      required this.totalScore,
      required this.satisfaction,
      required this.image,
      required this.location,
      required this.shopStatus,
      required String barberId,
      required String barberFullName,
      required String barberEmail,
      required String barberContact});
}

class BarberInfo {
  final String barberId;
  final String barberFirstName;
  final String barberLastName;
  final String barberPhone;
  final String barberEmail;
  final String barberPassword;
  final String barberIDCard;
  final String barberCertificate;
  final String barberNamelocation;
  final double barberLatitude;
  final double barberLongitude;

  BarberInfo(
      {required this.barberId,
      required this.barberFirstName,
      required this.barberLastName,
      required this.barberPhone,
      required this.barberEmail,
      required this.barberPassword,
      required this.barberIDCard,
      required this.barberCertificate,
      required this.barberNamelocation,
      required this.barberLatitude,
      required this.barberLongitude});
}

class Location {
  final String address;
  final double latitude;
  final double longitude;

  Location({
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class ShopStatus {
  final String startTime;
  final String endTime;
  final String status;

  ShopStatus(
      {required this.status, required this.startTime, required this.endTime});
}
