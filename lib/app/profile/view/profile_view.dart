import 'dart:io';

import 'package:aimedic/app/profile/cubit/avatar_cubit.dart';
import 'package:aimedic/app/profile/cubit/profile_cubit.dart';
import 'package:aimedic/core/widgets/rounded_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:aimedic/app/profile/viewModel/profile_view_model.dart';
import 'package:aimedic/core/widgets/rounded_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/loading.dart';
import '../../home/globalCubit/global_cubit.dart';
import '../model/profile_update_response.dart';

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);

class ProfileView extends ProfileViewModel {
  @override
  void initState() {
    BlocProvider.of<GlobalCubit>(context).getTitle('Profile', 2);

    super.initState();
  }

  @override
  bool get wantKeepAlive => true;
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerCode = TextEditingController();

  dynamic _pickImageError;
  bool isVideo = false;

  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  // ProfileService get homeViewModel => context.read<ProfileService>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: Container(
                color: AppColors.loadingBg,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Loading.loading),
          );
        } else if (state is ErrorState) {
          return Center(
            child: Container(
                color: AppColors.loadingBg,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Loading.loading),
          );
        } else if (state is LoadedState) {
          final profile = state.profileModel;
          controllerName.text = profile.fullName ?? '';

          return BlocBuilder<AvatarCubit, AvatarState>(
            builder: (context, _state) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.maxFinite,
                      child: Container(
                        height: 100,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white70,
                              width: 1,
                            ),
                            shape: BoxShape.circle),
                        child: (state.profileModel.avatar ?? '').isEmpty
                            ? SvgPicture.asset(
                                'assets/images/Iconly-Bold-Add User.svg',
                                width: 30,
                                height: 30,
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.white,
                                child: ClipRect(
                                    child: Image.network(
                                  (state.profileModel.avatar)!,
                                  height: 95,
                                  width: 95,
                                )),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: double.maxFinite,
                      child: GestureDetector(
                        onTap: () async {
                            try {
                              final pickedFile = await _picker.pickImage(
                                source: ImageSource.gallery,
                                maxWidth: 80,
                                maxHeight: 80,
                                imageQuality: 25,
                              );
                              _imageFile = pickedFile;
                              BlocProvider.of<AvatarCubit>(context).uploadAvatar(File(pickedFile!.path));

                            } catch (e) {
                              setState(() {
                                print(e);
                                _pickImageError = e;
                              });
                            }
                        },
                        child: (_state is UpLoadLoadingState)
                            ? Container(
                                color: AppColors.loadingBg,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Loading.loading)
                            : Center(
                                child: (state.profileModel.avatar ?? '').isEmpty
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/Iconly-Bold-Edit.svg',
                                            width: 16,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            'Change image',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        'Profile image',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Full name',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    RoundedInputFieldtext(
                      onChanged: (String value) {
                        if (value.length == 11 &&
                            value.substring(0, 2).contains('09')) {}
                      },
                      keyboardType: TextInputType.text,
                      controller: controllerName,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Medical system code',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    RoundedInputFieldtext(
                      onChanged: (String value) {
                        if (value.length == 11 &&
                            value.substring(0, 2).contains('09')) {}
                      },
                      controller: controllerCode,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedButton(
                      text: "Submit",
                      press: () {
                        BlocProvider.of<ProfileCubit>(context).updateProfile(
                            ProfileUploadResponse(
                                fullName: controllerName.text,
                                avatar: controllerCode.text,
                                gmcNumber: state.profileModel.avatar ?? ''));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

}
