import 'package:carmate/models/productcar.dart';
import 'package:carmate/models/roleandpermissions/permission.dart';
import 'package:carmate/models/roleandpermissions/role.dart';
import 'package:carmate/models/user.dart';
import 'package:carmate/screens/admin/createproductcarscreen.dart';
import 'package:carmate/screens/admin/createrolesandpermissions.dart';
import 'package:carmate/screens/admin/createuserscreen.dart';
import 'package:carmate/screens/admin/viewproductcarsscreen.dart';
import 'package:carmate/screens/admin/viewusersscreen.dart';
import 'package:carmate/screens/auth/loginscreen.dart';
import 'package:carmate/screens/auth/passwordresetscreen.dart';
import 'package:carmate/screens/auth/profilescreen.dart';
import 'package:carmate/screens/auth/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => User(
        id: '',
        username: '',
        email: '',
        password: '',
        firstname: '',
        lastname: '',
        mobilenumber: '',
        country: '',
        imageUrl: '',
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductCar(
        userId: '',
        id: '',
        manufacturer: '',
        carName: '',
        engineType: '',
        engineCC: 0,
        fuelType: '',
        mileage: 0,
        price: 0,
        rentPerHr: 0,
        carType: '',
        description: '',
        carImage: '',
        yearOfManufacture: 0,
        status: '',
        chasisNumber: '',
        quantity: 0,
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => Permission(
        id: '',
        permission: '',
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => Role(
        id: '',
        roleName: '',
        permissions: [],
      ),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carmate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => const SignupScreen(),
        '/login': (context) => const LoginScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/passwordreset': (context) => const PasswordResetScreen(),
        '/createproductcar': (context) => const CreateProductCarScreen(),
        '/viewproductcars': (context) => const ViewProductCarsScreen(),
        '/viewusers': (context) => const ViewUsersScreen(),
        '/createuser': (context)=> const CreateUserScreen(),
        '/addrolespermissions':(context)=> const CreateRolesAndPermissions(),
      },
    );
  }
}
