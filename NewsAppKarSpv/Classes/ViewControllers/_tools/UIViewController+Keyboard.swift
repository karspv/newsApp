//
//  UIViewController+Keyboard.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-11.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - Methods
    func registerForKeyboardWillShowNotification(_ scrollView: UIScrollView) {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil,
            using: { [weak self] (notification: Notification) -> Void in
                self?.setContentAndScrollIndicatorInsets(notification: notification, scrollView: scrollView)
            })
    }
    
    func registerForKeyboardWillHideNotification(_ scrollView: UIScrollView) {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil,
            using: { [weak self] (notification: Notification) -> Void in
                self?.removeContentAndScrollIndicatorInsets(notification: notification, scrollView: scrollView)
            })
    }
    
    func removeKeyboardShowAndHideNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Helpers
    private func setContentAndScrollIndicatorInsets(notification: Notification, scrollView: UIScrollView) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            print("ERORR! Could not get keyboard size from nofitication: \(notification)")
            return
        }
        
        let overlappingHeight: CGFloat = keyboardOverlappingHeight(scrollView: scrollView, keyboardFrame: keyboardFrame)
        
        if overlappingHeight > 0 {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: overlappingHeight, right: 0)
            scrollView.setContentAndScrollIndicatorInsets(contentInsets)
        }
    }
    
    private func removeContentAndScrollIndicatorInsets(notification: Notification, scrollView: UIScrollView) {
        scrollView.setContentAndScrollIndicatorInsets(.zero)
        
        guard let duration: TimeInterval = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else {
            print("ERROR! Could not get keyboard animation duration from notification: \(notification)")
            return
        }
        UIView.animate(withDuration: duration) { self.view.layoutIfNeeded() }
    }
    
    private func keyboardOverlappingHeight(scrollView: UIScrollView, keyboardFrame: NSValue) -> CGFloat {
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let viewToAdjustFrame: CGRect = scrollView.convert(scrollView.bounds, to: nil)
        
        let distanceBetweenScreenBottomAndView: CGFloat = screenHeight - viewToAdjustFrame.maxY
        let keyboardHeight: CGFloat = keyboardFrame.cgRectValue.height
        let keyboardOverlappingHeight: CGFloat = keyboardHeight - distanceBetweenScreenBottomAndView
        
        return keyboardOverlappingHeight
    }
}
