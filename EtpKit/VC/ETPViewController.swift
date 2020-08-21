//
//  ETPViewController.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 19.06.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit


class ETPViewController: UIViewController {
    
    private lazy var titleView:UIView = {
        let mView = UIView()
        mView.translatesAutoresizingMaskIntoConstraints = false
        mView.backgroundColor = .red
        return mView
    }()
    
    private lazy var imageView:UIImageView = {
        let mView = UIImageView()
        mView.translatesAutoresizingMaskIntoConstraints = false
        mView.layer.cornerRadius = 20
        mView.layer.masksToBounds = true
        mView.image = UIImage(named: "a")
        return mView
    }()
    
    private lazy var titleLabel:UILabel = {
        let mView = UILabel()
        //mView.translatesAutoresizingMaskIntoConstraints = false
        mView.textAlignment = .left
        mView.font = .boldSystemFont(ofSize: 17)
        return mView
    }()
    private lazy var subTitleLabel:UILabel = {
        let mView = UILabel()
        mView.translatesAutoresizingMaskIntoConstraints = false
        mView.textAlignment = .left
        mView.font = .systemFont(ofSize: 14)
        return mView
    }()
    var rightButtonsWidth:CGFloat = 0


    
    func setupNavigationTitle(title:String){
         titleLabel.text = title
    }
    func setRightBarButton(_ items : Array<UIBarButtonItem>){
        items.forEach{(item) in
           
           rightButtonsWidth +=  80
        }
        //titleView.widthAnchor.constraint(equalToConstant: navigationController!.navigationBar.frame.width - rightButtonsWidth).isActive = true
        navigationItem.rightBarButtonItems = items
    }
    
    func setHidesBackButton(_ hidesBackButton: Bool, animated: Bool){
        navigationItem.setHidesBackButton(hidesBackButton, animated: animated)
        //titleView.frame = CGRect.init(x: 0, y: 0, width: view.frame.width , height: view.frame.height)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: .Helvetica, type: .Bold, size: 17)!]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        titleLabel.frame = CGRect.init(x: 0, y: 0, width: view.frame.width , height: view.frame.height)
       
        
        //titleView.addSubview(titleLabel)
        //titleView.addSubview(subTitleLabel)
        titleView.addSubview(imageView)
        //titleView.widthAnchor.constraint(equalToConstant: navigationController!.navigationBar.frame.width - rightButtonsWidth).isActive = true
        imageView.leftAnchor.constraint(equalTo: titleView.leftAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: titleView.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: titleView.heightAnchor).isActive = true
        //imageView.topAnchor.constraint(equalTo: titleView.topAnchor).isActive = true
        //imageView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        //imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        //titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor,constant: 20).isActive = true
        //titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        //titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor).isActive = true
        //titleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor).isActive = true
        //titleLabel.rightAnchor.constraint(equalTo: titleView.rightAnchor).isActive = true
       
        //subTitleLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        //subTitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        //subTitleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
       
        navigationController?.navigationBar.subviews.forEach{(item) in
            item.subviews.forEach{(item2) in
                item2.subviews.forEach{(item3) in
                    item3.backgroundColor = .randomColor()
                }
            }
        }
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = nil
        let backIndicator = UIImage(systemName: "arrow.left")?.withAlignmentRectInsets( UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0))
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backIndicatorImage = backIndicator
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backIndicator
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.navigationBar.topItem?.title = ""
         */
      
       
    }
    
    
}
