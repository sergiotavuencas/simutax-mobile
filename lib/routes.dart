import 'package:flutter/cupertino.dart';
import 'package:simutax_mobile/screens/code_screen.dart';
import 'package:simutax_mobile/screens/comparation_screen.dart';
import 'package:simutax_mobile/screens/credit_card_payment_screen.dart';
import 'package:simutax_mobile/screens/edit_profile_screen.dart';
import 'package:simutax_mobile/screens/forgot_password_screen.dart';
import 'package:simutax_mobile/screens/home_screen.dart';
import 'package:simutax_mobile/screens/login_screen.dart';
// import 'package:simutax_mobile/screens/pix_payment_screen.dart';
import 'package:simutax_mobile/screens/payment_method_screen.dart';
import 'package:simutax_mobile/screens/profile_screen.dart';
import 'package:simutax_mobile/screens/register_screen.dart';
import 'package:simutax_mobile/screens/reset_password_screen.dart';
import 'package:simutax_mobile/screens/shut_profile_screen.dart';
import 'package:simutax_mobile/screens/simulation_screen.dart';
import 'package:simutax_mobile/screens/startup_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String startupScreen = '/startup';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String forgotPasswordScreen = '/forgot';
  static const String codeScreen = '/code';
  static const String resetPasswordScreen = '/reset';
  static const String homeScreen = '/home';
  static const String profileScreen = '/profile';
  static const String editProfileScreen = '/edit_profile';
  static const String shutProfileScreen = '/shut_profile';
  static const String paymentMethodScreen = '/payment_method';
  static const String creditCardPaymentScreen = '/credit_card_payment';
  static const String pixPaymentScreen = '/pix_payment';
  static const String simulationScreen = '/simulation';
  static const String comparationScreen = '/comparation';

  static Map<String, WidgetBuilder> define() {
    return {
      startupScreen: (context) => const StartupScreen(),
      loginScreen: (context) => const LoginScreen(),
      registerScreen: (context) => const RegisterScreen(),
      forgotPasswordScreen: (context) => const ForgotPasswordScreen(),
      codeScreen: (context) => const CodeScreen(),
      resetPasswordScreen: (context) => const ResetPasswordScreen(),
      homeScreen: (context) => const HomeScreen(),
      profileScreen: (context) => const ProfileScreen(),
      editProfileScreen: (context) => const EditProfileScreen(),
      shutProfileScreen: (context) => const ShutProfileScreen(),
      paymentMethodScreen: (context) => const PaymentMethodScreen(),
      creditCardPaymentScreen: (context) => const CreditCardPaymentScreen(),
      // pixPaymentScreen: (context) => const PixPaymentScreen(),
      simulationScreen: (context) => const SimulationScreen(),
      comparationScreen: (context) => const ComparationScreen(),
    };
  }
}
