import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../View Model/home_cubit.dart';
import 'Widgets/Home Text Form Field.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: const Text('Portfolio Generator')),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocConsumer<HomeCubit, HomeState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: width * .9,
                      child: Text(
                        HomeCubit.get(context).nameController.text,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: height * .025,
                ),
                MyTextFormField(
                  onChange: () {
                    HomeCubit.get(context).changeName('');
                  },
                  textEditingController: HomeCubit.get(context).nameController,
                  hintText: 'name',
                ),
                SizedBox(
                  height: height * .025,
                ),
                MyTextFormField(
                  onChange: () {},
                  textEditingController:
                      HomeCubit.get(context).jobTitleController,
                  hintText: 'Jop title',
                ),
                SizedBox(
                  height: height * .025,
                ),
                SizedBox(
                  width: width * .9,
                  child: const Text(
                    'Contact',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: height * .025,
                ),
                MyTextFormField(
                  onChange: () {},
                  textEditingController: HomeCubit.get(context).emailController,
                  hintText: 'Email',
                ),
                SizedBox(
                  height: height * .025,
                ),
                MyTextFormField(
                  onChange: () {},
                  textEditingController: HomeCubit.get(context).phoneController,
                  hintText: 'phone number',
                ),
                SizedBox(
                  height: height * .025,
                ),
                MyTextFormField(
                  onChange: () {},
                  textEditingController:
                      HomeCubit.get(context).linkedInController,
                  hintText: 'linked in',
                ),
                SizedBox(
                  height: height * .025,
                ),
                SizedBox(
                  width: width * .9,
                  child: const Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: height * .025,
                ),
                MyTextFormField(
                  onChange: () {},
                  textEditingController:
                      HomeCubit.get(context).profileController,
                  hintText: 'Profile',
                ),
                SizedBox(
                  height: height * .025,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    HomeCubit.get(context).addExperience(context);
                  },
                  child: const Text(
                    'Add Work Experience',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: height * .025,
                ),
                MyTextFormField(
                  onEditingComplete: () {
                    HomeCubit.get(context).addSkill();
                  },
                  textEditingController: HomeCubit.get(context).skillController,
                  hintText: 'Add Skill',
                ),
                SizedBox(
                  height: height * .025,
                ),
                BlocConsumer<HomeCubit, HomeState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return HomeCubit.get(context).file != null ? Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.grey),
                                ),
                                onPressed: () {
                                  HomeCubit.get(context).savePDFToDevice(context,HomeCubit.get(context).file!);
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.grey),
                                ),
                                onPressed: () {
                                  HomeCubit.get(context).openPDFViewer(context, HomeCubit.get(context).file!);
                                },
                                child: const Text(
                                  'View PDF',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: height * .025,),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            WidgetStateProperty.all(Colors.grey
                            ),
                          ),
                          onPressed: () {
                            HomeCubit.get(context).sharePDF(context);
                          },
                          child: const Text(
                            'Share',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                      ],
                    ) :SizedBox();
                  },
                ),
                SizedBox(
                  height: height * .025,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    HomeCubit.get(context).generatePDF(context);
                  },
                  child: const Text(
                    'Generate PDF',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
