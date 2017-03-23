//
//  Storyboard.swift
//  Master Detail Demo
//
//  Created by Tim Richardson on 23/03/2017.
//  Copyright © 2017 TRCO. All rights reserved.
//

import UIKit

enum Storyboard {
    case main
}

extension Storyboard {
    var instance:UIStoryboard {
        switch self {
        case .main: return UIStoryboard(name: "Main", bundle: nil)
        }
    }
}
