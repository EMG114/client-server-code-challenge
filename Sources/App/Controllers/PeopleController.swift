//
//  PeopleController.swift
//  People
//
//  Created by Erica on 3/21/17.
//


import Foundation
import Vapor
import HTTP

final class PeopleController: ResourceRepresentable {
    
    var peoples: [People] = []
    
    func index(request: Request) throws -> ResponseRepresentable {
       return try JSON(node: People.all())
       
    }
    
    func create(request: Request) throws -> ResponseRepresentable {

        
      
       var person = People(name: "Sean", favoritecity: "New York")
        try person.save()
        //Add it to our container object
        peoples.append(person)
        //Return the newly created json
        return try person.converted(to: JSON.self)
    }
    
    func show(request: Request, people: People) throws -> ResponseRepresentable {
        return people
    }
    
    func delete(request: Request, people: People) throws -> ResponseRepresentable {
      
     try People.query().delete()
        return JSON([:])
    }
    
    func clear(request: Request) throws -> ResponseRepresentable {
        try People.query().delete()
        return JSON([])
    }
    
    func update(request: Request, people: People) throws -> ResponseRepresentable {
        let new = try request.people()
        var people = people
        peoples[0].name = "Sean"
        peoples[0].favoritecity = "Brooklyn"
        try people.save()
        return people
    }
    
    func replace(request: Request, people: People) throws -> ResponseRepresentable {
        try people.delete()
        guard let name = request.data["name"]?.string else {
            //Throw a Abort response, I like using the custom status to make sure the frontends have the correct message and response code
            throw Abort.custom(status: Status.preconditionFailed, message: "Missing name")
        }
        
    
        return try create(request: request)
    }
    
    func makeResource() -> Resource<People> {
        return Resource(
            index: index,
            store: create,
            show: show,
            replace: replace,
            modify: update,
            destroy: delete,
            clear: clear
        )
    }
}

extension Request {
    func people() throws -> People {
        guard let json = json else { throw Abort.badRequest }
        return try People(node: json)
    }
}



