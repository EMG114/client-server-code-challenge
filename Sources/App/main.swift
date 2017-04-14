import Vapor
import Fluent
import VaporPostgreSQL
import HTTP




let drop = Droplet(providers: [VaporPostgreSQL.Provider.self])
drop.preparations.append(People.self)




//Make a PUT request this code works
drop.put("people") { request in
    guard var first = try People.query().first(),
        let name = request.data["name"]?.string, let city = request.data["favoritecity"]?.string else {
            throw Abort.badRequest
    }
    first.name = "Sean"
    first.favoritecity = "Brooklyn"
    try first.save()
    
    return first
}
 


//this code works
 drop.get("people", Int.self) { req, personID in
    guard let person = try People.query().filter("id", personID).first() else { return "No person found" }
    return try person.makeJSON()
    }
 


let peoples = PeopleController()
drop.resource("people", PeopleController())

drop.run()

