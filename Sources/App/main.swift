import Vapor
import Fluent
import VaporPostgreSQL
import HTTP




let drop = Droplet(providers: [VaporPostgreSQL.Provider.self])
drop.preparations.append(People.self)

//Make a PUT request
//drop.put("favoritecity") { request in
//    guard var first = try People.query().first(),
//        let city = request.data["favoritecity"]?.string else {
//            throw Abort.badRequest
//    }
//    
//    first.favoritecity = "Brooklyn"
//    try first.save()
//    
//    return first
//}
//
//
//
////Get /people/1
//drop.get("name", Int.self) { request, userID in
//    guard let people = try People.find(userID) else {
//        throw Abort.notFound
//        
//    }
//    return try people.makeJSON()
//}
//
//
//
////DELETE \people\1
//drop.delete("name", Int.self) { request, userID in
//    guard let people = try People.find(userID) else {
//        throw Abort.notFound
//        
//    }
//    return try people.makeJSON()
//}
//
////Make a GET Request
//drop.get("name") { request in
//    return try People.query().all().makeJSON() }
//
//


//Make a GET request to people


//
//drop.get("people") { req in
//    var people = People(name: "Sean", favoritecity: "New York")
//    try people.save()
//    return try people.makeJSON()
//  
//}

//drop.get(""){ req in
//    var people = People(name: "Sean", favoritecity: "New York")
//    try people.save()
//    return try people.makeJSON()
//    
//}

//
//
////Make GET Request


//drop.get("people") { request in
//    
//    return try Response(status: .created, json: JSON(node :[
//        "name":"Sean", "favoritecity":"New York" ]))
//    
//
//}
//
//drop.get("people") { request in
//    
//    //Creating our object
//    let person = People(name: "Sean", favoritecity: "New York")
//    
//    //Formating it into JSON
//    return try JSON(node: [
//        "name" : person.name,
//        "favoritecity" : person.favoritecity,
//        
//        ])
//}
//
//drop.get("people") { request in
//    return try JSON(node:[ "id": nil, "name": "Sean", "favoritecity": "New York"]) }
//
//drop.get("people") { req in
//    
//    let peoples = try People.query().all()
//    return try peoples.makeJSON()
//    
//}
//
////Make a POST Request to /people
//drop.post("post") { req in
//    var person = People(name: "Sean", favoritecity: "New York")
//    try person.save()
//    return try person.makeJSON()
//}


/*
//GET request to retrieve all data previously posted
drop.get("name") { req in
   return try People.query().all().makeJSON()

}

 */
//Make a PUT request
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
 


//Get /people/1
//drop.get("name", Int.self) { request, userID in
//    guard let people = try People.find(userID) else {
//        throw Abort.notFound
//        
//    }
//    return try people.makeJSON()



 drop.get("people", Int.self) { req, personID in
    guard let person = try People.query().filter("id", personID).first() else { return "No person found" }
    return try person.makeJSON()
    }
 


//DELETE \people\1
//drop.delete("people", Int.self) { request, personID in
//    guard let person = try People.query().filter("id", personID).first() else { return "No person found" }
//    return try person.makeJSON()
//}

/*
//Make a GET Request
drop.get("name") { request in
    return try People.query().all().makeJSON() }
    


*/

let peoples = PeopleController()
drop.resource("people", PeopleController())

drop.run()

