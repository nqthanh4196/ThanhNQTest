//
//  ViewControllerHelper.swift
//  testScrollview
//
//  Created by IT-17426-THANH on 03/04/2024.
//

import Foundation
import UIKit

extension UIViewController {
    //**************************************************************************/
    // MARK: - InitViewController
    /**************************************************************************/
    class func loadNib() -> Self
    {
        return loadNib(type: self)
    }
    private class func loadNib<T: UIViewController>(type: T.Type) -> T
    {
        return T(nibName: T.className, bundle: nil)
    }
    
    class func instantiateFromStoryboard(storyboardName: String) -> Self
    {
        return instantiateFromStoryboardHelper(type: self, storyboardName: storyboardName)
    }
    private class func instantiateFromStoryboardHelper<T>(type: T.Type, storyboardName: String) -> T
    {
        var storyboardId = ""
        
        let components = "\(self)".components(separatedBy: ".")
        if components.count > 1
        {
            storyboardId = components[1]
        }
        else {
            storyboardId = components[0]
        }
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
        
        return controller
    }
}
