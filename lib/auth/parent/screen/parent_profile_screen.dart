import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/parent/model/parent_profile.dart';
import 'package:school_management/auth/parent/provider/parent_profile_provider.dart';
import 'package:school_management/auth/parent/screen/edit_parent_profile_sheet.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';

class ParentProfileScreen extends StatefulWidget {
  final int parentId;

  const ParentProfileScreen({super.key, required this.parentId});

  @override
  _ParentProfileScreenState createState() => _ParentProfileScreenState();
}

class _ParentProfileScreenState extends State<ParentProfileScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ParentProfileProvider>(context, listen: false);
    provider.loadProfile(widget.parentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ParentProfileProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }

          final profile = provider.profile;
          if (profile == null) {
            return Center(child: Text('No profile data'));
          }

          return Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    AppImagesConst.vectorImagePath,
                    height: MediaQuery.of(context).size.height * 0.25, // 25% of screen height
                    width: double.infinity,
                    fit: BoxFit.cover,
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
              const SizedBox(height: 40),
              ProfileInfo(label: "Full Name", value: profile.name),
              ProfileInfo(label: "Roll No", value: profile.email),
              ProfileInfo(label: "Address", value: profile.address),
              ProfileInfo(label: "Guardian’s Contact", value: profile.mobile),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appColor,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return EditParentProfileSheet(profile: provider.profile);
                    }));

                  },
                  child: Text('Request Edit',style: AppTextStyles.loginButton,),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}