# RestAPIWorker
Another Example for handling REST operations written in Swift 5.2. Demo also provide a way to handle different type of Payload using *JSONProvider*.

## How To Use
  Drang and drop 'RestAPI' folder in your application.
  Open 'RestEndPoint.swift' file and edit base url and path as below
  
      var baseURL: String {
        return "https://reqres.in/". ///EDIT HERE
    }
    
    var path: String {
        switch self {
        case .getUserList:
            return "api/users?page=1" ///EDIT HERE as per use
        case .addNewUser:
            return "api/users" ///EDIT HERE as per use
        case .getUser(let id):
            return "users/\(id)" ///EDIT HERE as per use
        case .updateUser:
            return "api/users/2" ///EDIT HERE as per use
        case .deleteUser:
            return "api/users/2" ///EDIT HERE as per use
        }
    }
