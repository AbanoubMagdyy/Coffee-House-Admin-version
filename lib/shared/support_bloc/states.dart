abstract class SupportStates{}

class InitialState extends SupportStates{}

class LoadingGetThePeopleWhoSentTheirComplaints extends SupportStates{}
class SuccessGetThePeopleWhoSentTheirComplaints extends SupportStates{}
class ErrorGetThePeopleWhoSentTheirComplaints extends SupportStates{}

class LoadingGetUserInformation extends SupportStates{}
class SuccessGetUserInformation extends SupportStates{}
class ErrorGetUserInformation extends SupportStates{}


class SuccessGetMessages extends SupportStates{}

class SuccessSendMessage extends SupportStates{}
class ErrorSendMessage extends SupportStates{}

