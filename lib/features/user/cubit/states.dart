abstract class UserStates {}

class UserInitialState extends UserStates {}

class ValidationState extends UserStates {}

class AddOrderLoadingState extends UserStates {}
class AddOrderSuccessState extends UserStates {}
class AddOrderErrorState extends UserStates {}

class ProvinceLoadingState extends UserStates {}
class ProvinceSuccessState extends UserStates {}
class ProvinceErrorState extends UserStates {}

class GetOrderLoadingState extends UserStates {}
class GetOrderSuccessState extends UserStates {}
class GetOrderErrorState extends UserStates {}

class GetAdsLoadingState extends UserStates {}
class GetAdsSuccessState extends UserStates {}
class GetAdsErrorStates extends UserStates {}

class GetStatsLoadingState extends UserStates {}
class GetStatsSuccessState extends UserStates {}
class GetStatsErrorStates extends UserStates {}