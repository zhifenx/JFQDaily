//
//  ReaderToolbarView.swift
//  JFQDaily
//
//  Created by zhifenx on 2017/8/2.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

import UIKit

@objc(ReaderToolbarViewDelegate)
protocol ReaderToolbarViewDelegate: class {
    func back()
}

class ReaderToolbarView: UIView {
    
    weak var delegate: ReaderToolbarViewDelegate?
    var backButton: UIButton!
    var commentButton: UIButton!
    var likeButton: UIButton!
    var shareButton: UIButton!
    var separator: UIView!
    
    
    @objc override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        separator = UIView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: 0.5))
        separator.backgroundColor = UIColor.init(white: 0.9, alpha: 0.7)
        self.addSubview(separator)
        
        addChildControls()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addChildControls() {
        addBackButton()
        let shareButton_x = UIScreen.main.bounds.size.width - 30;
        addShareButton(x: shareButton_x)
        let likeButton_x = shareButton_x - 17 - 30
        addLikeButton(x: likeButton_x)
        let conmmetButton_x = likeButton_x - 20 - 30
        addCommentButton(x:conmmetButton_x)
    }
    
    func addBackButton() {
        backButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: self.frame.size.height))
        backButton.setImage(UIImage.init(named: "toolbarBack"), for: .normal)
        backButton.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
        self.addSubview(backButton)
    }
    
    func addShareButton(x: CGFloat) {
        let shareButton_y: CGFloat = self.frame.size.height / 2 - 18 / 2 - 5
        shareButton = UIButton.init(frame: CGRect.init(x: x, y: shareButton_y, width: 17, height: 22))
        shareButton.setImage(UIImage.init(named: "toolbarShare"), for: .normal)
        self.addSubview(shareButton)
    }
    
    func addLikeButton(x: CGFloat) {
        let likeButton_y: CGFloat = self.frame.size.height / 2 - 18 / 2
        likeButton = UIButton.init(frame: CGRect.init(x: x, y: likeButton_y, width: 20, height: 17))
        likeButton.setImage(UIImage.init(named: "toolbarLike"), for: .normal)
        self.addSubview(likeButton)
    }
    
    func addCommentButton(x: CGFloat) {
        let commentButton_y: CGFloat = self.frame.size.height / 2 - 18 / 2
        commentButton = UIButton.init(frame: CGRect.init(x: x, y: commentButton_y, width: 20, height: 18))
        commentButton.setImage(UIImage.init(named: "toolbarComment"), for: .normal)
        self.addSubview(commentButton)
    }
    
    func touchUpBackButton() {
        if delegate != nil {
            self.delegate?.back()
        }
    }
}
