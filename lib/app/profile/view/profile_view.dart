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

import '../../home/globalCubit/global_cubit.dart';
import '../model/profile_update_response.dart';

class ProfileView extends ProfileViewModel {
  @override
  void initState() {
    BlocProvider.of<GlobalCubit>(context).getTitle('Profile',2);

    super.initState();
  }
  @override
  bool get wantKeepAlive => true;
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerCode = TextEditingController();

  // ProfileService get homeViewModel => context.read<ProfileService>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorState) {
          return Center(
            child: CircularProgressIndicator(),
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
                        height: 90,
                        width: 90,
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
                                width: 40,
                                height: 40,
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.white,
                                child: ClipRect(
                                    child: Image.network(
                                  (state.profileModel.avatar)!,
                                  height: 40,
                                  width: 40,
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
                        onTap: (){
                          try {
                            FilePicker.platform
                                .pickFiles(
                              type: FileType.image,
                            )
                                .then((result) async {
                              if (result != null &&
                                  result.files.single.path != null) {
                                final filePath = result.files.single.path;
                                final path = File(filePath!);
                                BlocProvider.of<AvatarCubit>(context)
                                    .uploadAvatar(path);
                              }
                            });
                          } catch (e) {}
                        },
                        child:(_state is UpLoadLoadingState)
                            ? CircularProgressIndicator()
                            : Center(
                          child:(state.profileModel.avatar ?? '').isEmpty?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/images/Iconly-Bold-Edit.svg',width: 16,),
                                  SizedBox(width: 4,),
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
