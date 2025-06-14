import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/teacher/model/teacher_model.dart';
import 'package:school_management/auth/teacher/provider/teacher_provider.dart';
import 'package:school_management/auth/teacher/screen/teacher_edit_profile_screen.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';

class TeacherProfile extends StatefulWidget {
  final int teacherId;
  const TeacherProfile({super.key, required this.teacherId});

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<TeacherProvider>(context, listen: false);
      provider.loadProfile(widget.teacherId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TeacherProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }

          final TeacherProfileModel? profile = provider.profile;

          if (profile == null) {
            return const Center(child: Text('No profile data'));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      AppImagesConst.vectorImagePath,
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only( left: 10,top: 24 ),
                      child: Builder(
                        builder: (context) => GestureDetector(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: Stack(
                          children: [
                            Image.asset(
                              AppImagesConst.vectorImagePath2,
                              height: 260,
                              width: 240,
                              fit: BoxFit.contain,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 60, left: 50),
                              child: Image.asset(
                                AppImagesConst.rectangleImagePath,
                                height: MediaQuery.of(context).size.height * 0.16,
                                width: MediaQuery.of(context).size.width * 0.35,
                                fit: BoxFit.contain,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Profile Info Cards with Divider
                ProfileInfoCard(profile: profile),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appColor,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherEditProfileScreen(),
                        ),
                      );
                    },
                    child: Text('Request Edit', style: AppTextStyles.loginButton),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final TeacherProfileModel profile;
  const ProfileInfoCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final fields = [
      {"label": "Full Name", "value": profile.name},
      {"label": "Father Name", "value": profile.fatherName},
      {"label": "Email", "value": profile.email},
      {"label": "Mobile", "value": profile.mobile},
     // {"label": "ID", "value": profile.id.toString()},
      {"label": "Password", "value": profile.password},
      {"label": "DOB", "value": profile.dob},
      {"label": "Gender", "value": profile.gender},
      {"label": "Category ID", "value": profile.categoryId},
      {"label": "Religion", "value": profile.religion},
      {"label": "Qualification", "value": profile.qualification},
      {"label": "Experience", "value": profile.experience},
      {"label": "Previous School", "value": profile.previousSchool},
      {"label": "Address", "value": profile.address},
   //   {"label": "Branch ID", "value": profile.branchId},
      {"label": "Photo", "value": profile.photo},
      {"label": "Document", "value": profile.document},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: fields.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final field = fields[index];
            return ProfileInfo(label: field["label"]!, value: field["value"]!);
          },
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        Expanded(child: Text(value)),
      ],
    );
  }
}
