//
//  Log.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 17.06.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//


class Log {
   
    //Error
   class func e(tag:String,msg:String){
        print("\n🔴 ERROR\n\(tag) :\n\(msg)")
    }
    //Warning
   class func w(tag:String,msg:String){
        print("\n🟡 WARNING\n\(tag) :\n\(msg)")
    }
    //Info
   class func i(tag:String,msg:String){
        print("\n🔵 INFO\n\(tag) :\n\(msg)")
    }
    //Debug
   class func d(tag:String,msg:String){
        print("\n🟢 DEBUG\n\(tag) :\n\(msg)")
    }
    //Verbose
   class func v(tag:String,msg:String){
        print("\n🟣 VERBOSE\n\(tag) :\n\(msg)")
    }
    //What a Terrible Failure
   class func wtf(tag:String,msg:String){
        print("\n⚪️ WTF\n\(tag) :\n\(msg)")
    }
}
