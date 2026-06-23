import 'dart:io';
import 'package:O2morny/core/exceptions/app_exception.dart';
import 'package:O2morny/core/routing/auth_state.dart';
import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:O2morny/features/account/data/models/account_dto.dart';
import 'package:O2morny/features/auth/data/models/role_dto.dart';
import 'package:O2morny/features/auth/data/services/auth_service.dart';
import 'package:O2morny/features/auth/data/services/auth_storage_service.dart';
import 'package:O2morny/features/city/data/services/city_service.dart';
import 'package:O2morny/features/country/data/services/country_service.dart';
import 'package:O2morny/features/home/presentation/pages/home.dart';
import 'package:O2morny/shared/models/app_colors.dart';
import 'package:O2morny/shared/widgets/custom_toast.dart';
import 'package:O2morny/features/account/data/models/create_account_request.dart';
import 'package:O2morny/features/account/data/services/account_service.dart';
import 'package:O2morny/features/account/presentation/widgets/form_section.dart';
import 'package:O2morny/features/city/data/models/city_dto.dart';
import 'package:O2morny/features/country/data/models/country_dto.dart';
import 'package:O2morny/shared/widgets/custom-app_bar.dart';
import 'package:O2morny/shared/widgets/app_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  static const route = "/create-account";

  @override
  State<CreateAccountPage> createState() => CreateAccountPageState();
}

class CreateAccountPageState extends State<CreateAccountPage> {
  final AccountService accountService = getIt<AccountService>();
  final CountryService countryService = getIt<CountryService>();
  final CityService cityService = getIt<CityService>();
  final AuthService authService = getIt<AuthService>();
  final AuthStorageService authStorageService = getIt<AuthStorageService>();
  final AuthState authState = getIt<AuthState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final nationalIdController = TextEditingController();
  final addressController = TextEditingController();

  DateTime? selectedDate;
  bool hideBirthDate = false;
  bool acceptTerms = false;
  bool acceptPrivacy = false;

  File? profilePicture;
  File? nationalIdImage;

  List<CountryDto> countries = [];
  CountryDto? selectedCountry;
  List<CityDto> cities = [];
  CityDto? selectedCity;
  List<RoleDto> roles = [];
  RoleDto? selectedRole;

  Map<String, List<String>> serverErrors = {};

  bool isLoading = true;
  bool isSubmitting = false;

  String? profilePictureError;
  String? nationalIdImageError;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      roles = await authService.getRoles();
      countries = await countryService.getAll();

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    nationalIdController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Light,
      appBar: const CustomAppBar(title: "Create Account", showBack: true),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(color: AppColors.PrimaryGold),
              )
            : Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteractionIfError,
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      FormSection(
                        nameController: nameController,
                        nationalIdController: nationalIdController,
                        addressController: addressController,
                        selectedDate: selectedDate,
                        hideBirthDate: hideBirthDate,
                        selectedCountry: selectedCountry,
                        countries: countries,
                        selectedCity: selectedCity,
                        cities: cities,
                        selectedRole: selectedRole,
                        roles: roles,
                        acceptTerms: acceptTerms,
                        acceptPrivacy: acceptPrivacy,
                        onBirthDateSelect: onBirthDateSelect,
                        onHideBirthDateChanged: (v) =>
                            setState(() => hideBirthDate = v),
                        onCountrySelect: onCountrySelect,
                        onCitySelect: (v) => setState(() => selectedCity = v),
                        onRoleSelect: (v) => setState(() => selectedRole = v),
                        onFieldChanged: onFieldChanged,
                        selectedProfilePicture: profilePicture,
                        onProfilePictureSelect: pickProfileImage,
                        selectedNationalIdImage: nationalIdImage,
                        onNationalIdImageSelect: pickNationalIdImage,
                        onAcceptTermsChanged: (v) =>
                            setState(() => acceptTerms = v),
                        onAcceptPrivacyChanged: (v) =>
                            setState(() => acceptPrivacy = v),
                        profilePictureError: profilePictureError,
                        nationalIdImageError: nationalIdImageError,
                        serverErrors: serverErrors,
                      ),

                      const SizedBox(height: 24),

                      AppSubmitButton(
                        isSubmitting: isSubmitting,
                        text: "Save",
                        onPressed: createAccount,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> pickProfileImage() async {
    profilePictureError = null;

    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 85,
    );

    if (image == null) return;

    setState(() => profilePicture = File(image.path));
  }

  Future<void> pickNationalIdImage() async {
    nationalIdImageError = null;

    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 85,
    );

    if (image == null) return;

    setState(() => nationalIdImage = File(image.path));
  }

  void onBirthDateSelect(DateTime dateTime) {
    setState(() {
      selectedDate = dateTime;
    });
  }

  Future<void> onCountrySelect(CountryDto country) async {
    cities = await cityService.getAll(country.Id);
    setState(() {
      selectedCountry = country;
      selectedCity = null;
    });
  }

  void onFieldChanged(field) {
    if (serverErrors.containsKey(field)) {
      setState(() {
        serverErrors.remove(field);
      });
    }
  }

  Future<void> createAccount() async {
    FocusScope.of(context).unfocus();

    setState(() {
      profilePictureError = profilePicture == null
          ? "Profile picture is required"
          : null;
    });

    setState(() {
      nationalIdImageError = nationalIdImage == null
          ? "NationalId is required"
          : null;
    });

    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    final request = CreateAccountRequest(
      Name: nameController.text.trim(),
      NationalId: nationalIdController.text.trim(),
      DateOfBirth: selectedDate!,
      HideBirthDate: hideBirthDate,
      CityId: selectedCity!.Id,
      Address: addressController.text.trim(),
      IsAcceptTerms: acceptTerms,
      IsAcceptPrivacy: acceptPrivacy,
      NationalIdPictureFile: nationalIdImage!,
      ProfilePictureFile: profilePicture!,
      Role: selectedRole!.Name,
    );

    try {
      AccountDto model = await accountService.create(request);

      await authStorageService.saveAccount(model);

      authState.account = model;
      authState.notifyListeners();

      if (context.mounted) {
        GoRouter.of(context).go(HomePage.route);
      }
    } on AppException catch (e) {
      if (context.mounted) {
        setState(() {
          serverErrors = (e.errors ?? {}).map(
            (key, value) => MapEntry(key.toString(), List<String>.from(value)),
          );
        });
      }
    } catch (e) {
      if (context.mounted) {
        CustomToast.error(context, "Something went wrong");
      }
    } finally {
      setState(() => isSubmitting = false);
    }
  }
}
