import 'package:house/model/contact_model.dart';
import 'package:house/model/user_model.dart';

class AppConstants 
{
   static UserModel currentUser = UserModel();

   ContactModel createContactFromUserModel ()
   {
    return ContactModel(
      id: currentUser.id,
      firstName: currentUser.firstName,
      lastName: currentUser.lastName,
      displayImage: currentUser.displayImage,
    );
   }

   static final Map<int, int> daysInMonths = 
   {
     1 : 31,
     2: DateTime.now().year % 4 == 0 ? 29 : 28,
     3: 31,
     4: 30,
     5: 31,
     6: 30,
     7: 31,
     8: 31,
     9: 30,
     10: 31,
     11: 30,
     12: 31
   };

   static final Map<int, String> monthDict = {

    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
   };
}