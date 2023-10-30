// ignore_for_file: non_constant_identifier_names

class User {
  final String r_name;
  final String r_id;
  final String con_name;
  final String exp_name;
  final String e_amt;
  final String r_desc;
  final String u_name;
  final String email;
  final String password;
  final int age;
  final String number;
  final String gender;
  final String payment;
  final String c_desc;
  final String e_desc;
  final String cel_tme;
  final String cel_dte;
  final String cel_name;
  final String cel_desc;
  final String role;
  final String role_id;
  final String u_img;
  final String role_permission;
  final String userbranch;
  final String userFaculty;

  User({
    required this.r_name,
    required this.r_id,
    required this.u_img,
    required this.con_name,
    required this.exp_name,
    required this.e_amt,
    required this.r_desc,
    required this.u_name,
    required this.email,
    required this.password,
    required this.age,
    required this.number,
    required this.gender,
    required this.payment,
    required this.c_desc,
    required this.e_desc,
    required this.cel_tme,
    required this.cel_dte,
    required this.cel_name,
    required this.cel_desc,
    required this.role,
    required this.role_id,
    required this.role_permission,
    required this.userbranch,
    required this.userFaculty,
  });

  factory User.employeeData(Map<String, dynamic> employeeData) {
    return User(
      role: employeeData['role'],
      r_id: employeeData['room id'],
      number: employeeData['number'],
      u_name: employeeData['name'],
      email: employeeData['email'],
      password: employeeData['password'],
      gender: employeeData['gender'],
      age: employeeData['age'],
      r_name: employeeData['room name'],
      r_desc: employeeData['room desc'],
      e_amt: employeeData['expense amt'],
      payment: employeeData['payment'],
      c_desc: employeeData['contribution desc'],
      e_desc: employeeData['expense desc'],
      cel_dte: employeeData['celebration date'],
      cel_tme: employeeData['celebration time'],
      cel_name: employeeData['celebration name'],
      cel_desc: employeeData['celebration desc'],
      con_name: employeeData['contribution name'],
      exp_name: employeeData['expense title'],
      u_img: employeeData['user image'],
      role_permission: employeeData['role_permission'],
      role_id: employeeData['role_id'],
      userbranch: employeeData['branch'],
      userFaculty: employeeData['faculty'],
    );
  }
}
