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
}