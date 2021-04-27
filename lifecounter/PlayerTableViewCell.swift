//
//  PlayerTableViewCell.swift
//  lifecounter
//
//  Created by Lei Ryan on 4/25/21.
//

import UIKit

class PlayerTableViewCell: UITableViewCell,UITextFieldDelegate {

    var model = PlayerModel.init()
    var viewSuper = UIView.init()

    typealias fucBlock = (_ backModel:PlayerModel) ->()
    var blockproerty:fucBlock!
    
    typealias NameBlock = (_ backModel:PlayerModel) ->()
    var blockNameProerty:NameBlock!
    
    @IBOutlet weak var PlayerTitle: UIButton!
    
    @IBOutlet weak var TextField: UITextField!
    
    @IBOutlet weak var lifeTotal: UILabel!
    
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var minusAny: UIButton!
    @IBOutlet weak var plusAny: UIButton!
    @IBOutlet weak var plus: UIButton!
    
    func disAbleAllButton() {
        self.minus.isEnabled = false
        self.minusAny.isEnabled = false
        self.plus.isEnabled = false
        self.plusAny.isEnabled = false
        self.TextField.isEnabled = false
        self.contentView.backgroundColor = UIColor.gray
        self.blockproerty(self.model)
    }
    @IBAction func ChangeNameAction(_ sender: Any) {
        self.blockNameProerty(self.model)
    }
   
    @IBAction func minusAction(_ sender: UIButton) {
        self.model.started = true
        var strHistory = UserDefaults.standard.object(forKey: "History")
        
        let str = NSString.localizedStringWithFormat("%@ lost One life", model.name)
        strHistory = NSString.localizedStringWithFormat("%@,%@",strHistory as! CVarArg,str)
        let str1 = (self.lifeTotal.text ?? "0") as String;
        let val1 = Int(str1)!;
        let life = val1-1
        
        self.lifeTotal.text = String(life)
        if life <= 0 {
            let str1 = NSString.localizedStringWithFormat("%@ LOSES!", model.name)
            strHistory = NSString.localizedStringWithFormat("%@,%@",strHistory as! CVarArg,str1)
            self.lifeTotal.text = String(str1)
            self.disAbleAllButton()
        }
        
        UserDefaults.standard.setValue(strHistory, forKey: "History")
        
        
    }
    @IBAction func plusAction(_ sender: UIButton) {
        self.model.started = true
        var strHistory = UserDefaults.standard.object(forKey: "History")
        let str = NSString.localizedStringWithFormat("%@ gained One life", model.name)
        strHistory = NSString.localizedStringWithFormat("%@,%@",strHistory as! CVarArg,str)
        
        let str1 = (self.lifeTotal.text ?? "0") as String;
        let val1 = Int(str1)!;
        let life = val1+1
        lifeTotal.text = String(life)
        UserDefaults.standard.setValue(strHistory, forKey: "History")
        
    }
    @IBAction func minusAnyAction(_ sender: UIButton) {
        self.model.started = true
        let str:String
        let valTextF:Int
        if (TextField.text != nil) {
            str = NSString.localizedStringWithFormat("%@ lost %@ life", model.name,TextField.text!) as String
            valTextF = Int(TextField.text! as String) ?? 0
        }else{
            str = NSString.localizedStringWithFormat("%@ lost Zero life", model.name) as String
            valTextF = 0
        }
        var strHistory = UserDefaults.standard.object(forKey: "History")
        strHistory = NSString.localizedStringWithFormat("%@,%@",strHistory as! CVarArg,str)
        let str1 = (self.lifeTotal.text ?? "0") as String;
        let val1 = Int(str1)!;
        
        
        let life = val1-valTextF
        lifeTotal.text = String(life)
        if life <= 0 {
            let str1 = NSString.localizedStringWithFormat("%@ LOSES!", model.name)
            strHistory = NSString.localizedStringWithFormat("%@,%@",strHistory as! CVarArg,str1)
            self.lifeTotal.text = String(str1)
            self.disAbleAllButton()
        }
        UserDefaults.standard.setValue(strHistory, forKey: "History")
        
    }
    @IBAction func plusAnyAction(_ sender: UIButton) {
        self.model.started = true
        let str:String
        let valTextF:Int
        if (TextField.text != nil) {
            str = NSString.localizedStringWithFormat("%@ gained %@ life", model.name,TextField.text!) as String
            valTextF = Int(TextField.text! as String) ?? 0
        }else{
            str = NSString.localizedStringWithFormat("%@ gained Zero life", model.name) as String
            valTextF = 0
        }
        var strHistory = UserDefaults.standard.object(forKey: "History")
        strHistory = NSString.localizedStringWithFormat("%@,%@",strHistory as! CVarArg,str)
        
        
        let str1 = (self.lifeTotal.text ?? "0") as String;
        let val1 = Int(str1)!;
        let life = val1+valTextF
        lifeTotal.text = String(life)

        UserDefaults.standard.setValue(strHistory, forKey: "History")
        
    }
    
  
    func Setmodel(modelSet:PlayerModel){
        self.model = modelSet
        self.PlayerTitle.setTitle(self.model.name as String, for: UIControl.State.normal)
        self.lifeTotal.text = self.model.life as String
        self.TextField.text = self.model.plusOrMinus as String
        self.TextField.keyboardType = UIKeyboardType.numberPad
        self.TextField.delegate = self
        
        self.minus.isEnabled = true
        self.minusAny.isEnabled = true
        self.plus.isEnabled = true
        self.plusAny.isEnabled = true
        
        self.TextField.isEnabled = true
        self.contentView.backgroundColor = UIColor.white
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let Tap = UITapGestureRecognizer.init(target: self, action: #selector(TapCellAction))
        viewSuper.addGestureRecognizer(Tap)
        textField.becomeFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text ?? 0)
        
        print(string )
        if string == "" {
           return true
        }
        if (Int(string) != nil) {
            return true
        }
        return false
    }
    
    @objc func TapCellAction() {
        TextField.resignFirstResponder()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
