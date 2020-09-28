//
//  APIHelper.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 22.08.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import Foundation

enum URLPath : String{
    case home = ""
    case captcha = "captcha"
    case graffitu = "graffitu"
}

enum HTTPMethod : String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class APIHelper{
    
    private let baseURL = "http://192.168.1.102:3000/"
    private var path : URLPath = .home
    private var httpMethod:HTTPMethod = .get
    private var params : [String:String]? = nil
    
    
    
    init(method:HTTPMethod,path :URLPath , params :[String:String]? = nil) {
        self.httpMethod = method
        self.path = path
        self.params = params
    }
    
    func build<T:Codable,B:Codable>(_ body :B, successCallback: @escaping (_ response : T) -> Void, errorCallback: ((_ error : Error?) -> Void)? = nil, loadingCallback: ((_ loading : Bool) -> Void)? = nil){
        
        var newUrl = baseURL + path.rawValue
        
        newUrl = newUrl + "?"
        params?.forEach{ key, value in
            newUrl = newUrl + "\(key)=\(value)&"
        }
        if ( newUrl.last == "?" ||  newUrl.last == "&"){
            newUrl.removeLast()
        }
        print(newUrl)
              
        var request = URLRequest(url: URL(string: newUrl)!)
        request.httpMethod = httpMethod.rawValue
        do {
            let jsonBody = try JSONEncoder().encode(body)
            request.httpBody = jsonBody
        }catch let error {
            errorCallback?(error)
        }
        request.setValue("Bearer \(UserDefaults.User.accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("tr-TR", forHTTPHeaderField: "Accept-Language")
        
        ETPHtttp.shared.request(request, successCallback: successCallback,errorCallback:errorCallback,loadingCallback:loadingCallback )
    }
    
    func build<T:Codable>(successCallback: @escaping (_ response : T?) -> Void, errorCallback: ((_ error : Error?) -> Void)? = nil, loadingCallback: ((_ loading : Bool) -> Void)? = nil){
        var request = URLRequest(url: URL(string: baseURL + path.rawValue)!)
        request.httpMethod = httpMethod.rawValue
        request.setValue("Bearer \(UserDefaults.User.accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("tr-TR", forHTTPHeaderField: "Accept-Language")
        
        self.request(request, successCallback: successCallback,errorCallback:errorCallback,loadingCallback:loadingCallback )
    }
   
    func request<T : Codable>(_ request: URLRequest, headers:[String: String]? = nil,successCallback: @escaping (_ response : T) -> Void, errorCallback:((_ error : Error?) -> Void)? = nil, loadingCallback: ((_ loading : Bool) -> Void)? = nil){
           loadingCallback?(true)
           var newReq = request
           headers?.forEach{ key, value in
               newReq.setValue(value, forHTTPHeaderField: key)
           }
          
           
           let identifier = UUID()
           print("------\(identifier) Request Start------")
           print("Url : \(String(describing: newReq.url))")
           
           print("Header : \(String(describing: headers))")
           print("Method : \(String(describing: newReq.httpMethod))")
           print("Body : \(String(describing: newReq.httpBody))")
           print("------\(identifier) Request End------")
           URLSession.shared.dataTask(with: newReq, completionHandler: { data, response, error in
               loadingCallback?(false)
               print("------\(identifier) Response Start------")
               print("Url : \(String(describing: newReq.url))")
               print("Header : \(String(describing: headers))")
               print("Method : \(String(describing: newReq.httpMethod))")
               print("Body : \(String(describing: newReq.httpBody))")
               if let data = data {
                   do {
                       if let res = try JSONDecoder().decode(T?.self, from: data){
                           print("Response : \(res)")
                           successCallback(res)
                       }
                   } catch let error {
                       errorCallback?(error)
                       print("Error : \(error)")
                   }
               }
               
               print("------\(identifier) Response End------")
               
           }).resume()
       }
       
}
