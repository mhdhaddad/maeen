//
//  DialogActionView.swift
//  Maeen
//
//  Created by yahya alshaar on 10/8/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class DialogActionView: UIView {
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var constraintTopAligendLblMsgWithParent: NSLayoutConstraint!
    @IBOutlet weak var constraintTopLblMsgWithImgIcon: NSLayoutConstraint!
    
    weak var delegate: DialogActionViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        lblMsg.textColor = UIColor.primary
        lblMsg.font = UIFont.font(from: .title2)
        
        btnAction.backgroundColor = UIColor.tint
        btnAction.tintColor = UIColor.white
        btnAction.titleLabel?.font = UIFont.font(from: .action)
    }
    @IBAction func btnAction_TouchUpInside(_ sender: Any) {
        delegate?.didTriggerAction()
    }
    
    class func loadFromNib(msg: String, action: String, icon: UIImage? = nil, delegate: DialogActionViewDelegate?) -> DialogActionView? {
        let view = Bundle.main.loadNibNamed("DialogActionView", owner: self, options: nil)?.first as? DialogActionView
        view?.btnAction.setTitle(action, for: .normal)
        view?.lblMsg.text = msg
        view?.delegate = delegate
        view?.imgIcon.image = icon
        
        if icon == nil {
            view?.constraintTopAligendLblMsgWithParent.priority = .defaultHigh
            view?.constraintTopLblMsgWithImgIcon.priority = .defaultLow
        }else {
            view?.constraintTopAligendLblMsgWithParent.priority = .defaultLow
            view?.constraintTopLblMsgWithImgIcon.priority = .defaultHigh
        }
        
        return view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnAction.layer.cornerRadius = btnAction.frame.height/2
    }
}
protocol DialogActionViewDelegate: class {
    func didTriggerAction()
}
