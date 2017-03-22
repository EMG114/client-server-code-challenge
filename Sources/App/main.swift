import Vapor
import Fluent
import VaporPostgreSQL




let drop = Droplet(providers: [VaporPostgreSQL.Provider.self])
drop.preparations.append(People.self)

let peopleController = PeopleController()
peopleController.addRoutes(drop: drop)

drop.get("version") { request in
    
    if let db = drop.database?.driver as? PostgreSQLDriver {
        let version = try db.raw("SELECT version()")
        return try JSON(node: version) }
    else { return "No db connection"
        
    }

}
//let drop = Droplet()
////drop.preparations.append(People.self)
//

//do {
//    try drop.addProvider(VaporPostgreSQL.Provider.self)
//} catch {
//    assertionFailure("Error adding provider: \(error)")
//}
//drop.preparations += People.self


//Make a GET request to people
drop.get("people") { req in
    var person = People(name: "Sean", favoritecity: "New York")
    return try person.makeJSON()
  
}



//Make GET Request
drop.get("people") { request in
    return try JSON(node:[ "id": nil, "name": "Sean", "favoritecity": "New York"]) }

//Make a POST Request to /people
drop.post("people") { req in
    var person = People(name: "Sean", favoritecity: "New York")
    try person.save()
    return try person.makeJSON()
}


//GET request to retrieve all data previously posted
drop.get("people") { req in
   return try People.query().all().makeJSON()

}

//Make a PUT request
drop.put("update") { request in
    guard var first = try People.query().first(),
        let city = request.data["favoritecity"]?.string else {
            throw Abort.badRequest
    }
    
    first.favoritecity = "Brooklyn"
    try first.save()
    
    return first
}


//Get /people/1
drop.get("people", Int.self) { request, userID in
    guard let people = try People.find(userID) else {
        throw Abort.notFound
        
    }
    return try people.makeJSON()
}



//DELETE \people\1
drop.delete("people", Int.self) { request, userID in
    guard let people = try People.find(userID) else {
        throw Abort.notFound
        
    }
    return try people.makeJSON()
}

//Make a GET Request
drop.get("people") { request in
    return try People.query().all().makeJSON() }
    




drop.resource("people", PeopleController())

drop.run()

