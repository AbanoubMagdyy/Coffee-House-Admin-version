abstract class AppStates{}

class InitialState extends AppStates{}

class ChangeCurrentIndex extends AppStates{}

 class Error extends AppStates{}

class SuccessGetCoffeeMenu extends AppStates{}
class ErrorGetCoffeeMenu extends AppStates{}

class SuccessGetChocolateMenu extends AppStates{}
class ErrorGetChocolateMenu extends AppStates{}

class SuccessGetOthersMenu extends AppStates{}
class ErrorGetOthersMenu extends AppStates{}

class SuccessGetOrders extends AppStates{}
class ErrorGetOrders extends AppStates{}


class SuccessGetStatisticsData extends AppStates{}
class ErrorGetStatisticsData extends AppStates{}

class SuccessDeleteItem extends AppStates{}
class ErrorDeleteItem extends AppStates{}

class SuccessAddIOrRemoveItemFromRecommend extends AppStates{}
class ErrorAddIOrRemoveItemFromRecommend extends AppStates{}

class LoadingAddItem extends AppStates{}
class SuccessAddItem extends AppStates{}
class ErrorAddItem extends AppStates{}


class LoadingEditItem extends AppStates{}
class SuccessEditItem extends AppStates{}
class ErrorEditItem extends AppStates{}


class SuccessGetLastUpdateData extends AppStates{}
class ErrorGetLastUpdateData extends AppStates{}


class SuccessGetPercentageValueOfVariables extends AppStates{}
class ErrorGetPercentageValueOfVariables extends AppStates{}

class SuccessUpdatePercentageValueOfVariables extends AppStates{}
class ErrorUpdatePercentageValueOfVariables extends AppStates{}