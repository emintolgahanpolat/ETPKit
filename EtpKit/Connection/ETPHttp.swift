//
//  ETPHttp.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 20.08.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit


class ETPHtttp {
     static var shared : ETPHtttp = ETPHtttp()
    
    func get<T : Codable>(_ url: String, headers:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback: ((_ error : Error?) -> Void)? = nil, loadingCallback: ((_ loading : Bool) -> Void)? = nil ){
        self.get(URL(string: url)!, headers: headers, successCallback: successCallback, errorCallback: errorCallback,loadingCallback: loadingCallback)
    }
    
    func get<T : Codable>(_ url: URL, headers:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback: ((_ error : Error?) -> Void)? = nil, loadingCallback: ((_ loading : Bool) -> Void)? = nil){
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        self.request(request,headers: headers, successCallback: successCallback, errorCallback: errorCallback,loadingCallback : loadingCallback)
    }
    
    func delete<T : Codable>(_ url: String, headers:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback:  ((_ error : Error?) -> Void)? = nil, loadingCallback: ((_ loading : Bool) -> Void)? = nil){
        self.delete(URL(string: url)!, headers: headers, successCallback: successCallback, errorCallback: errorCallback,loadingCallback : loadingCallback)
    }
    
    func delete<T : Codable>(_ url: URL, headers:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback:  ((_ error : Error?) -> Void)? = nil, loadingCallback: ((_ loading : Bool) -> Void)? = nil){
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        self.request(request,headers: headers, successCallback: successCallback, errorCallback: errorCallback,loadingCallback : loadingCallback)
    }
    
    func post<T : Codable,B :Codable>(_ url: String,  body: B?, headers:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback: ((_ error : Error?) -> Void)? = nil,  loadingCallback: ((_ loading : Bool) -> Void)? = nil){
        self.post(URL(string: url)!,body: body, headers: headers, successCallback: successCallback, errorCallback: errorCallback,loadingCallback : loadingCallback)
    }
    
    func post<T : Codable,B :Codable>(_ url: URL, body: B?, headers:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback:((_ error : Error?) -> Void)? = nil,  loadingCallback: ((_ loading : Bool) -> Void)? = nil){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let jsonBody = try JSONEncoder().encode(body)
            request.httpBody = jsonBody
        }catch let error {
            errorCallback?(error)
        }
        self.request(request,headers: headers, successCallback: successCallback, errorCallback: errorCallback,loadingCallback : loadingCallback)
    }
    
    func put<T : Codable,B :Codable>(_ url: String,  body: B?, headers:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback:  ((_ error : Error?) -> Void)? = nil,  loadingCallback: ((_ loading : Bool) -> Void)? = nil){
        self.put(URL(string: url)!,body: body, headers: headers, successCallback: successCallback, errorCallback: errorCallback,loadingCallback : loadingCallback)
    }
    
    func put<T : Codable,B :Codable>(_ url: URL, body: B?, headers:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback:  ((_ error : Error?) -> Void)? = nil,  loadingCallback: ((_ loading : Bool) -> Void)? = nil){
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            let jsonBody = try JSONEncoder().encode(body)
            request.httpBody = jsonBody
        }catch let error {
            errorCallback?(error)
        }
        
        self.request(request,headers: headers, successCallback: successCallback, errorCallback: errorCallback,loadingCallback : loadingCallback)
    }
    
    func request<T : Codable>(_ request: URLRequest, headers:[String: String]? = nil,successCallback: @escaping (_ response : T?) -> Void, errorCallback:((_ error : Error?) -> Void)? = nil, loadingCallback: ((_ loading : Bool) -> Void)? = nil){
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
