import 'package:flutter/cupertino.dart';
import 'package:simutax_mobile/screens/comparation_screen.dart';
import 'package:simutax_mobile/screens/credit_card_payment_screen.dart';
import 'package:simutax_mobile/screens/forgot_password_screen.dart';
import 'package:simutax_mobile/screens/home_screen.dart';
import 'package:simutax_mobile/screens/login_screen.dart';
import 'package:simutax_mobile/screens/pix_payment_screen.dart';
import 'package:simutax_mobile/screens/payment_method_screen.dart';
import 'package:simutax_mobile/screens/register_screen.dart';
import 'package:simutax_mobile/screens/simulation_screen.dart';
import 'package:simutax_mobile/screens/startup_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String startupScreen = '/startup';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String forgotPasswordScreen = '/forgot';
  static const String homeScreen = '/home';
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
      homeScreen: (context) => const HomeScreen(),
      paymentMethodScreen: (context) => const PaymentMethodScreen(),
      creditCardPaymentScreen: (context) => const CreditCardPaymentScreen(),
      pixPaymentScreen: (context) => const PixPaymentScreen(),
      simulationScreen: (context) => const SimulationScreen(),
      comparationScreen: (context) => const ComparationScreen(),
    };
  }
}
