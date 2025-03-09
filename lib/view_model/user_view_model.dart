class UserViewModel 
{
  
  Future<void> saveUserToFirestore(bio, city, country, email, firstName, lastName, id) async
  {
    Map<String, dynamic> dataMap = 
    {
      "bio": bio,
      "city": city,
      "country": country
    }
  }

}