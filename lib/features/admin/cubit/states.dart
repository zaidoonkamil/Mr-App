abstract class AdminStates {}

class AdminInitialState extends AdminStates {}

class ValidationState extends AdminStates {}

class GetAllUserLoadingState extends AdminStates {}
class GetAllUserSuccessState extends AdminStates {}
class GetAllUserErrorState extends AdminStates {}

class DeleteUserLoadingState extends AdminStates {}
class DeleteUserSuccessState extends AdminStates {}
class DeleteUserErrorState extends AdminStates {}

class DeleteAdsLoadingState extends AdminStates {}
class DeleteAdsSuccessState extends AdminStates {}
class DeleteAdsErrorState extends AdminStates {}

class GetUserOrderLoadingState extends AdminStates {}
class GetUserOrderSuccessState extends AdminStates {}
class GetUserOrderErrorState extends AdminStates {}

class GetAllOrderLoadingState extends AdminStates {}
class GetAllOrderSuccessState extends AdminStates {}
class GetAllOrderErrorState extends AdminStates {}

class UpdateOrderLoadingState extends AdminStates {}
class UpdateOrderSuccessState extends AdminStates {}
class UpdateOrderErrorState extends AdminStates {}

class GetAdsLoadingState extends AdminStates {}
class GetAdsSuccessState extends AdminStates {}
class GetAdsErrorStates extends AdminStates {}

class GetStatsLoadingState extends AdminStates {}
class GetStatsSuccessState extends AdminStates {}
class GetStatsErrorStates extends AdminStates {}

class SelectedImagesState extends AdminStates {}
class AddAdsLoadingState extends AdminStates {}
class AddAdsSuccessState extends AdminStates {}
class AddAdsErrorState extends AdminStates {}
