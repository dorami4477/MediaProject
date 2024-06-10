//
//  ReusableID.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/10/24.
//

import UIKit

protocol ReuseIdentifierProtocol{
    static var identifier:String { get }
}


extension UITableViewCell:ReuseIdentifierProtocol{
    static var identifier:String{
        return String(describing: self)
    }
}

extension UIViewController:ReuseIdentifierProtocol{
    static var identifier:String{
        return String(describing: self)
    }
}
