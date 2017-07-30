//
//  RegisterContriller.swift
//  JFQDaily
//
//  Created by zhifenx on 2017/7/27.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    let interval: CGFloat = 30 //微信、微博、QQ三按钮间隙
    let screenSize = UIScreen.main.bounds.size
    
    var phone: UITextField!
    var verificationCode: UITextField!
    
    var nextStep:UIButton!
    var toLogInButton: UIButton!
    var thirdPartyLoginLabel: UILabel!
    var dismissButton: UIButton!
    var registerLabel: UILabel!
    var logoImageView: UIImageView!
    var wechatLoginButton: UIButton!
    var qqLoginButton: UIButton!
    var weiboLgionButton: UIButton!
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
        let label_x: CGFloat = screenSize.width / 2 - label_w / 2
        registerLabel = UILabel.init(frame: CGRect(x: label_x, y: 44, width: label_w, height: 21))
        registerLabel.textAlignment = .center//可以这样写（NSTextAlignment.center)，这里使用简写
        registerLabel.text = "注册新账号"
        self.view.addSubview(registerLabel)
        
        //logo
        let logo_x: CGFloat = screenSize.width / 2 - 80 / 2
        logoImageView = UIImageView(frame: CGRect(x: logo_x, y: 100, width: 80, height: 80))
        logoImageView.image = UIImage.init(named: "logo-1_80x80_")
        self.view.addSubview(logoImageView)
        
        let wechat_x: CGFloat = (screenSize.width - 50 * 3 - interval * 2)/2
        let shareLabel_y: CGFloat = screenSize.height - 21 - 40
        let shareButton_y = shareLabel_y - 10 - 50
        wechatLoginButton = thirdPartyLoginButton(x: wechat_x, y: shareButton_y, imageName: "shareWechatFriends")
        wechatLoginButton.addTarget(self, action: #selector( thirdPartyLoginEvent), for: .touchUpInside)
        self.view.addSubview(wechatLoginButton)
        wechatLabel = thirdPartyLoginLabel(x: wechat_x, y: shareLabel_y, title: "微信")
        self.view.addSubview(wechatLabel)
        
        let weibo_x = wechat_x + 30 + 50
        weiboLgionButton = thirdPartyLoginButton(x: weibo_x, y: shareButton_y, imageName: "shareWeibo")
        weiboLgionButton.addTarget(self, action: #selector( thirdPartyLoginEvent), for: .touchUpInside)
        self.view.addSubview(weiboLgionButton)
        weiboLabel = thirdPartyLoginLabel(x: weibo_x, y: shareLabel_y, title: "微博")
        self.view.addSubview(weiboLabel)
        
        let qq_x = weibo_x + 30 + 50
        qqLoginButton = thirdPartyLoginButton(x: qq_x, y: shareButton_y, imageName: "shareQQ")
        qqLoginButton.addTarget(self, action: #selector( thirdPartyLoginEvent), for: .touchUpInside)
        self.view.addSubview(qqLoginButton)
        qqLabel = thirdPartyLoginLabel(x: qq_x, y: shareLabel_y, title: "QQ")
        self.view.addSubview(qqLabel)
        
        thirdPartyLoginTitle(title_y: shareButton_y - 30)
        toLogInButton(toLogIn_y: thirdPartyLoginLabel.frame.origin.y - 21 - 30)
        nextStepButton(nextStep_y: toLogInButton.frame.origin.y - 21 - 40)
        
        let phoneTextField_y = logoImageView.frame.origin.y + logoImageView.frame.size.height + 30
        phoneTextField(phone_y: phoneTextField_y)
        
        let separator1_y = phoneTextField_y + 44;
        self.view.addSubview(theSeparator(theSeparator_y: separator1_y))
        
        verificationCodeTextField(verificationCode_y: phoneTextField_y + 44 + 1)
        
        let separator2_y = verificationCode.frame.origin.y + 44
        self.view.addSubview(theSeparator(theSeparator_y: separator2_y))
    }
    
    func phoneTextField(phone_y: CGFloat) {
        phone = UITextField.init(frame: CGRect.init(x: 20, y: phone_y, width: screenSize.width - 20, height: 44))
        phone.placeholder = "手机号码（+86）"
        self.view.addSubview(phone)
    }
    
    func verificationCodeTextField(verificationCode_y: CGFloat) {
        verificationCode = UITextField.init(frame: CGRect.init(x: 20, y: verificationCode_y, width: screenSize.width - 20, height: 44))
        verificationCode.placeholder = "验证码"
        self.view.addSubview(verificationCode)
    }
    
    func theSeparator(theSeparator_y: CGFloat) -> UIView {
        let separator = UIView.init(frame: CGRect.init(x: 20, y: theSeparator_y, width: screenSize.width - 20, height: 0.5))
        separator.backgroundColor = UIColor.init(colorLiteralRed: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        return separator
    }
    
    func nextStepButton(nextStep_y: CGFloat) {
        nextStep = UIButton.init()
        nextStep.frame.size = CGSize.init(width: 200, height: 50)
        nextStep.center = CGPoint.init(x: self.view.center.x, y: nextStep_y)
        nextStep.layer.cornerRadius = 25
        nextStep.layer.masksToBounds = true
        nextStep.setTitle("下一步", for: .normal)
        nextStep.titleLabel?.font = UIFont.init(name: "Helvetica-Bold", size: 17.0)
        nextStep.setTitleColor(UIColor.white, for: .normal)
        nextStep.backgroundColor = UIColor.init(red: 253/255.0, green: 190/255.0, blue: 27/255.0, alpha: 1)
        nextStep.addTarget(self, action: #selector(nextStepEvent), for: .touchUpInside)
        self.view.addSubview(nextStep)
    }
    
    func toLogInButton(toLogIn_y: CGFloat) {
        toLogInButton = UIButton.init()
        toLogInButton.frame.size = CGSize.init(width: 200, height: 21)
        toLogInButton.center = CGPoint.init(x: self.view.center.x, y: toLogIn_y)
        toLogInButton.setTitle("已有 Qdaily 账号？", for: .normal)
        toLogInButton.setTitleColor(.black, for: .normal)
        toLogInButton.addTarget(self, action: #selector(toLogin), for: .touchUpInside)
        self.view.addSubview(toLogInButton)
    }
    
    func thirdPartyLoginTitle(title_y: CGFloat) {
        thirdPartyLoginLabel = UILabel.init()
        thirdPartyLoginLabel.frame.size = CGSize.init(width: 150, height: 21)
        thirdPartyLoginLabel.center = CGPoint.init(x: self.view.center.x, y: title_y)
        thirdPartyLoginLabel.text = "第三方账号登录"
        thirdPartyLoginLabel.textAlignment = .center
        thirdPartyLoginLabel.font = UIFont.systemFont(ofSize: 12)
        thirdPartyLoginLabel.textColor = UIColor.init(red: 210/255.0, green: 210/255.0, blue: 210/255.0, alpha: 1)
        self.view.addSubview(thirdPartyLoginLabel)
    }
    
    func thirdPartyLoginButton(x: CGFloat, y: CGFloat, imageName: String) -> UIButton {
        let button = UIButton.init(frame: CGRect.init(x: x, y: y, width: 50, height: 50))
        button.setImage(UIImage.init(named: imageName), for: .normal)
        return button
    }
    
    func thirdPartyLoginLabel(x: CGFloat, y: CGFloat, title: String) -> UILabel {
        let label = UILabel.init(frame: CGRect.init(x: x, y: y, width: 50, height: 21))
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = title
        return label
    }
    
    func nextStepEvent() {
        MBProgressHUD.promptHudWithShowAdded(to: self.view, message: "接下来去踢球吧！")
    }
    
    func thirdPartyLoginEvent() {
        MBProgressHUD.promptHudWithShowAdded(to: self.view, message: "第三方登录待完善！")
    }
    
    func toLogin() {
        print("去到登录")
        let loginVC = LoginController()
        self.present(loginVC, animated: true, completion: nil)
    }
    
    func dismissRegisterController() {
        self.dismiss(animated: true, completion: nil)
    }
}
