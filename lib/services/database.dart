class DatabaseMethods{

    Future addUser(String userId, Map<String, dynamic> userInfo) async {
        try {
            await FirebaseFirestore.instance.collection("users").doc(userId).set(userInfo);
            return true;
        } catch (e) {
            print("Error adding user: $e");
            return false;
        }
    }
}