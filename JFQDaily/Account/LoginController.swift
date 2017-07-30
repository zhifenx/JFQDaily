//
//  LoginController.swift
//  JFQDaily
//
//  Created by zhifenx on 2017/7/27.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    let screenSize = UIScreen.main.bounds.size
    
    var dismissButton: UIButton!
    var loginLabel: UILabel!
    var logoImageView: UIImageView!
    var phone: UITextField!
    var password: UITextField!
    var login: UIButton!
    var toRegisterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = UIScreen.main.bounds
        self.view.backgroundColor = UIColor.white
        
        addSubControl()
    }
    
    func addSubControl() {
        //退出按钮
        dismissButton = UIButton.init(frame: CGRect(x: 20, y: 44, width: 10, height: 18))
        dismissButton.setImage(UIImage.init(named: "back icon_10x18_"), for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissRegisterController), for: .touchUpInside)
        self.view.addSubview(dismissButton)
        
        //注册新账号 label
        let label_w: CGFloat = 100
        let label_x: CGFloat = screenSize.width / 2 - label_w / 2
        loginLabel = UILabel.init(frame: CGRect(x: label_x, y: 44, width: label_w, height: 21))
        loginLabel.textAlignment = .center//可以这样写（NSTextAlignment.center)，这里使用简写
        loginLabel.text = "登录"
        self.view.addSubview(loginLabel)
        
        //logo
        let logo_x: CGFloat = screenSize.width / 2 - 80 / 2
        logoImageView = UIImageView(frame: CGRect(x: logo_x, y: 100, width: 80, height: 80))
        logoImageView.image = UIImage.init(named: "logo-1_80x80_")
        self.view.addSubview(logoImageView)
        
        let phoneTextField_y = logoImageView.frame.origin.y + logoImageView.frame.size.height + 30
        phoneTextField(phone_y: phoneTextField_y)
        
        let separator1_y = phoneTextField_y + 44;
        self.view.addSubview(theSeparator(theSeparator_y: separator1_y))
        
        passwordTextField(verificationCode_y: phoneTextField_y + 44 + 1)
        
        let separator2_y = password.frame.origin.y + 44
        self.view.addSubview(theSeparator(theSeparator_y: separator2_y))
        
        let loginButton_y = separator2_y + 80
        loginButton(login_y: loginButton_y)
        toRegisterButton(toLogIn_y: loginButton_y + 50 + 80)
    }
    
    func phoneTextField(phone_y: CGFloat) {
        phone = UITextField.init(frame: CGRect.init(x: 20, y: phone_y, width: screenSize.width - 20, height: 44))
        phone.placeholder = "手机号码/邮箱"
        self.view.addSubview(phone)
    }
    
    func theSeparator(theSeparator_y: CGFloat) -> UIView {
        let separator = UIView.init(frame: CGRect.init(x: 20, y: theSeparator_y, width: screenSize.width - 20, height: 0.5))
        separator.backgroundColor = UIColor.init(colorLiteralRed: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        return separator
    }
    
    func passwordTextField(verificationCode_y: CGFloat) {
        password = UITextField.init(frame: CGRect.init(x: 20, y: verificationCode_y, width: screenSize.width - 20, height: 44))
        password.placeholder = "密码"
        self.view.addSubview(password)
    }
    
    func loginButton(login_y: CGFloat) {
        login = UIButton.init()
        login.frame.size = CGSize.init(width: 200, height: 50)
        login.center = CGPoint.init(x: self.view.center.x, y: login_y)
        login.layer.cornerRadius = 25
        login.layer.masksToBounds = true
        login.setTitle("登录", for: .normal)
        login.titleLabel?.font = UIFont.init(name: "Helvetica-Bold", size: 17.0)
        login.setTitleColor(UIColor.white, for: .normal)
        login.backgroundColor = UIColor.init(red: 253/255.0, green: 190/255.0, blue: 27/255.0, alpha: 1)
        login.addTarget(self, action: #selector(loginEvent), for: .touchUpInside)
        self.view.addSubview(login)
    }
    
    func toRegisterButton(toLogIn_y: CGFloat) {
        toRegisterButton = UIButton.init()
        toRegisterButton.frame.size = CGSize.init(width: 200, height: 21)
        toRegisterButton.center = CGPoint.init(x: self.view.center.x, y: toLogIn_y)
        toRegisterButton.setTitle("注册新账号", for: .normal)
        toRegisterButton.setTitleColor(.black, for: .normal)
        toRegisterButton.addTarget(self, action: #selector(dismissRegisterController), for: .touchUpInside)
        self.view.addSubview(toRegisterButton)
    }

    func loginEvent() {
        MBProgressHUD.promptHudWithShowAdded(to: self.view, message: "未获取登录功能接口")
    }
    
    func dismissRegisterController() {
        self.dismiss(animated: true, completion: nil)
    }
}
