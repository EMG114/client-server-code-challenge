# client-server-code-challenge

A code challenge about creating a client and server for simple CRUD operations. Done in Swift and Vapor.

# Description

To complete this question you will need to write both a client and a server. We are agnostic to how you design the client (mobile web, iOS, Android, desktop web) but it will need to be able to make HTTP requests to a specific endpoints.  The server you create will also need to be able to respond to HTTP requests to specific endpoints.  It is not important what language or framework you use to build your server.

The client should do the following in order
Make a GET request to /people
Make a POST request to /people
Please make the person object have the following attributes: id, name : “Sean”, favoriteCity : “New York”
Make a GET request to retrieve the object created in the previous request
Make a PUT request to /people and modify the attribute city to be “Brooklyn”
Make a GET request to /people/1
Make a DELETE request to /people/1
Make a GET request to /people

Using restful principles, decide how the server should handle each request including responding with the appropriate JSON.  We are intentionally being vague about what exactly each request should do on the server.  We want you to use your best guess as to how other programmers might expect your API to behave.

Please deploy your server to heroku and give us the address.  Please give us instructions on how your client will make the required requests to your server.

# Requirements

Need Swift lastest version
Need Xcode latest version
Neeed Vapor latest version
Need Postgresql latest version

## 📖 Documentation

Visit the Vapor web framework's [documentation](http://docs.vapor.codes) for instructions on how to use this package.

## 💧 Community

Join the welcoming community of fellow Vapor developers in [slack](http://vapor.team).

## 🔧 Compatibility

This package has been tested on macOS and Ubuntu.

