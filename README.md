
#**KituraTIL**  
**To use this API, First install CouchDB with:**  
```brew install couchdb```  
**Start CouchDB with:**  
```brew services start couchdb```  
**clone this project with:**  
```git clone https://github.com/Jthornburg1/bikes_api_kitura.git```  
**cd into the root directory:**  
```cd bikes_api_kitura```  
**generate an Xcode project:**  
```swift package generate-xcodeproj```  
**Open the project with:**
```open KituraTIL.xcodeproj/```  
**-Build and run-**  

If all has succeeded, you'll not see an error.  
If the Xcode debugger says that port 8080 is already in use then try shutting  
any docker containers that are open and checking for any other operations that
may be in use on that port.  

In terminal, type ```curl http:localhost:8080/bikes```  
This should return an empty array in the next line.  
type ```curl -X POST http://localhost:8080/bikes -H 'content-type: application/json' -d   '{"make":"TREK","model": "Pro Cal 9.0"}'```  
type ```curl http:localhost:8080/bikes``` and you should now see a json object in an array!  
