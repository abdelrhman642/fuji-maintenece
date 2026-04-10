import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'login': 'Login',
      'create_account': 'Create Account',
      'already_have_account': 'Already have an account?',
      'dont_have_account': "Don't have an account?",
      'sign_up': 'Sign Up',
    },
    'ar_SA': {
      'login': 'تسجيل الدخول',
      'create_account': 'إنشاء حساب',
      'already_have_account': 'لديك حساب بالفعل؟',
      'dont_have_account': 'ليس لديك حساب؟',
      'sign_up': 'انشاء حساب',
    },
  };
}
