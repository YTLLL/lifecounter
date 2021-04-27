//
//  PlayerNameChangeView.swift
//  lifecounter
//
//  Created by Lei Ryan on 4/26/21.
//

import UIKit

class PlayerNameChangeView: UIView ,UITextFieldDelegate{
    
    typealias NameBlock = (_ backModel:String) ->()
    var blockName:NameBlock!
    var model = PlayerModel.init()
    
    let KWidth = UIScreen.main.bounds.size.width
    let Kheight = UIScreen.main.bounds.size.height
    let textf = UITextField.init()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        self.frame = CGRect(x: 0, y: 0, width: KWidth, height: Kheight)
        self.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3)
        
        let viewBase = UIView.init(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        viewBase.center = CGPoint(x: KWidth/2.0, y: Kheight/2.0)
        viewBase.backgroundColor = UIColor.white
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 10, width: 300, height: 40))
        label.textAlignment = .center
        label.text = "change player name"
        
        textf.frame = CGRect(x: 20, y: 60, width: 300-40, height: 40)
        textf.backgroundColor = UIColor.lightGray
        textf.delegate = self
        textf.text = self.model.name as String
        let button = UIButton.init(frame: CGRect(x: 100, y: 200, width: 100, height: 40))
        button.setTitle("OK", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(buttonAction), for: UIControl.Event.touchUpInside)
        button.backgroundColor = UIColor.black
        
        viewBase.addSubview(label)
        viewBase.addSubview(textf)
        viewBase.addSubview(button)
        self.addSubview(viewBase)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(TapAction))
        self.addGestureRecognizer(tap)
    }
    @objc func TapAction()  {
        self.textf.resignFirstResponder()
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
    @objc func buttonAction(){
        self.removeFromSuperview()
        self.blockName(self.textf.text ?? "")
    }

}
