//
//  PopupDialog + LoadingViewController.swift
//  Maeen
//
//  Created by yahya alshaar on 7/25/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//


import PopupDialog

extension PopupDialog {
    class func waitingPopup() -> PopupDialog {
        let vc = LoadingViewController(nibName: "LoadingViewController", bundle: nil)
        return PopupDialog(viewController: vc, buttonAlignment: .horizontal, transitionStyle: .zoomIn, gestureDismissal: false, completion: nil)
    }
}
