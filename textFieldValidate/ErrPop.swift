//
//  ErrPop.swift
//  CARD HOLDER
//
//  Created by Blessed Tree IT on 9/19/18.
//  Copyright © 2018 BTIT. All rights reserved.
//

import UIKit

class ErrPop: UIView {

    @IBOutlet weak var errMsgLbl: UILabel!
    @IBOutlet weak var errMsgView: UIView!
    class func instantiateFromNib() -> ErrPop {
        
        
        
        return Bundle.main.loadNibNamed("ErrPop", owner: nil, options: nil)!.first as! ErrPop
    }

}
