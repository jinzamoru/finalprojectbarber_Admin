import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../model/appointment_model.dart';
import '../model/barber_model.dart';
import '../model/data.dart';
import '../model/hair_model.dart';
import '../model/user_model.dart';

class DataManagerProvider extends ChangeNotifier {
  bool isLoading = false;

  late List<HairModel> allhairs = [];
  late List<AdminInfo> alladmins = [];
  late List<BarberInfo> allbarbers = [];

  List<HairModel> searchListhairs = [];
  List<AdminInfo> searchListAdmins = [];
  List<BarberInfo> searchListBarbers = [];

  late BarberInfo barberInfo;

  late BarberModel barberCompleteData;

  late AdminInfo adminProfile = AdminInfo(
      AdminId: '',
      AdminPassword: '',
      AdminFirstName: '',
      AdminLastName: '',
      AdminEmail: '');

  late BarberModel barberProfile;

  late bool isSearching = false;

  late List<AppointmentModel> myAppointments = [];

  late BarberModel myAppointmentWithBarber;

  List<AppointmentModel> appointmentList = [];

  void setLoadingStatus(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  bool get loading => isLoading;

  void setAdminProfile(AdminInfo user) {
    adminProfile = user;
    notifyListeners();
  }

  AdminInfo get currentUser => adminProfile;

  void setBarberProfile(BarberModel user) {
    print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
    barberProfile = user;
    notifyListeners();
  }

  BarberModel get getBarberProfile => barberProfile;

  void setAllHairs(List<HairModel> hairMapList) {
    allhairs = hairMapList;
    notifyListeners();
  }

  void setAllAdmin(List<AdminInfo> adminMapList) {
    alladmins = adminMapList;
    notifyListeners();
  }

  void setAllbarber(List<BarberInfo> barberMapList) {
    allbarbers = barberMapList;
    notifyListeners();
  }

  List<HairModel> get getAllHairs => allhairs;
  List<AdminInfo> get getAllAdmin => alladmins;
  List<BarberInfo> get getAllBarber => allbarbers;

  void getSearchHair(String searchKey) {
    allhairs.forEach((element) {
      if (element.hairName.toLowerCase().startsWith(searchKey.toLowerCase()) ||
          element.hairName.startsWith(searchKey.toLowerCase())) {
        searchResultHair(element);
      }
    });
  }

  void getSearchBarber(String searchKey) {
    allbarbers.forEach((element) {
      if (element.barberFirstName
              .toLowerCase()
              .startsWith(searchKey.toLowerCase()) ||
          element.barberFirstName.startsWith(searchKey.toLowerCase())) {
        searchResultBarber(element);
      }
    });
  }

  void getSearchAdmin(String searchKey) {
    alladmins.forEach((element) {
      if (element.AdminFirstName.toLowerCase()
              .startsWith(searchKey.toLowerCase()) ||
          element.AdminFirstName.startsWith(searchKey.toLowerCase())) {
        searchResultAdmin(element);
      }
    });
  }

  void searchResultHair(HairModel hairModel) {
    searchListhairs.add(hairModel);
    notifyListeners();
  }

  void searchResultAdmin(AdminInfo admin) {
    searchListAdmins.add(admin);
    notifyListeners();
  }

  void searchResultBarber(BarberInfo barber) {
    searchListBarbers.add(barber);
    notifyListeners();
  }

  List<HairModel> get getSearchListhair => searchListhairs;
  List<AdminInfo> get getSearchListadmin => searchListAdmins;
  List<BarberInfo> get getSearchListbarber => searchListBarbers;
  void setIsSearching(bool value) {
    isSearching = value;
    notifyListeners();
  }

  bool get searchingStart => isSearching;

  // void setBarberBasicInformation(
  //     String id, String name, String email, String contact) {
  //   barberInfo = BarberInfo(
  //       barberId: id,
  //       barberFullName: name,
  //       barberEmail: email,
  //       barberContact: contact,
  //       roll: 'Barber',
  //       barberPassword: '');
  //   notifyListeners();
  // }

  void setBarberShopInfo(
      String shopName,
      String seats,
      String description,
      String address,
      double latitude,
      double longitude,
      String startTime,
      String endTime) {
    Location location =
        Location(address: address, latitude: latitude, longitude: longitude);
    ShopStatus status =
        ShopStatus(status: 'Open', startTime: startTime, endTime: endTime);
    final _random = Random();
    String index = urls[_random.nextInt(urls.length)];
    barberCompleteData = BarberModel(
        shopName: shopName,
        barber: barberInfo,
        seats: seats,
        description: description,
        rating: 0.0,
        goodReviews: 0,
        totalScore: 0,
        satisfaction: 0,
        image: index,
        location: location,
        shopStatus: status,
        barberId: '',
        barberFullName: '',
        barberEmail: '',
        barberContact: '');
    notifyListeners();
  }

  BarberModel get getBarberDetails => barberCompleteData;

/////////////////appointment
  void setAppointmentList(List<AppointmentModel> model) {
    appointmentList = model;
    notifyListeners();
  }

  void setMyAppointments(List<AppointmentModel> model) {
    myAppointments = model;
    notifyListeners();
  }

  void setMyAppointmentWithBarber(BarberModel barberModel) {
    myAppointmentWithBarber = barberModel;
    notifyListeners();
  }
}
