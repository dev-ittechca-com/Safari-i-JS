//
//  SafariExtensionHandler.swift
//  InjectJS Extension
//
//  Created by Justin Wasack on 5/6/20.
//  Copyright © 2020 Justin Wasack. All rights reserved.
//

import SafariServices
import WebKit

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        if messageName == "REQUEST_SAVED_CODE" {
            if getSavedCode() != nil && UserDefaults.standard.bool(forKey: "toggleOff") != true {
                let code = getSavedCode()!.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
                page.dispatchMessageToScript(withName: "SEND_SAVED_CODE", userInfo: ["code": code])
            }
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was clicked")
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}
