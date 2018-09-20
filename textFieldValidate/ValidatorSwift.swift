//
//  ValidatorSwift.swift
//  CARD HOLDER
//
//  Created by Blessed Tree IT on 9/18/18.
//  Copyright © 2018 BTIT. All rights reserved.
//

import UIKit



class ValidatorSwift: UITextField ,UITextFieldDelegate {
   

    
    var  checkAllValidators : Dictionary = [
        "isEmptyValid" : [true ,"" ],
        "isValidEmail" : [true,""],
        "isValidLocalPhone" :[true],
        "isValid6Digit" : [true,""],
        "isValid4Digit" :[true,""],
        "isConfirmedPassword" :[true,""],
        "isPasswordValid": [true,""]
        
        
    ]
    let ErrViewLbl = UIImageView ()
    var ErroImg    = UIImageView()
    var ErroView   = UIView()
    var check = Bool()
     var checking  = Bool()
    public func isEmptyValid (textField : UITextField)-> Bool {
        
        if (textField.text?.utf16.count ==  0)
        {
         
            
          checkAllValidators.updateValue([false, "empty Field"], forKey: "isEmptyValid")
            ErroView = drawErrorView(textField: textField, errorMsg: "empty Field")
            
            textField.addSubview(ErroView)
            check = false
            return check
            
           }
       else
        {
            
            
            checkAllValidators.updateValue([true ,""], forKey: "isEmptyValid")
             removes()
            
            check = true
            return check
            
            
        }
        
    }
    
    
  public func isValidEmail(textField : UITextField) -> Bool {
    
    
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
    
    if (emailTest.evaluate(with: textField.text)){
        checkAllValidators.updateValue([true, ""], forKey: "isValidEmail")
         removes()
        check = true
         return check
    }
    else {
       
        
         checkAllValidators.updateValue([false,"invalid Email" ], forKey: "isValidEmail")
     ErroView = drawErrorView(textField: textField, errorMsg: "missMatch")

    textField.addSubview(ErroView)
        check =  false
      return check
    }
    
    
    }

    
  public func isValidLocalPhone (textField : UITextField) -> Bool{
        if ((textField.text?.utf16.count)! ==  10){
             removes()
            checkAllValidators.updateValue([true,""], forKey: "isValidLocalPhone")
            check = true
             return check
        }
        else{
            let msg = "Please write correct Phone number 07XXXXXXXX"
             ErroView = drawErrorView(textField: textField, errorMsg: msg)
            checkAllValidators.updateValue([false, "invalid Phone number " ], forKey: "isValidLocalPhone")
            textField.addSubview(ErroView)
            check = false
             return check
           
            
        }
        
    }
    
    public func isValid6Digit (textField :UITextField ) -> Bool {
        if (textField.text?.utf16.count ==  6){
             checkAllValidators.updateValue([true, ""], forKey: "isValid6Digit")
             removes()
            check = true
             return check
            
        }
        else
        {
             ErroView = drawErrorViewForSmall(textField: textField, errorMsg: "Enter 6 digits ")
            textField.addSubview(ErroView)
            
              checkAllValidators.updateValue([false, "Enter 6 digits "], forKey: "isValid6Digit")
            check = false
             return check
            
        }
        
    }
    public func isValid4Digit (textField :UITextField ) -> Bool {
        
       
        if (textField.text?.utf16.count ==  4){
            
              checkAllValidators.updateValue([true ,""], forKey: "isValid4Digit")
             removes()
            check = true
             return check
            
        }
        else
        {
            
           
            checkAllValidators.updateValue([false,"Enter 4 digits" ], forKey: "isValid4Digit")
            ErroView = drawErrorViewForSmall(textField: textField, errorMsg: "Enter 4 digits")
           
            textField.addSubview(ErroView)
            check = false
             return check
            
        }
        
    }
    
    public func isConfirmedPassword (textField : UITextField , withTextField : UITextField ) -> Bool {
        if (textField.text  ==  withTextField.text){
             removes()
             checkAllValidators.updateValue([true, ""], forKey: "isConfirmedPassword")
            check = true
             return check
            
        }
        else
        {
             ErroView = drawErrorView(textField: textField, errorMsg: "Not Match ")
                  checkAllValidators.updateValue([false, "Not Match"], forKey: "isConfirmedPassword")
            textField.addSubview(ErroView)
            check = false
             return check
            
        }
        
    }
    
    public func isPasswordValid(textField : UITextField ) -> Bool{
        
        
        /*description of enterede password :
         1 - Password length is 8.
         2 - One Alphabet in Password.
         3 - One Special Character in Password.
         
         
         Explanation:
         
         ^                              - Start Anchor.
         (?=.*[a-z])              -Ensure string has one character.
         (?=.[$@$#!%?&])   -Ensure string has one special character.
         {8,}                            -Ensure password length is 8.
         $                               -End Anchor.
         */
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        
        
        if  (passwordTest.evaluate(with: textField.text)){
             removes()
            checkAllValidators.updateValue([true ,""], forKey: "isPasswordValid")
            check = true
             return check
            
        }
        else{
            
             ErroView = drawErrorView(textField: textField, errorMsg:  "Ensure password length is 8 & has one character & One Alphabet")
              checkAllValidators.updateValue([false ,"Ensure password length is 8 & has one character & One Alphabet"], forKey: "isPasswordValid")
            textField.addSubview(ErroView)
            check = false
             return check
        }
        
    }
    
    
  public  func removes() {
        
        
        ErroView.removeFromSuperview()
        
    }

   public func drawErrorViewForSmall( textField :  UITextField , errorMsg : String) ->  UIView{
        let customView =  ErrPop.instantiateFromNib()
        customView.errMsgLbl.text = errorMsg
        let cuswidth : CGFloat = evaluateStringWidth(textToEvaluate: errorMsg)
        customView.frame.size = CGSize(width:cuswidth , height:customView.frame.size.height )
        
        customView.errMsgView.layer.cornerRadius = 10
    
        
        textField.leftViewMode = UITextFieldViewMode.always
        
        ErrViewLbl.frame = CGRect(x:textField.frame.size.width - customView.frame.size.width , y:textField.frame.size.height+20, width: textField.frame.size.width - 40 , height: textField.frame.size.height - 10)
        
        ErrViewLbl.addSubview(customView)
        return ErrViewLbl
    }
   public func drawErrorView( textField :  UITextField , errorMsg : String) ->  UIView{
        let customView =  ErrPop.instantiateFromNib()
        customView.errMsgLbl.text = errorMsg
        let cuswidth : CGFloat = evaluateStringWidth(textToEvaluate: errorMsg)
       customView.frame.size = CGSize(width:cuswidth , height:customView.frame.size.height )
        
        
        customView.errMsgView.layer.cornerRadius = 10
        
           textField.leftViewMode = UITextFieldViewMode.always
       
        ErrViewLbl.frame = CGRect(x:textField.frame.size.width - customView.frame.size.width , y: 0, width: textField.frame.size.width - 40 , height: textField.frame.size.height - 10)
        
         ErrViewLbl.addSubview(customView)
         return ErrViewLbl
    }
 public   func evaluateStringWidth (textToEvaluate: String) -> CGFloat{
        
           let font = UIFont(name: "Helvetica", size: 13)
            let fontAttributes = [NSAttributedStringKey.font: font]
            let myText = "Your Text Here"
        let size = (myText as NSString).size(withAttributes: fontAttributes as Any as? [NSAttributedStringKey : Any])
        
        return size.width
        
    }
    
    public func validate () -> (Bool ,String) {
        
        var ErrorMsg :String = ""
        
        for  key in checkAllValidators {
            
            let item  = key.value[0]
            if (item as! Bool){
                checking = true
                
            }
            else {
                print("the invalid :" ,key.value[1] )
                checking = false
                ErrorMsg = key.value[1] as! String
            }

          
            }
    return (checking ,ErrorMsg)
    }
    
    

    public func validatetext (textField : UITextField) -> Bool{
        
        
        if(check){
            
            ErroImg.removeFromSuperview()
            ErroView.removeFromSuperview()
            
            
        }
        else {
            
         //   textField.addSubview(drawErrImage(textField: textField))
            
        }
        
        
        return check
    }
    
}
