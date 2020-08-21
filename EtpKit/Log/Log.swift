//
//  Log.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 17.06.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

let log = Log()
class Log {
   
    //Error
    func e(tag:String,msg:String){
        print("\n🔴 ERROR\n\(tag) :\n\(msg)")
    }
    //Warning
    func w(tag:String,msg:String){
        print("\n🟡 WARNING\n\(tag) :\n\(msg)")
    }
    //Info
    func i(tag:String,msg:String){
        print("\n🔵 INFO\n\(tag) :\n\(msg)")
    }
    //Debug
    func d(tag:String,msg:String){
        print("\n🟢 DEBUG\n\(tag) :\n\(msg)")
    }
    //Verbose
    func v(tag:String,msg:String){
        print("\n🟣 VERBOSE\n\(tag) :\n\(msg)")
    }
    //What a Terrible Failure
    func wtf(tag:String,msg:String){
        print("\n⚪️ WTF\n\(tag) :\n\(msg)")
    }
}
