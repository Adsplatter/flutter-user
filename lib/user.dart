import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {

  // Non-final properties may change while the app is running
  final String _cookie; // The user cookie (the cookie is encoded base64)
  final bool _loggedIn; // Whether the user is logged in
  final int _status; // A numeric value representing the user status
  final String _uqid;  // The user unique id (uuid)
  String _email = '';
  String _password = '';
  String _mobile = ''; // The user phone number
  final String _provider; // The account provider (eg. Google, Facebook)
  final int _accountCreated; // Unix timestamp
  int _lastLogin = 0; // Unix timestamp
  int _birthDate = 0; // Unix timestamp
  String _firstName = '';
  String _lastName = '';
  String _addressLine1 = '';
  String _addressLine2 = '';
  String _city = '';
  String _state = '';
  String _postcode = '';
  String _country = '';

  // Constructor
  User({
    required String cookie,
    required bool loggedIn,
    required int status,
    required String uqid,
    required String email,
    required String mobile,
    required String password,
    required String provider,
    required int accountCreated,
    required int lastLogin,
    required int birthDate,
    required String firstName,
    required String lastName,
    required String addressLine1,
    required String addressLine2,
    required String city,
    required String state,
    required String postcode,
    required String country
  })
      : _cookie = cookie,
        _loggedIn = loggedIn,
        _status = status,
        _uqid = uqid,
        _email = email,
        _mobile = mobile,
        _password = password,
        _provider = provider,
        _accountCreated = accountCreated,
        _lastLogin = lastLogin,
        _birthDate = birthDate,
        _firstName = firstName,
        _lastName = lastName,
        _addressLine1 = addressLine1,
        _addressLine2 = addressLine2,
        _city = city,
        _state = state,
        _postcode = postcode,
        _country = country
  {
    //
  }

  /// Save the user data to the device storage
  Future<void> save() async {
    return await _updateDeviceStorage();
  }

  /// Update the device storage (SharedPreferences)
  Future<void> _updateDeviceStorage() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('userLogInCookie', _cookie);
    await prefs.setBool('userLoggedIn', _loggedIn);
    await prefs.setInt('userStatus', _status);
    await prefs.setString('userUqid', _uqid);
    await prefs.setString('userProvider', _provider);
    await prefs.setInt('userAccountCreated', _accountCreated);

    await prefs.setString('userEmail', _email);
    await prefs.setString('userMobile', _mobile);
    await prefs.setString('userPassword', _password);
    await prefs.setInt('userLastLogin', _lastLogin);
    await prefs.setInt('userBirthDate', _birthDate);
    await prefs.setString('userFirstName', _firstName);
    await prefs.setString('userLastName', _lastName);
    await prefs.setString('userAddressLine1', _addressLine1);
    await prefs.setString('userAddressLine2', _addressLine2);
    await prefs.setString('userCity', _city);
    await prefs.setString('userState', _state);
    await prefs.setString('userPostcode', _postcode);
    await prefs.setString('userCountry', _country);
  }

  /// Updates the file storage (SharedPreferences)
  Future<void> _updateDeviceStorageByField({required String field}) async {

    if (field.isEmpty) throw 'Field is required';

    final prefs = await SharedPreferences.getInstance();

    switch (field) {
      case 'cookie':
        await prefs.setString('userLogInCookie', _email);
        break;
      case 'email':
        await prefs.setString('userEmail', _email);
        break;
      case 'mobile':
        await prefs.setString('userMobile', _mobile);
        break;
      case 'password':
        await prefs.setString('userPassword', _password);
        break;
      case 'lastLogin':
        await prefs.setInt('userLastLogin', _lastLogin);
        break;
      case 'birthDate':
        await prefs.setInt('userBirthDate', _birthDate);
        break;
      case 'firstName':
        await prefs.setString('userFirstName', _firstName);
        break;
      case 'lastName':
        await prefs.setString('userLastName', _lastName);
        break;
      case 'addressLine1':
        await prefs.setString('userAddressLine1', _addressLine1);
        break;
      case 'addressLine2':
        await prefs.setString('userAddressLine2', _addressLine2);
        break;
      case 'city':
        await prefs.setString('userCity', _city);
        break;
      case 'state':
        await prefs.setString('userState', _state);
        break;
      case 'postcode':
        await prefs.setString('userPostcode', _postcode);
        break;
      case 'country':
        await prefs.setString('userCountry', _country);
        break;
    }
  }

  // Getters
  String get cookie => _cookie;
  String get cookieDecoded => String.fromCharCodes(base64.decode(_cookie));
  bool get loggedIn => _loggedIn;
  int get status => _status;
  String get uqid => _uqid;
  String get email => _email;
  String get mobile => _mobile;
  String get password => _password;
  String get provider => _provider;
  int get accountCreated => _accountCreated;
  String get accountCreatedString => DateFormat('dd/MMM/yyyy').format( DateTime.fromMillisecondsSinceEpoch(accountCreated * 1000) );
  int get lastLogin => _lastLogin;
  String get lastLoginString => DateFormat('dd/MMM/yyyy HH:mm').format( DateTime.fromMillisecondsSinceEpoch(lastLogin * 1000) );
  int get birthDate => _birthDate;
  String get birthDateString => DateFormat('dd/MMM/yyyy').format( DateTime.fromMillisecondsSinceEpoch(birthDate * 1000) );
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get addressLine1 => _addressLine1;
  String get addressLine2 => _addressLine2;
  String get city => _city;
  String get state => _state;
  String get postcode => _postcode;
  String get country => _country;

  // Setters
  set lastLogin(int lastLogin) {
    _lastLogin = lastLogin;
    _updateDeviceStorageByField(field: 'lastLogin');
  }

  set birthDate(int birthDate) {
    _birthDate = birthDate;
    _updateDeviceStorageByField(field: 'birthDate');
  }

  set email(String email) {
    _email = email;
    _updateDeviceStorageByField(field: 'email');
  }

  set mobile(String mobile) {
    _mobile = mobile;
    _updateDeviceStorageByField(field: 'mobile');
  }

  set password(String password) {
    _password = password;
    _updateDeviceStorageByField(field: 'password');
  }

  set firstName(String firstName) {
    _firstName = firstName;
    _updateDeviceStorageByField(field: 'firstName');
  }

  set lastName(String lastName) {
    _lastName = lastName;
    _updateDeviceStorageByField(field: 'lastName');
  }

  set addressLine1(String addressLine1) {
    _addressLine1 = addressLine1;
    _updateDeviceStorageByField(field: 'addressLine1');
  }

  set addressLine2(String addressLine2) {
    _addressLine2 = addressLine2;
    _updateDeviceStorageByField(field: 'addressLine2');
  }

  set city(String city) {
    _city = city;
    _updateDeviceStorageByField(field: 'city');
  }

  set state(String state) {
    _state = state;
    _updateDeviceStorageByField(field: 'state');
  }

  set postcode(String postcode) {
    _postcode = postcode;
    _updateDeviceStorageByField(field: 'postcode');
  }

  set country(String country) {
    _country = country;
    _updateDeviceStorageByField(field: 'country');
  }

}
