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
    
}
struct GraffituModel : Codable {
    
    let body : String
    let createdBy : String?
    let createdDate : String?
    let description : String
    let graffituCategories : [GraffituCategory]
    let lastModifiedBy : String?
    let lastModifiedDate : String?
    let title : String
    let uuid : String?
    
    
    
    
}

struct GraffituCategory : Codable {
    
    let name : String?
    
    
}

class NavigationBarViewController: ETPViewController {
    
    
    @IBOutlet weak var captchaView: Captcha!
    
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
    
    @IBAction func postAction(_ sender: Any) {
        let gCat = GraffituCategory(name: "Biography")
        let graffituCreate : GraffituModel? =  GraffituModel(body: "Body", createdBy: nil, createdDate: nil, description: "Açıklama", graffituCategories: [gCat], lastModifiedBy: nil, lastModifiedDate: nil, title: "iOS Title", uuid: nil)
        //    ETPHtttp.shared.post("http://192.168.1.103:3000/graffitu", body: graffituCreate , headers: ["Authorization":"Bearer //eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTU5ODY1MDY3NSwiaWF0IjoxNTk4MDQ1ODc1fQ//.yEIff6OzcFnZbDmMk6mOI9ul9U5B0ALamPzX2CEtDUmqRZdQJKDbUfgj98TyzqR2qsEpPzf2BnVk43zaLR-WZg"] , successCallback: {
        //        (res: GraffituModel?) in
        //
        //
        //    }, errorCallback: {
        //        error in
        //
        //    },loadingCallback: {
        //        isLoading in
        //    })
        
        APIHelper(method: .post, path: .graffitu).build(graffituCreate ,successCallback: {
            (res: GraffituModel) in
        },loadingCallback: {
            isLoading in
            DispatchQueue.main.async {
                self.title = "\(isLoading)"
            }
        })
    }
    func getCaptcha(){
        APIHelper(method: .get, path: .captcha).build(successCallback: {
            (res: CaptchaResponse?) in
            self.captchaView.setCaptchaBase64(captcha: (res?.captcha)!)
        }, loadingCallback: {
            isLoading in
            DispatchQueue.main.async {
                if isLoading{
                    ETPLoading.sharedInstance.show()
                }else {
                    ETPLoading.sharedInstance.hide()
                }
            }
        })
        // ETPHtttp.shared.get("http://192.168.1.102:3000/captcha", successCallback: {
        //     (res: CaptchaResponse?) in
        //     self.captchaView.setCaptchaBase64(captcha: (res?.captcha)!)
        // },  loadingCallback :{
        //     isLoading in
        //     DispatchQueue.main.async {
        //         if isLoading{
        //             ETPLoading.sharedInstance.show()
        //         }else {
        //             ETPLoading.sharedInstance.hide()
        //         }
        //     }
        // })
        
        
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
