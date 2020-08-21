//
//  ETPHttp.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 20.08.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit


class ETPHtttp {
    private static var instance : ETPHtttp? = nil
    static func newInstance ()-> ETPHtttp {
        if (instance == nil){
            instance = ETPHtttp()
        }
        return instance!
    }
    
    func get<T : Codable>(_ url: String, parameters:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback: @escaping (_ error : Error?) -> Void){
        self.get(URL(string: url)!, parameters: parameters, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    func get<T : Codable>(_ url: URL, parameters:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback: @escaping (_ error : Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        self.request(request,parameters: parameters, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    func delete<T : Codable>(_ url: String, parameters:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback: @escaping (_ error : Error?) -> Void){
        self.get(URL(string: url)!, parameters: parameters, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    func delete<T : Codable>(_ url: URL, parameters:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback: @escaping (_ error : Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        self.request(request,parameters: parameters, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    func post<T : Codable,B :Codable>(_ url: String,  body: B?, parameters:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback: @escaping (_ error : Error?) -> Void){
        self.post(URL(string: url)!,body: body, parameters: parameters, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    func post<T : Codable,B :Codable>(_ url: URL, body: B?, parameters:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback: @escaping (_ error : Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let jsonBody = try JSONEncoder().encode(body)
            request.httpBody = jsonBody
        }catch let error {
            errorCallback(error)
        }
        self.request(request,parameters: parameters, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    func put<T : Codable,B :Codable>(_ url: String,  body: B?, parameters:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback: @escaping (_ error : Error?) -> Void){
        self.post(URL(string: url)!,body: body, parameters: parameters, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    func put<T : Codable,B :Codable>(_ url: URL, body: B?, parameters:[String: String]? = nil, successCallback: @escaping (_ response : T?) -> Void, errorCallback: @escaping (_ error : Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            let jsonBody = try JSONEncoder().encode(body)
            request.httpBody = jsonBody
        }catch let error {
            errorCallback(error)
        }
        
        self.request(request,parameters: parameters, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    private func request<T : Codable>(_ request: URLRequest, parameters:[String: String]? = nil,successCallback: @escaping (_ response : T?) -> Void, errorCallback: @escaping (_ error : Error?) -> Void){
        var newReq = request
        parameters?.forEach{ key, value in
            newReq.setValue(key, forHTTPHeaderField: value)
        }
        let identifier = UUID()
        print("------\(identifier) Request Start------")
        print("Url : \(String(describing: request.url))")
      
        print("Header : \(String(describing: parameters))")
        print("Method : \(String(describing: request.httpMethod))")
        print("Body : \(String(describing: request.httpBody))")
        print("------\(identifier) Request End------")
        URLSession.shared.dataTask(with: newReq, completionHandler: { data, response, error in
            print("------\(identifier) Response Start------")
            print("Url : \(String(describing: request.url))")
            print("Header : \(String(describing: parameters))")
            print("Method : \(String(describing: request.httpMethod))")
            print("Body : \(String(describing: request.httpBody))")
            if let data = data {
                do {
                    if let res = try JSONDecoder().decode(T?.self, from: data){
                        
                        print("Response : \(res)")
                        
                        successCallback(res)
                        
                    }
                } catch let error {
                    errorCallback(error)
                    print("Error : \(error)")
                }
            }
            print("------\(identifier) Response End------")
            
        }).resume()
    }
}
