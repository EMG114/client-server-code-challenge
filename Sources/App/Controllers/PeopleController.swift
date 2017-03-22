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
    
    func addRoutes(drop: Droplet) {
        drop.group("people") { group in
            group.post("create", handler: create)
            group.get("all", handler: index)
            group.get("show", People.self, handler: show)
            group.patch("update", People.self, handler: update)
            group.post("delete", People.self, handler: delete)
        
        
        }
    }
    

    
    func create(request: Request) throws -> ResponseRepresentable {
        var person = try request.person()
        try person.save()
        return person
    }
    
    
    func index(request: Request) throws -> ResponseRepresentable {
        return try JSON(node: People.all().makeNode())
    }
    
    
    func show(request: Request, people: People) throws -> ResponseRepresentable {
        return people
        
    }
    
    func update(request: Request, people: People) throws -> ResponseRepresentable {
        let new = try request.person()
        var people = people
        people.name = new.name
        people.favoritecity = new.favoritecity
        try people.save()
        return people
    }
    
    func delete(request: Request, people: People) throws -> ResponseRepresentable {
        try people.delete()
        return JSON([:])
    }
    
    func makeResource() -> Resource<People> {
        return Resource(
            index: index,
            store: create,
            show: show,
            modify: update,
            destroy: delete
        )
}

}


extension Request {
    func person() throws -> People {
        guard let json = json else { throw Abort.badRequest }
        return try People(node: json)
    }
}
