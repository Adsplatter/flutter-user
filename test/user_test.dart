import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_user/user.dart'; // Update with actual import path

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences preferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
  });

  test('User.save() should store all fields correctly', () async {
    final user = User(
      cookie: 'Y29va2ll', // base64 for "cookie"
      loggedIn: true,
      status: 1,
      uqid: 'unique-id-1234',
      email: 'test@example.com',
      mobile: '1234567890',
      password: 'securePassword123',
      provider: 'email',
      accountCreated: 1700000000,
      lastLogin: 1700005000,
      birthDate: 946684800,
      firstName: 'John',
      lastName: 'Doe',
      addressLine1: '123 Test St',
      addressLine2: 'Apt 4',
      city: 'Coventry',
      state: 'West Midlands',
      postcode: 'CV1 2WT',
      country: 'UK',
    );

    await user.save();

    expect(preferences.getString('userLogInCookie'), 'Y29va2ll');
    expect(preferences.getBool('userLoggedIn'), true);
    expect(preferences.getInt('userStatus'), 1);
    expect(preferences.getString('userUqid'), 'unique-id-1234');
    expect(preferences.getString('userEmail'), 'test@example.com');
    expect(preferences.getString('userMobile'), '1234567890');
    expect(preferences.getString('userPassword'), 'securePassword123');
    expect(preferences.getString('userProvider'), 'email');
    expect(preferences.getInt('userAccountCreated'), 1700000000);
    expect(preferences.getInt('userLastLogin'), 1700005000);
    expect(preferences.getInt('userBirthDate'), 946684800);
    expect(preferences.getString('userFirstName'), 'John');
    expect(preferences.getString('userLastName'), 'Doe');
    expect(preferences.getString('userAddressLine1'), '123 Test St');
    expect(preferences.getString('userAddressLine2'), 'Apt 4');
    expect(preferences.getString('userCity'), 'Coventry');
    expect(preferences.getString('userState'), 'West Midlands');
    expect(preferences.getString('userPostcode'), 'CV1 2WT');
    expect(preferences.getString('userCountry'), 'UK');
  });

  test('User setters should update SharedPreferences', () async {
    final user = User(
      cookie: 'Y29va2ll',
      loggedIn: true,
      status: 1,
      uqid: 'unique-id-1234',
      email: 'test@example.com',
      mobile: '1234567890',
      password: 'securePassword123',
      provider: 'email',
      accountCreated: 1700000000,
      lastLogin: 1700005000,
      birthDate: 946684800,
      firstName: 'John',
      lastName: 'Doe',
      addressLine1: '123 Test St',
      addressLine2: 'Apt 4',
      city: 'Coventry',
      state: 'West Midlands',
      postcode: 'CV1 2WT',
      country: 'UK',
    );

    await user.save();

    expect(preferences.getString('userEmail'), 'test@example.com');

    user.email = 'new@example.com';
    user.city = 'London';

    await user.save();

    expect(preferences.getString('userEmail'), 'new@example.com');
    expect(preferences.getString('userCity'), 'London');
  });
}

