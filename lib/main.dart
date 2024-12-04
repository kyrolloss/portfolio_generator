import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:portfolio_generator/Home/View%20Model/home_cubit.dart';
import 'package:printing/printing.dart';

import 'Home/View/Home View/Home View.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => HomeCubit()),
        ],
        child: const MaterialApp(
          home: PortfolioScreen(),
          debugShowCheckedModeBanner: false,
        ));
  }
}


