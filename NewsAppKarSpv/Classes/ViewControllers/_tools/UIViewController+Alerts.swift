//
//  UIViewController+Alerts.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-18.
//

import Foundation
import UIKit

class ActionSheetAction {
    let title: String
    let didPressAction: (() -> Void)
    
    init(title: String, didPressAction: @escaping () -> Void) {
        self.title = title
        self.didPressAction = didPressAction
    }
}

extension UIViewController {
    
    // MARK: - Public methods
    func showGenericNetworkAlert() {
        present(alertControllerWithAlertStyle(alertTitle: R.string.localizable.oops(),
                                              alertMessage: R.string.localizable.somethingWentWrongWhileLoadingTheData(),
                                              actionTitle: R.string.localizable.oK()), animated: true, completion: nil)
    }
    
    func showNoFavouritesAlert() {
        present(alertControllerWithAlertStyle(alertTitle: R.string.localizable.oops(),
                                              alertMessage: R.string.localizable.looksLikeYouDonTHaveAnyFavouriteArticlesGoToSourceScreenAndAddSome(),
                                              actionTitle: R.string.localizable.oK()), animated: true, completion: nil)
    }
    
    func showActionSheetAlert(title: String, actionList: [ActionSheetAction]) {
        let actionSheetController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        for action: ActionSheetAction in actionList {
            appendAction(to: actionSheetController, with: action.title, action: action.didPressAction)
        }
        
        actionSheetController.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .cancel))
        present(actionSheetController, animated: true, completion: nil)
    }
    
    // MARK: - Private Helpers
    private func alertControllerWithAlertStyle(alertTitle: String, alertMessage: String, actionTitle: String) -> UIAlertController {
        let alertController = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        
        return alertController
    }
    
    private func appendAction(to actionSheet: UIAlertController, with title: String, action: @escaping () -> Void) {
        actionSheet.addAction(UIAlertAction(title: title, style: .default, handler: { (_) in
            action()
        }))
    }
}
