//
//  NavigationBarViewController.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 19.06.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit

struct CaptchaResponse : Codable {
    
    let captcha : String?
    
    enum CodingKeys: String, CodingKey {
        case captcha = "captcha"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        captcha = try values.decodeIfPresent(String.self, forKey: .captcha)
    }}

class NavigationBarViewController: ETPViewController {
    
    
    @IBOutlet var captchaView: Captcha!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.shadowImage = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationTitle(title: "App Bar Test")
        
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(action2))
        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(action1))
        
        //navigationItem.rightBarButtonItems = [play,add]
        setRightBarButton( [play,add])
        
     
        getCaptcha()
        
        self.captchaView.refreshCallback {
            self.getCaptcha()
        }
        
    }
    
    func getCaptcha(){
        ETPHtttp.newInstance().get("http://192.168.1.103:3000/captcha", successCallback: {
                 (res: CaptchaResponse?) in
               
                 self.captchaView.setCaptchaBase64(captcha: (res?.captcha)!)
             }, errorCallback: {
                 error in
               
             })
    }
    
    @objc func action1(){
        
        setHidesBackButton(true, animated: true)
        
        
    }
    
    @objc func action2(){
        setHidesBackButton(false, animated: false)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
