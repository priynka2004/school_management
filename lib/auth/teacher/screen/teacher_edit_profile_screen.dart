import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/teacher/model/teacher_model.dart';
import '../../../auth/teacher/provider/teacher_edit_profile_provider.dart';
import '../../../auth/teacher/provider/teacher_provider.dart';
import '../../../utils/colors.dart';

class TeacherEditProfileScreen extends StatefulWidget {
  const TeacherEditProfileScreen({super.key});

  @override
  State<TeacherEditProfileScreen> createState() => _TeacherEditProfileScreenState();
}

class _TeacherEditProfileScreenState extends State<TeacherEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController fatherNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController passwordController;
  late TextEditingController dobController;
  late TextEditingController genderController;
  late TextEditingController categoryIdController;
  late TextEditingController religionController;
  late TextEditingController qualificationController;
  late TextEditingController experienceController;
  late TextEditingController previousSchoolController;
  late TextEditingController addressController;
  late TextEditingController branchIdController;
  late TextEditingController photoController;
  late TextEditingController documentController;

  @override
  void initState() {
    super.initState();
    final profile = Provider.of<TeacherProvider>(context, listen: false).profile!;

    nameController = TextEditingController(text: profile.name);
    fatherNameController = TextEditingController(text: profile.fatherName);
    emailController = TextEditingController(text: profile.email);
    mobileController = TextEditingController(text: profile.mobile);
    passwordController = TextEditingController(text: profile.password);
    dobController = TextEditingController(text: profile.dob);
    genderController = TextEditingController(text: profile.gender);
    categoryIdController = TextEditingController(text: profile.categoryId);
    religionController = TextEditingController(text: profile.religion);
    qualificationController = TextEditingController(text: profile.qualification);
    experienceController = TextEditingController(text: profile.experience);
    previousSchoolController = TextEditingController(text: profile.previousSchool);
    addressController = TextEditingController(text: profile.address);
    branchIdController = TextEditingController(text: profile.branchId);
    photoController = TextEditingController(text: profile.photo);
    documentController = TextEditingController(text: profile.document);
  }

  @override
  void dispose() {
    nameController.dispose();
    fatherNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    dobController.dispose();
    genderController.dispose();
    categoryIdController.dispose();
    religionController.dispose();
    qualificationController.dispose();
    experienceController.dispose();
    previousSchoolController.dispose();
    addressController.dispose();
    branchIdController.dispose();
    photoController.dispose();
    documentController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final profile = Provider.of<TeacherProvider>(context, listen: false).profile!;

      final data = {
        'TeacherID': profile.id.toString(),
        'BranchID': profile.branchId.trim(),
        'UpdatedBy': profile.id.toString(),

        'Name': nameController.text.trim(),
        'FatherName': fatherNameController.text.trim(),
        'Email': emailController.text.trim(),
        'Mobile': mobileController.text.trim(),
        'Password': passwordController.text.trim(),
        'DOB': dobController.text.trim(),
        'Gender': genderController.text.trim(),
        'CategoryID': categoryIdController.text.trim(),
        'Religion': religionController.text.trim(),
        'Qualification': qualificationController.text.trim(),
        'Experience': experienceController.text.trim(),
        'PreviousSchool': previousSchoolController.text.trim(),
        'Address': addressController.text.trim(),
        'Photo': photoController.text.trim(),
        'Document': documentController.text.trim(),
      };


      final provider = Provider.of<TeacherEditProfileProvider>(context, listen: false);
      await provider.updateProfile(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TeacherEditProfileProvider>();

    if (provider.status == UpdateStatus.success) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        provider.reset();
        Navigator.pop(context);
      });
    } else if (provider.status == UpdateStatus.failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(provider.errorMessage ?? 'Update failed')),
        );
        provider.reset();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.west, color: AppColors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Name", nameController),
              _buildTextField("Father Name", fatherNameController),
              _buildTextField("Email", emailController),
              _buildTextField("Mobile", mobileController),
              _buildTextField("Password", passwordController),
              _buildTextField("DOB", dobController),
              _buildTextField("Gender", genderController),
              _buildTextField("Category ID", categoryIdController),
              _buildTextField("Religion", religionController),
              _buildTextField("Qualification", qualificationController),
              _buildTextField("Experience", experienceController),
              _buildTextField("Previous School", previousSchoolController),
              _buildTextField("Address", addressController),
          //    _buildTextField("Branch ID", branchIdController),
              _buildTextField("Photo", photoController),
              _buildTextField("Document", documentController),
              const SizedBox(height: 20),

              provider.status == UpdateStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: _submit,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }
}
