import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/service/webservice/api_service.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../../core/widgets/language_switcher_widget.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/profile_response_entity.dart';
import '../../domain/entities/user_entity.dart';
import 'edit_profile_screen.dart';

/// Settings screen that displays user information and settings
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.showAppBar = true});

  final bool showAppBar;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ProfileResponseEntity? _profileData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  /// Loads profile data from API
  Future<void> _loadProfileData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final authRepository = AuthRepositoryImpl(
        apiService: getIt<ApiService>(),
      );

      final result = await authRepository.getProfile();

      result.fold(
        (failure) {
          setState(() {
            _errorMessage = failure.message;
            _isLoading = false;
          });
        },
        (profileData) {
          setState(() {
            _profileData = profileData;
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar:
          widget.showAppBar
              ? CustomAppBarWidget(title: AppStrings.profile.tr)
              : null,
      body: _buildBody(),
    );
  }

  /// Builds the main body content
  Widget _buildBody() {
    if (_isLoading) {
      return const CustomLoadingIndicator(color: AppColor.primary);
    }

    if (_errorMessage != null) {
      return _buildErrorState();
    }

    if (_profileData == null) {
      return _buildEmptyState();
    }

    return _buildProfileContent();
  }

  /// Builds error state widget
  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColor.error),
          const SizedBox(height: 16),
          Text(
            'Error Loading Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _errorMessage!,
            style: TextStyle(fontSize: 16, color: AppColor.grey2),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loadProfileData,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              foregroundColor: AppColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  /// Builds empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline, size: 64, color: AppColor.grey2),
          const SizedBox(height: 16),
          Text(
            'No Profile Data',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Unable to load profile information',
            style: TextStyle(fontSize: 16, color: AppColor.grey2),
          ),
        ],
      ),
    );
  }

  /// Builds the profile content
  Widget _buildProfileContent() {
    final user = _profileData!.user;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildProfileHeader(user),
          const SizedBox(height: 24),
          _buildLanguageSettings(),
          const SizedBox(height: 24),
          _buildProfileDetails(user),
          const SizedBox(height: 24),
          _buildAccountInfo(user),
          const SizedBox(height: 24),
          _buildAccountActions(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// Builds the profile header with avatar and basic info
  Widget _buildProfileHeader(UserEntity user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey3.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Avatar with Edit Button
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primaryLight,
                  border: Border.all(color: AppColor.primary, width: 3),
                ),
                child:
                    user.image != null
                        ? ClipOval(
                          child: Image.network(
                            user.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                size: 50,
                                color: AppColor.white,
                              );
                            },
                          ),
                        )
                        : Icon(Icons.person, size: 50, color: AppColor.white),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _navigateToEditProfile,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColor.white, width: 2),
                    ),
                    child: Icon(Icons.edit, size: 16, color: AppColor.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // User Name
          Text(
            user.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 8),
          // User Type Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _profileData!.userType.toUpperCase(),
              style: TextStyle(
                color: AppColor.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds profile details section
  Widget _buildProfileDetails(UserEntity user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey3.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.profileDetails.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.email, AppStrings.email.tr, user.email),
          _buildInfoRow(Icons.phone, AppStrings.phone.tr, user.phone),
          if (user.location != null)
            _buildInfoRow(
              Icons.location_on,
              AppStrings.location.tr,
              user.location!,
            ),
          _buildInfoRow(
            Icons.verified_user,
            AppStrings.status.tr,
            user.status,
            statusColor:
                user.status.toLowerCase() == 'active'
                    ? AppColor.success
                    : AppColor.warning,
          ),
        ],
      ),
    );
  }

  /// Builds account information section
  Widget _buildAccountInfo(UserEntity user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey3.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.accountInformation.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.calendar_today,
            AppStrings.memberSince.tr,
            _formatDate(user.createdAt),
          ),
          _buildInfoRow(
            Icons.update,
            AppStrings.lastUpdated.tr,
            _formatDate(user.updatedAt),
          ),
          if (user.phoneVerifiedAt != null)
            _buildInfoRow(
              Icons.verified,
              AppStrings.phoneVerified.tr,
              _formatDate(user.phoneVerifiedAt!),
            ),
        ],
      ),
    );
  }

  /// Builds a single info row
  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    Color? statusColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColor.primaryLight.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: statusColor ?? AppColor.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.grey2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: statusColor ?? AppColor.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Formats date for display
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Builds language settings section
  Widget _buildLanguageSettings() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey3.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.languageSettings.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 16),
          const LanguageSwitcherWidget(isExpanded: true),
        ],
      ),
    );
  }

  /// Builds account actions section (logout and delete account)
  Widget _buildAccountActions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey3.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.accountActions.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            icon: Icons.logout,
            title: AppStrings.logout.tr,
            subtitle: AppStrings.signOutOfYourAccount.tr,
            color: AppColor.primary,
            onTap: _showLogoutDialog,
          ),
        ],
      ),
    );
  }

  /// Builds an action button
  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.grey3, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: AppColor.grey2),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColor.grey2),
          ],
        ),
      ),
    );
  }

  /// Shows logout confirmation dialog
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: AppColor.primary, size: 24),
              const SizedBox(width: 8),
              Text(
                AppStrings.logout.tr,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            AppStrings.logoutConfirmation.tr,
            style: TextStyle(color: AppColor.grey2, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                AppStrings.cancel.tr,
                style: TextStyle(
                  color: AppColor.grey2,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _performLogout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: AppColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: Text(
                AppStrings.logout.tr,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Shows delete account confirmation dialog
  // void _showDeleteAccountDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         title: Row(
  //           children: [
  //             Icon(Icons.delete_forever, color: AppColor.error, size: 24),
  //             const SizedBox(width: 8),
  //             Text(
  //               'Delete Account',
  //               style: TextStyle(
  //                 color: AppColor.black,
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ],
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'This action cannot be undone. This will permanently delete your account and remove all your data from our servers.',
  //               style: TextStyle(color: AppColor.grey2, fontSize: 16),
  //             ),
  //             const SizedBox(height: 12),
  //             Text(
  //               'Are you absolutely sure?',
  //               style: TextStyle(
  //                 color: AppColor.error,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: Text(
  //               'Cancel',
  //               style: TextStyle(
  //                 color: AppColor.grey2,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               Navigator.of(context).pop();
  //               await _performDeleteAccount();
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: AppColor.error,
  //               foregroundColor: AppColor.white,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 16,
  //                 vertical: 8,
  //               ),
  //             ),
  //             child: Text(
  //               'Delete Account',
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  /// Performs logout operation
  Future<void> _performLogout() async {
    if (!mounted) return;

    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                CustomLoadingIndicator(color: AppColor.primary),
                const SizedBox(width: 16),
                Text('Logging out...'),
              ],
            ),
          );
        },
      );

      // Call logout API
      final authRepository = AuthRepositoryImpl(
        apiService: getIt<ApiService>(),
      );

      final result = await authRepository.logout();

      // Close loading dialog
      if (mounted) {
        Navigator.of(context).pop();

        result.fold(
          (failure) {
            _showErrorSnackBar('Logout failed: ${failure.message}');
          },
          (success) {
            _showSuccessSnackBar('Logged out successfully');
            // Navigate to login screen
            context.go(Routes.accountTypeSelection);
          },
        );
      }
    } catch (e) {
      // Close loading dialog if it's open
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      if (mounted) {
        _showErrorSnackBar('Logout failed: $e');
      }
    }
  }

  /// Performs delete account operation
  Future<void> _performDeleteAccount() async {
    if (!mounted) return;

    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                CustomLoadingIndicator(color: AppColor.error),
                const SizedBox(width: 16),
                Text('Deleting account...'),
              ],
            ),
          );
        },
      );

      // Call delete account API
      final authRepository = AuthRepositoryImpl(
        apiService: getIt<ApiService>(),
      );

      final result = await authRepository.deleteAccount();

      // Close loading dialog
      if (mounted) {
        Navigator.of(context).pop();

        result.fold(
          (failure) {
            _showErrorSnackBar('Account deletion failed: ${failure.message}');
          },
          (success) {
            _showSuccessSnackBar('Account deleted successfully');
            // Navigate to login screen
            context.go(Routes.accountTypeSelection);
          },
        );
      }
    } catch (e) {
      // Close loading dialog if it's open
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      if (mounted) {
        _showErrorSnackBar('Account deletion failed: $e');
      }
    }
  }

  /// Shows error snackbar
  void _showErrorSnackBar(String message) {
    context.showError(message);
  }

  /// Shows success snackbar
  void _showSuccessSnackBar(String message) {
    context.showSuccess(message);
  }

  /// Navigates to edit profile screen
  void _navigateToEditProfile() async {
    if (_profileData == null) return;

    final result = await Navigator.of(context).push<ProfileResponseEntity>(
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(profileData: _profileData!),
      ),
    );

    // If profile was updated, refresh the data
    if (result != null && mounted) {
      setState(() {
        _profileData = result;
      });
    }
  }
}
