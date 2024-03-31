// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:finalprojectbarber/homepage.dart';
import 'package:finalprojectbarber/model/barber_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

import '../data_manager/data_manager.dart';

import '../model/hair_model.dart';
import '../model/user_model.dart';
import 'dart:convert';

const server =
    "https://0c8d-2403-6200-8837-7557-196d-fe84-bd4c-da2.ngrok-free.app";
Future<bool> loginUser(
    String email, String password, String roll, BuildContext context) async {
  try {
    const url = '$server/user/login.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
        'password': password,
        'roll': roll,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['result'] == 1) {
        await getAdminProfile(email, context).whenComplete(() {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false);
        });
        return true;
      } else {
        showErrorDialog(data['message'], context);
        return false;
      }
    } else {
      showErrorDialog('เชื่อมต่อกับเซิร์ฟเวอร์ล้มเหลว', context);
      return false;
    }
  } catch (e) {
    showErrorDialog('$e', context);
    return false;
  }
}

Future<void> getAdminProfile(email, BuildContext context) async {
  try {
    final url = Uri.parse('$server/user/get_admin.php?email=$email');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['result'] == 1) {
        final Map<String, dynamic> userData = data['data'];
        String id = userData['id'].toString();
        String name = userData['name'].toString();
        String lastname = userData['lastname'].toString();
        String email = userData['email'].toString();
        final adminData = AdminInfo(
          AdminId: id,
          AdminFirstName: name,
          AdminLastName: lastname,
          AdminEmail: email,
          AdminPassword: '',
        );
        Provider.of<DataManagerProvider>(context, listen: false)
            .setAdminProfile(adminData);
      }
    }
  } catch (e) {
    showErrorDialog('$e', context);
  }
}

Future<void> getAllHairs(BuildContext context) async {
  List<HairModel> hairList = [];
  try {
    final url = Uri.parse('$server/user/get_hair.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['result'] == 1) {
        var hairData = data['data'];
        if (hairData is List) {
          for (var hair in hairData) {
            hairList.add(HairModel(
              hairId: hair['id'].toString(),
              hairName: hair['name'].toString(),
              hairPrice: hair['price'].toInt(),
            ));
          }
        }
        Provider.of<DataManagerProvider>(context, listen: false)
            .setAllHairs(hairList);
      }
    }
  } catch (e) {
    showErrorDialog('$e', context);
  }
}

Future<void> getAllAdmins(BuildContext context) async {
  List<AdminInfo> adminList = [];
  try {
    final url = Uri.parse('$server/user/get_all_admin.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['result'] == 1) {
        var adminData = data['data'];
        if (adminData is List) {
          for (var admin in adminData) {
            adminList.add(AdminInfo(
                AdminId: admin['id'].toString(),
                AdminFirstName: admin['name'].toString(),
                AdminLastName: admin['lastname'].toString(),
                AdminEmail: admin['email'],
                AdminPassword: ""));
          }
        }
        Provider.of<DataManagerProvider>(context, listen: false)
            .setAllAdmin(adminList);
      }
    }
  } catch (e) {
    showErrorDialog('$e', context);
  }
}

Future<void> getAllBarbers(BuildContext context) async {
  List<BarberInfo> barberList = [];
  try {
    final url = Uri.parse('$server/user/get_all_barber.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['result'] == 1) {
        var barberData = data['data'];
        if (barberData is List) {
          for (var barber in barberData) {
            barberList.add(BarberInfo(
                barberId: barber['id'].toString(),
                barberFirstName: barber['name'].toString(),
                barberLastName: barber['lastname'],
                barberPhone: barber['phone'],
                barberEmail: barber['email'],
                barberPassword: "",
                barberIDCard: barber['idcard'],
                barberCertificate: barber['certificate'],
                barberNamelocation: barber['namelocation'],
                barberLatitude: barber['latitude'].toDouble(),
                barberLongitude: barber['longitude'].toDouble()));
          }
        }
        Provider.of<DataManagerProvider>(context, listen: false)
            .setAllbarber(barberList);
      }
    }
  } catch (e) {
    showErrorDialog('$e', context);
  }
}

Future<bool> addHair(HairModel hair, BuildContext context) async {
  try {
    const url = '$server/user/add_hair.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'name': hair.hairName,
        'price': hair.hairPrice.toString(),
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['result'] == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('แจ้งเตือน'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () async {
                    await getAllHairs(context);
                    Navigator.pop(context);
                  },
                  child: const Text('ตกลง'),
                ),
              ],
            );
          },
        );
        return true;
      } else {
        showErrorDialog(data['message'], context);
        return false;
      }
    }
  } catch (e) {
    showErrorDialog('$e', context);
    return false;
  }
  return false;
}

Future<Map<String, dynamic>?> addAdmin(
    AdminInfo admin, BuildContext context) async {
  try {
    const url = '$server/user/add_admin.php';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'name': admin.AdminFirstName,
        'lastname': admin.AdminLastName,
        'email': admin.AdminEmail,
        'password': admin.AdminPassword,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['result'] == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('แจ้งเตือน'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () async {
                    await getAllAdmins(context);
                    Navigator.pop(context);
                  },
                  child: const Text('ตกลง'),
                ),
              ],
            );
          },
        );
        return data;
      } else {
        showErrorDialog(data['message'], context);
        return null;
      }
    }
  } catch (e) {
    showErrorDialog('$e', context);
    return null;
  }
  return null;
}

Future<bool> addBarber(
    BarberInfo barber, File? imageFile, BuildContext context) async {
  try {
    const url = '$server/user/add_barber.php';
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['id'] = barber.barberId;
    request.fields['name'] = barber.barberFirstName;
    request.fields['lastname'] = barber.barberLastName;
    request.fields['email'] = barber.barberEmail;
    request.fields['phone'] = barber.barberPhone;
    request.fields['password'] = barber.barberPassword;
    request.fields['idcard'] = barber.barberIDCard;
    request.fields['certificate'] = barber.barberCertificate;
    request.fields['namelocation'] = barber.barberNamelocation;
    request.fields['latitude'] = barber.barberLatitude.toString();
    request.fields['longitude'] = barber.barberLongitude.toString();

    if (imageFile != null) {
      List<int> imageBytes = await imageFile.readAsBytes();

      // Create multipart file from the image file
      var multipartFile = http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'cer.jpg',
      );

      // Add multipart file to the request
      request.files.add(multipartFile);
    }

    // ส่งคำขอและรอการตอบกลับ
    var response = await request.send();

    // อ่านข้อมูลการตอบกลับ
    var responseString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(responseString);
      if (data['result'] == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('แจ้งเตือน'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () async {
                    await getAllBarbers(context);
                    Navigator.pop(context);
                  },
                  child: const Text('ตกลง'),
                ),
              ],
            );
          },
        );
        return true;
      } else {
        showErrorDialog(data['message'], context);
        return false;
      }
    }
  } catch (e) {
    showErrorDialog('$e', context);
    return false;
  }
  return false;
}

Future<void> updateHair(HairModel hairModel, BuildContext context) async {
  try {
    const url = '$server/user/update_hair.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': hairModel.hairId,
        'name': hairModel.hairName,
        'price': hairModel.hairPrice.toString(),
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['result'] == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('แจ้งเตือน'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () async {
                    await getAllHairs(context);
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('ตกลง'),
                ),
              ],
            );
          },
        );
      } else {
        showErrorDialog(data['message'], context);
      }
    } else {
      showErrorDialog('เชื่อมต่อกับเซิร์ฟเวอร์ล้มเหลว', context);
    }
  } catch (e) {
    showErrorDialog('$e', context);
  }
}

Future<void> updateAdmin(AdminInfo adminModel, BuildContext context) async {
  try {
    const url = '$server/user/update_admin.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': adminModel.AdminId,
        'name': adminModel.AdminFirstName,
        'lastname': adminModel.AdminLastName,
        'email': adminModel.AdminEmail,
        'password': adminModel.AdminPassword,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['result'] == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('แจ้งเตือน'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () async {
                    await getAllAdmins(context);
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('ตกลง'),
                ),
              ],
            );
          },
        );
      } else {
        showErrorDialog(data['message'], context);
      }
    } else {
      showErrorDialog('เชื่อมต่อกับเซิร์ฟเวอร์ล้มเหลว', context);
    }
  } catch (e) {
    showErrorDialog('$e', context);
  }
}

Future<void> editProfile(AdminInfo adminModel, BuildContext context) async {
  try {
    const url = '$server/user/edit_admin_profile.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': adminModel.AdminId,
        'name': adminModel.AdminFirstName,
        'lastname': adminModel.AdminLastName,
        'email': adminModel.AdminEmail,
        'password': adminModel.AdminPassword,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['result'] == 1) {
        final Map<String, dynamic> userData = data['data'];
        String email = userData['email'].toString();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('แจ้งเตือน'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () async {
                    await getAdminProfile(email, context);
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('ตกลง'),
                ),
              ],
            );
          },
        );
      } else {
        showErrorDialog(data['message'], context);
      }
    } else {
      showErrorDialog('เชื่อมต่อกับเซิร์ฟเวอร์ล้มเหลว', context);
    }
  } catch (e) {
    showErrorDialog('$e', context);
  }
}

Future<void> updateBarber(
    BarberInfo barberModel, BuildContext context, File? imageFile) async {
  try {
    const url = '$server/user/update_barber.php';
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['id'] = barberModel.barberId;
    request.fields['name'] = barberModel.barberFirstName;
    request.fields['lastname'] = barberModel.barberLastName;
    request.fields['email'] = barberModel.barberEmail;
    request.fields['phone'] = barberModel.barberPhone;
    request.fields['password'] = barberModel.barberPassword;
    request.fields['idcard'] = barberModel.barberIDCard;
    request.fields['certificate'] = barberModel.barberCertificate;
    request.fields['namelocation'] = barberModel.barberNamelocation;
    request.fields['latitude'] = barberModel.barberLatitude.toString();
    request.fields['longitude'] = barberModel.barberLongitude.toString();

    if (imageFile != null) {
      List<int> imageBytes = await imageFile.readAsBytes();

      // Create multipart file from the image file
      var multipartFile = http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'cer.jpg',
      );

      // Add multipart file to the request
      request.files.add(multipartFile);
    }

    // ส่งคำขอและรอการตอบกลับ
    var response = await request.send();

    // อ่านข้อมูลการตอบกลับ
    var responseString = await response.stream.bytesToString();

    // ตรวจสอบสถานะการตอบกลับ
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(responseString);

      if (data['result'] == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('แจ้งเตือน'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () async {
                    await getAllBarbers(context);
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('ตกลง'),
                ),
              ],
            );
          },
        );
      } else {
        showErrorDialog(data['message'], context);
      }
    } else {
      showErrorDialog('เชื่อมต่อกับเซิร์ฟเวอร์ล้มเหลว', context);
    }
  } catch (e) {
    showErrorDialog('$e', context);
  }
}

Future<void> deleteHair(String id, BuildContext context) async {
  try {
    const url = '$server/user/delete_hair.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': id,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['result'] == 1) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('แจ้งเตือน'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () async {
                    await getAllHairs(context);
                    Navigator.pop(context);
                  },
                  child: const Text('ตกลง'),
                ),
              ],
            );
          },
        );
      } else {
        showErrorDialog(data['message'], context);
      }
    } else {
      showErrorDialog('เชื่อมต่อกับเซิร์ฟเวอร์ล้มเหลว', context);
    }
  } catch (e) {
    showErrorDialog('$e', context);
  }
}

Future<void> deleteAdmin(String id, BuildContext context) async {
  final adminId = Provider.of<DataManagerProvider>(context, listen: false)
      .currentUser
      .AdminId;
  if (adminId.toString() == id) {
    Navigator.pop(context);
    showErrorDialog('ไม่สามารถลบ Admin ที่กำลังใช้งานได้', context);
  } else {
    try {
      const url = '$server/user/delete_admin.php';
      final response = await http.post(
        Uri.parse(url),
        body: {
          'id': id,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['result'] == 1) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('แจ้งเตือน'),
                content: Text(data['message']),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await getAllAdmins(context);
                      Navigator.pop(context);
                    },
                    child: const Text('ตกลง'),
                  ),
                ],
              );
            },
          );
        } else {
          showErrorDialog(data['message'], context);
        }
      } else {
        showErrorDialog('เชื่อมต่อกับเซิร์ฟเวอร์ล้มเหลว', context);
      }
    } catch (e) {
      showErrorDialog('$e', context);
    }
  }
}

Future<void> deleteBarber(
    String id, String certificate, BuildContext context) async {
  try {
    final url =
        '$server/user/delete_barber.php?id=$id&certificate=$certificate';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['result'] == 1) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('แจ้งเตือน'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () async {
                    await getAllBarbers(context);
                    Navigator.pop(context);
                  },
                  child: const Text('ตกลง'),
                ),
              ],
            );
          },
        );
      } else {
        showErrorDialog(data['message'], context);
      }
    } else {
      showErrorDialog('เชื่อมต่อกับเซิร์ฟเวอร์ล้มเหลว', context);
    }
  } catch (e) {
    showErrorDialog('$e', context);
  }
}

void showErrorDialog(String message, context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('ข้อผิดพลาด'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ตกลง'),
          ),
        ],
      );
    },
  );
}
