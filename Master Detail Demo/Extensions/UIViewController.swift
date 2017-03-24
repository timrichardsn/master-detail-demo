//
//  UIViewController.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 17/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class var name:String {
        return String(describing: self)
    }
    
    class func instance<A:UIViewController>(in storyboard:Storyboard) -> A {
        // in production, a more elegant solution for getting the correct storyboard would need to be implemented
        return storyboard.instance.instantiateViewController(withIdentifier: name) as! A
    }
}
