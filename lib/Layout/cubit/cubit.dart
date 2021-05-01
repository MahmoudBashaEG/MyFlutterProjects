import 'package:bloc/bloc.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());
  static ShopCubit get(context) => BlocProvider.of(context);
}
