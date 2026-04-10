import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/models/report_model/report_model.dart';
import '../../../../core/models/report_model/contract.dart';
import '../../../../core/models/report_model/client.dart' as ReportClient;
import '../../../../core/models/report_model/technician.dart';
import '../../../../core/models/report_model/questions_answer.dart';
import '../../../admin/features/contracts/data/models/contract_model/contract_model.dart';
import '../../../admin/features/contracts/data/models/contract_model/client.dart';

/// Guest Mode Provider - يوفر بيانات تجريبية للعميل في وضع الضيف
class GuestModeProvider {
  static bool _isGuestMode = false;

  /// تفعيل وضع الضيف
  static void enableGuestMode() {
    _isGuestMode = true;
  }

  /// إلغاء تفعيل وضع الضيف
  static void disableGuestMode() {
    _isGuestMode = false;
  }

  /// التحقق من تفعيل وضع الضيف
  static bool get isGuestMode => _isGuestMode;

  /// عرض رسالة تطلب من المستخدم تسجيل الدخول
  static void showLoginRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text('تسجيل الدخول مطلوب'),
            content: Text('يجب عليك تسجيل الدخول للوصول إلى هذه الميزة'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    dialogContext,
                  ).pop(); // Close dialog using dialog context
                  disableGuestMode();
                  // Use the original context for navigation
                  Future.delayed(Duration(milliseconds: 300), () {
                    if (context.mounted) {
                      context.go('${Routes.login}?userType=client');
                    }
                  });
                },
                child: Text('تسجيل الدخول'),
              ),
            ],
          ),
    );
  }

  /// الحصول على بيانات تجريبية للعقود
  static List<ContractModel> getDummyContracts() {
    return [
      ContractModel(
        id: 1,
        clientId: 100,
        contractNumber: 'CNT-2024-001',
        contractSectionId: 1,
        startDate: DateTime.now().subtract(Duration(days: 180)),
        endDate: DateTime.now().add(Duration(days: 185)),
        contractDurationId: 1,
        contractPrice: '50000',
        elevatorTypeId: 1,
        elevatorModelId: 1,
        location: 'القاهرة - مصر الجديدة - شارع النزهة',
        longitude: '31.3157',
        latitude: '30.0444',
        createdAt: DateTime.now().subtract(Duration(days: 180)),
        updatedAt: DateTime.now().subtract(Duration(days: 10)),
        status: 'active',
        isCurrent: true,
        isEnded: false,
        client: Client(
          id: 100,
          name: 'شركة النموذج التجريبي',
          phone: '01234567890',
          email: 'demo@example.com',
          createdAt: DateTime.now().subtract(Duration(days: 365)),
          updatedAt: DateTime.now().subtract(Duration(days: 30)),
        ),
      ),
      ContractModel(
        id: 2,
        clientId: 100,
        contractNumber: 'CNT-2024-002',
        contractSectionId: 2,
        startDate: DateTime.now().subtract(Duration(days: 90)),
        endDate: DateTime.now().add(Duration(days: 275)),
        contractDurationId: 1,
        contractPrice: '75000',
        elevatorTypeId: 2,
        elevatorModelId: 3,
        location: 'القاهرة - التجمع الخامس - شارع التسعين',
        longitude: '31.4486',
        latitude: '30.0131',
        createdAt: DateTime.now().subtract(Duration(days: 90)),
        updatedAt: DateTime.now().subtract(Duration(days: 5)),
        status: 'active',
        isCurrent: true,
        isEnded: false,
        client: Client(
          id: 100,
          name: 'شركة النموذج التجريبي',
          phone: '01234567890',
          email: 'demo@example.com',
          createdAt: DateTime.now().subtract(Duration(days: 365)),
          updatedAt: DateTime.now().subtract(Duration(days: 30)),
        ),
      ),
      ContractModel(
        id: 3,
        clientId: 100,
        contractNumber: 'CNT-2023-015',
        contractSectionId: 1,
        startDate: DateTime.now().subtract(Duration(days: 400)),
        endDate: DateTime.now().subtract(Duration(days: 35)),
        contractDurationId: 1,
        contractPrice: '45000',
        elevatorTypeId: 1,
        elevatorModelId: 2,
        location: 'الجيزة - المهندسين - شارع جامعة الدول',
        longitude: '31.2001',
        latitude: '30.0626',
        createdAt: DateTime.now().subtract(Duration(days: 400)),
        updatedAt: DateTime.now().subtract(Duration(days: 35)),
        status: 'expired',
        isCurrent: false,
        isEnded: true,
        client: Client(
          id: 100,
          name: 'شركة النموذج التجريبي',
          phone: '01234567890',
          email: 'demo@example.com',
          createdAt: DateTime.now().subtract(Duration(days: 365)),
          updatedAt: DateTime.now().subtract(Duration(days: 30)),
        ),
      ),
    ];
  }

  /// الحصول على بيانات تجريبية للتقارير
  static List<ReportModel> getDummyReports() {
    final contracts = getDummyContracts();

    // Helper function to convert ContractModel to Contract for ReportModel
    Contract contractModelToContract(ContractModel model) {
      return Contract(
        id: model.id,
        clientId: model.clientId,
        contractNumber: model.contractNumber,
        contractSectionId: model.contractSectionId,
        startDate: model.startDate,
        endDate: model.endDate,
        contractDurationId: model.contractDurationId,
        contractPrice: model.contractPrice,
        elevatorTypeId: model.elevatorTypeId,
        elevatorModelId: model.elevatorModelId,
        location: model.location,
        longitude: model.longitude,
        latitude: model.latitude,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
        status: model.status,
        isCurrent: model.isCurrent,
        isEnded: model.isEnded,
        client:
            model.client != null
                ? ReportClient.Client(
                  id: model.client!.id,
                  name: model.client!.name,
                  phone: model.client!.phone,
                  email: model.client!.email,
                  createdAt: model.client!.createdAt,
                  updatedAt: model.client!.updatedAt,
                )
                : null,
      );
    }

    return [
      ReportModel(
        id: 1,
        contractId: 1,
        technicianId: 50,
        reportType: 'صيانة دورية',
        questionsAnswers: [
          QuestionsAnswer(
            questionId: 1,
            question: 'حالة المصعد',
            answerType: 1,
            answer: 'ممتاز',
          ),
          QuestionsAnswer(
            questionId: 2,
            question: 'هل توجد مشاكل؟',
            answerType: 1,
            answer: 'لا توجد مشاكل',
          ),
          QuestionsAnswer(
            questionId: 3,
            question: 'حالة التشحيم',
            answerType: 1,
            answer: 'تم التشحيم بنجاح',
          ),
        ],
        image: null,
        pdfPath: '/reports/CNT-2024-001-report-1.pdf',
        createdAt: DateTime.now().subtract(Duration(days: 15)),
        updatedAt: DateTime.now().subtract(Duration(days: 15)),
        contract: contractModelToContract(contracts[0]),
        technician: Technician(
          id: 50,
          name: 'أحمد محمد',
          phone: '01098765432',
          email: 'ahmed.tech@fuji.com',
          status: 'active',
          createdAt: DateTime.now().subtract(Duration(days: 200)),
          updatedAt: DateTime.now().subtract(Duration(days: 20)),
        ),
      ),
      ReportModel(
        id: 2,
        contractId: 1,
        technicianId: 51,
        reportType: 'صيانة طارئة',
        questionsAnswers: [
          QuestionsAnswer(
            questionId: 1,
            question: 'نوع العطل',
            answerType: 1,
            answer: 'تم إصلاح العطل',
          ),
          QuestionsAnswer(
            questionId: 2,
            question: 'الإجراءات المتخذة',
            answerType: 1,
            answer: 'استبدال قطع غيار',
          ),
        ],
        image: null,
        pdfPath: '/reports/CNT-2024-001-report-2.pdf',
        createdAt: DateTime.now().subtract(Duration(days: 45)),
        updatedAt: DateTime.now().subtract(Duration(days: 45)),
        contract: contractModelToContract(contracts[0]),
        technician: Technician(
          id: 51,
          name: 'محمد علي',
          phone: '01087654321',
          email: 'mohamed.tech@fuji.com',
          status: 'active',
          createdAt: DateTime.now().subtract(Duration(days: 300)),
          updatedAt: DateTime.now().subtract(Duration(days: 50)),
        ),
      ),
      ReportModel(
        id: 3,
        contractId: 2,
        technicianId: 50,
        reportType: 'صيانة دورية',
        questionsAnswers: [
          QuestionsAnswer(
            questionId: 1,
            question: 'حالة المصعد',
            answerType: 1,
            answer: 'جيد جداً',
          ),
          QuestionsAnswer(
            questionId: 2,
            question: 'حالة الكابلات',
            answerType: 1,
            answer: 'حالة الكابلات جيدة',
          ),
          QuestionsAnswer(
            questionId: 3,
            question: 'الفحص الشامل',
            answerType: 1,
            answer: 'تم الفحص الشامل',
          ),
        ],
        image: null,
        pdfPath: '/reports/CNT-2024-002-report-1.pdf',
        createdAt: DateTime.now().subtract(Duration(days: 10)),
        updatedAt: DateTime.now().subtract(Duration(days: 10)),
        contract: contractModelToContract(contracts[1]),
        technician: Technician(
          id: 50,
          name: 'أحمد محمد',
          phone: '01098765432',
          email: 'ahmed.tech@fuji.com',
          status: 'active',
          createdAt: DateTime.now().subtract(Duration(days: 200)),
          updatedAt: DateTime.now().subtract(Duration(days: 20)),
        ),
      ),
      ReportModel(
        id: 4,
        contractId: 2,
        technicianId: 52,
        reportType: 'فحص دوري',
        questionsAnswers: [
          QuestionsAnswer(
            questionId: 1,
            question: 'التقييم العام',
            answerType: 1,
            answer: 'ممتاز',
          ),
          QuestionsAnswer(
            questionId: 2,
            question: 'نظام السلامة',
            answerType: 1,
            answer: 'نظام السلامة يعمل بكفاءة',
          ),
        ],
        image: null,
        pdfPath: '/reports/CNT-2024-002-report-2.pdf',
        createdAt: DateTime.now().subtract(Duration(days: 30)),
        updatedAt: DateTime.now().subtract(Duration(days: 30)),
        contract: contractModelToContract(contracts[1]),
        technician: Technician(
          id: 52,
          name: 'خالد حسن',
          phone: '01076543210',
          email: 'khaled.tech@fuji.com',
          status: 'active',
          createdAt: DateTime.now().subtract(Duration(days: 400)),
          updatedAt: DateTime.now().subtract(Duration(days: 60)),
        ),
      ),
      ReportModel(
        id: 5,
        contractId: 3,
        technicianId: 51,
        reportType: 'صيانة نهائية',
        questionsAnswers: [
          QuestionsAnswer(
            questionId: 1,
            question: 'حالة العقد',
            answerType: 1,
            answer: 'تم إنهاء العقد',
          ),
          QuestionsAnswer(
            questionId: 2,
            question: 'حالة التسليم',
            answerType: 1,
            answer: 'تسليم المصعد في حالة جيدة',
          ),
        ],
        image: null,
        pdfPath: '/reports/CNT-2023-015-final-report.pdf',
        createdAt: DateTime.now().subtract(Duration(days: 35)),
        updatedAt: DateTime.now().subtract(Duration(days: 35)),
        contract: contractModelToContract(contracts[2]),
        technician: Technician(
          id: 51,
          name: 'محمد علي',
          phone: '01087654321',
          email: 'mohamed.tech@fuji.com',
          status: 'active',
          createdAt: DateTime.now().subtract(Duration(days: 300)),
          updatedAt: DateTime.now().subtract(Duration(days: 50)),
        ),
      ),
    ];
  }
}

/// Interceptor لعرض رسالة تسجيل الدخول عند محاولة التفاعل في وضع الضيف
class GuestModeInterceptor {
  /// التحقق قبل تنفيذ أي إجراء يتطلب تسجيل دخول
  static bool checkAndShowLoginDialog(BuildContext context) {
    if (GuestModeProvider.isGuestMode) {
      GuestModeProvider.showLoginRequiredDialog(context);
      return false; // يمنع تنفيذ الإجراء
    }
    return true; // يسمح بتنفيذ الإجراء
  }
}
