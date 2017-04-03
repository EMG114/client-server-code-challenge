//
//  People.swift
//  People
//
//  Created by Erica on 3/21/17.
//
//

import Vapor
import Fluent
import Foundation


final class People: Model {
    
    
    var id: Node?
    var exists: Bool = false
    var name: String
    var favoritecity: String
    
    
    init(name: String, favoritecity: String) {
       // self.id = nil
        self.name = name
        self.favoritecity = favoritecity
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        favoritecity = try node.extract("favoritecity")

}
    
     func makeNode(context: Context) throws -> Node {
         return try Node(node: [
         "id": id,
         "name": name,
         "favoritecity": favoritecity,
 ])
}
    
 }

extension People: Preparation {
//
  static func prepare(_ database: Database) throws {
       try database.create("peoples") { peoples in
            peoples.id()
            peoples.string("name")
            peoples.string("favoritecity")
        }
    }

    static func revert(_ database: Database) throws {
        try database.delete("peoples")
}


}
