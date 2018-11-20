import 'package:easy_drivers/model/app_state.dart';
import 'package:easy_drivers/reducer/auth_reducer.dart';

AppState appReducer(AppState state, action) {

  return AppState(
    isLoading: false,
    currentUser: authReducer(state.currentUser, action)
  );
}