import Foundation

struct UserDetails {

    static var instance = UserDetails()

    var fullname = ""
    var email = ""
    var phoneNumber = ""
    var dob = ""
    var userHasYard: Bool?
    var yardIsFenced = ""
    var veteneryName = ""
    var referenceName = ""
}
