abstract class States {}

class intial_State extends States {}

class ChangeisPatient_State extends States {}

class login_loding_State extends States {}

class login_success_State extends States {
  final dynamic uID;
  login_success_State(this.uID);
}

class login_error_State extends States {}

// Sign Out

class SignOut_Loading_State extends States {}

class SignOut_Success_State extends States {}

class SignOut_Error_State extends States {}

class register_loding_State extends States {}

class register_success_State extends States {}

class register_error_State extends States {}

class createUser_loding_State extends States {}

class createUser_success_State extends States {
  final dynamic uID;
  createUser_success_State(this.uID);
}

class createUser_error_State extends States {}

// Get Citites.
class getCities_loding_States extends States {}

class getCities_success_States extends States {}

class getCities_error_States extends States {}

// Get Hospitals.
class getHospitals_loding_States extends States {}

class getHospitals_success_States extends States {}

class getHospitals_error_States extends States {}

// Get Branches.
class getBranches_loding_States extends States {}

class getBranches_success_States extends States {}

class getBranches_error_States extends States {}

// Get Doctors.
class getDoctors_loding_States extends States {}

class getDoctors_success_States extends States {}

class getDoctors_error_States extends States {}

// Add Appointment.
class AddAppointment_loding_States extends States {}

class AddAppointment_success_States extends States {}

class AddAppointment_error_States extends States {}

// Get Appointments.
class getAppointments_loding_States extends States {}

class getAppointments_success_States extends States {}

class getAppointments_error_States extends States {}

// Cancel Appointments.
class CancelAppointment_loding_States extends States {}

class CancelAppointment_success_States extends States {}

class CancelAppointment_error_States extends States {}

// Cancel Appointments.
class ApproveAppointment_loding_States extends States {}

class ApproveAppointment_success_States extends States {}

class ApproveAppointment_error_States extends States {}

// Send Notification To Patient
class SendNotificationToPatient_loding_States extends States {}

class SendNotificationToPatient_success_States extends States {}

class SendNotificationToPatient_error_States extends States {}

// get notifications
class getNotifications_loding_States extends States {}

class getNotifications_success_States extends States {}

// delete notification notifications
class deleteNotification_loding_States extends States {}

class deleteNotification_success_States extends States {}

class deleteNotification_error_States extends States {}

class Success extends States {}
// // Get All Posts
// class getPosts_loding_States extends social_States {}

// class getPosts_success_States extends social_States {}

// class getPosts_error_States extends social_States {}

// class ChangeNavigationBar_States extends social_States {}

// class addScreen_States extends social_States {}

// class ChagneTheme_States extends social_States {}

// class CoverImagePicking_Success_State extends social_States {}

// class CoverImagePicking_Error_State extends social_States {}

// class ProfileImagePicking_Success_State extends social_States {}

// class ProfileImagePicking_Error_State extends social_States {}

// class UploadDownload_ProfileImage_Success_State extends social_States {}

// class UploadDownload_ProfileImage_Error_State extends social_States {}

// // Upload & Download PostImage state
// class UploadDownload_PostImage_Success_State extends social_States {}

// class UploadDownload_PostImage_Error_State extends social_States {}

// class UploadDownload_CoverImage_Success_State extends social_States {}

// class UploadDownload_CoverImage_Error_State extends social_States {}

// class UpdateProfile_Loading_State extends social_States {}

// class UpdateProfile_Error_State extends social_States {}

// class ThereIsUpdate_State extends social_States {}

// class Choose_CoverImage_Success_State extends social_States {}

// class Choose_ProfileImage_Success_State extends social_States {}

// class PostImage_Delete_State extends social_States {}

// // Add Post State
// class CreatePost_loding_States extends social_States {}

// class CreatePost_success_States extends social_States {}

// class CreatePost_error_States extends social_States {}

// // like dislike

// class Like_DisLike_Post_Loading_State extends social_States {}

// class Like_DisLike_Post_Success_State extends social_States {}

// class Like_DisLike_Post_Error_State extends social_States {}

// // Sign Out

// class SignOut_Loading_State extends social_States {}

// class SignOut_Success_State extends social_States {}

// class SignOut_Error_State extends social_States {}

// // Create comment

// class Create_Comment_Loading_State extends social_States {}

// class Create_Comment_Success_State extends social_States {}

// class Create_Comment_Error_State extends social_States {}

// // get comments

// class getComment_Loding_State extends social_States {}

// class getComment_Success_State extends social_States {}

// // Get All Users
// class getAllusers_loding_States extends social_States {}

// class getAllusers_success_States extends social_States {}

// class getAllusers_error_States extends social_States {}

// // Send Message
// class SendMessage_Success_State extends social_States {}

// class SendMessage_Error_State extends social_States {}

// // Recieve Message
// class ReceiveMessage_Success_State extends social_States {}

// class ReceiveMessage_Error_State extends social_States {}

// // Get Messages
// class getMessages_Success_State extends social_States {}

// ////////////////////////////////// DEMO /////////////////////////////////////////

// class Create_Group_Loading_State extends social_States {}

// class Create_Group_Success_State extends social_States {}

// class Create_Group_Error_State extends social_States {}

// class getGroup_Loading_State extends social_States {}

// class getGroup_Success_State extends social_States {}

// class getGroup_Error_State extends social_States {}

// class CreateMember_Group_Loading_State extends social_States {}

// class CreateMember_Group_Success_State extends social_States {}

// class CreateMember_Group_Error_State extends social_States {}
