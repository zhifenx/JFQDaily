//
//  RegisterContriller.swift
//  JFQDaily
//
//  Created by zhifenx on 2017/7/27.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

import UIKit

@objc class RegisterController: UIViewController {
    
    var dismissButton: UIButton!
    var registerLabel: UILabel!
    var logoImageView: UIImageView!
    var wechatImageView: UIImageView!
    var qqImageView: UIImageView!
    var weiboImageView: UIImageView!
    var wechatLabel: UILabel!
    var qqLabel: UILabel!
    var weiboLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = UIScreen.main.bounds
        self.view.backgroundColor = UIColor.white
        
        addSubControl()
    }
    
    func addSubControl() {
        
        //退出按钮
        dismissButton = UIButton.init(frame: CGRect(x: 20, y: 44, width: 21, height: 21))
        dismissButton.setImage(UIImage.init(named: "UMS_shake_close"), for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissRegisterController), for: .touchUpInside)
        self.view.addSubview(dismissButton)
        
        //注册新账号 label
        let label_w: CGFloat = 100
        let label_x: CGFloat = UIScreen.main.bounds.size.width / 2 - label_w / 2
        registerLabel = UILabel.init(frame: CGRect(x: label_x, y: 44, width: label_w, height: 21))
        registerLabel.textAlignment = .center//可以这样写（NSTextAlignment.center)，这里使用简写
        registerLabel.text = "注册新账号"
        self.view.addSubview(registerLabel)
        
        //logo
        let logo_x: CGFloat = UIScreen.main.bounds.size.width / 2 - 80 / 2
        logoImageView = UIImageView(frame: CGRect(x: logo_x, y: 100, width: 80, height: 80))
        logoImageView.image = UIImage.init(named: "logo-1_80x80_")
        self.view.addSubview(logoImageView)
        
        thirdPartyLogin(control_x: 100)
    }
    
    func thirdPartyLogin(control_x: Int) {
        let label_y: Int = (Int)(UIScreen.main.bounds.size.height - 21 - 40)
        wechatLabel = UILabel.init(frame: CGRect.init(x: control_x, y: label_y, width: 50, height: 21))
        wechatLabel.textAlignment = .center
        wechatLabel.textColor = .gray
        wechatLabel.font = UIFont.systemFont(ofSize: 14)
        wechatLabel.text = "微信"
        
        self.view.addSubview(wechatLabel)
        
        let imageView_y = label_y - 10 - 50
        wechatImageView = UIImageView.init(frame: CGRect.init(x: control_x, y: imageView_y, width: 50, height: 50))
        wechatImageView.image = UIImage.init(named: "share_wechat")
        self.view.addSubview(wechatImageView)
    }
    
    func dismissRegisterController() {
        self.dismiss(animated: true, completion: nil)
    }
}
