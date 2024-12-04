part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ChangeName extends HomeState {}
final class GeneratePDF extends HomeState {}
final class SharePDF extends HomeState {}
final class DownloadPDF extends HomeState {}
