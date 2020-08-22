//
//  UserDefaultExtensions.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 10.05.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import Foundation

enum UserDefaultKeys:String {
    case imageHistory, username,password
}
private extension UserDefaults {
    
    subscript<T>(key: UserDefaultKeys) -> T? {
        get {
            return value(forKey: key.rawValue) as? T
        }
        set {
            set(newValue, forKey: key.rawValue)
        }
    }
    
   
    func setEtpValue<T>(_ value: T, key:UserDefaultKeys ){
         set(value, forKey: key.rawValue)
     }
     
     func getEtpValue<T>(key:UserDefaultKeys ) -> T? {
       return value(forKey: key.rawValue) as? T
     }
}

extension UserDefaults{
    class User {
        var username: String? {
            get {
                return UserDefaults.standard[.username]
            }
            set {
                UserDefaults.standard[.username] = newValue
            }
        }
        var password: String? {
            get {
                return UserDefaults.standard[.password]
            }
            set {
                UserDefaults.standard[.password] = newValue
            }
        }
    }
    
    class Image{
        
        class var history: [String] {
            get {
                return UserDefaults.standard[.imageHistory] ?? []
            }
            set {
                UserDefaults.standard[.imageHistory] = newValue
            }
        }
        
        class func add(url:String){
            var oIH:[String] = history
            oIH.append(url)
            Log.i(tag: "Image Historry", msg: oIH.joined(separator: "\n"))
            history = oIH
        }
        class func remove(url:String){
            var oIH:[String] = history
            if let index = oIH.firstIndex(of: url) {
                oIH.remove(at: index)
            }
            Log.i(tag: "Image Historry", msg: oIH.joined(separator: "\n"))
            history = oIH
        }
    }
    
    
   
  
  @objc var imageHistory: [String] {
      get {
          return UserDefaults.standard[.imageHistory] ?? []
      }
      set {
          UserDefaults.standard[.imageHistory] = newValue
      }
  }
   
}
