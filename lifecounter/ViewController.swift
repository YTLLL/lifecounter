//
//  ViewController.swift
//  lifecounter
//
//  Created by Lei Ryan on 4/23/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{

    var arrayData = NSMutableArray.init()
    var table = UITableView.init()
    var buttonRight = UIButton.init()
    var buttonleft = UIButton.init()
    var buttonStart = UIButton.init()
    var buttonReset = UIButton.init()
    var buttonHistory = UIButton.init()
    
    var buttonGameOver = UIButton.init()
    let KWidth = UIScreen.main.bounds.size.width
    let Kheight = UIScreen.main.bounds.size.height
     

    @objc func buttonHistoryAction()  {
        let vc = HistoryViewController.init()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @objc func ResetGameAction()  {
        self.ReStart()
    }
    @objc func StartGameAction()  {
        self.buttonleft.isEnabled = false
        self.buttonleft.backgroundColor = UIColor.lightGray
        self.buttonRight.isEnabled = false
        self.buttonRight.backgroundColor = UIColor.lightGray
    }
    @objc func ADDNewPlayerAction()  {
        if arrayData.count < 8 {
            let count = arrayData.count+1
            let modelA = PlayerModel.init()
            modelA.plusOrMinus = "5"
            modelA.life = "20"
            modelA.name = NSString.localizedStringWithFormat("Player%d", count)
            arrayData.add(modelA)
            self.table.reloadData()
        }
    }
    @objc func ReducePlayerAction()  {
        if arrayData.count > 2 {
            arrayData.removeLastObject()
            self.table.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()

        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange(_ :)), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        let strHistory = UserDefaults.standard.object(forKey: "History")
        if strHistory == nil {
            UserDefaults.standard.setValue("", forKey: "History")
        }
    
        self.setViewFrame()
        
        buttonRight.setTitle("add Player", for: UIControl.State.normal)
        buttonRight.titleLabel?.textColor = UIColor.white
        buttonRight.backgroundColor = UIColor.black
        buttonRight.addTarget(self, action: #selector(ADDNewPlayerAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(buttonRight)
      
     
        buttonleft.setTitle("reduce Player", for: UIControl.State.normal)
        buttonleft.titleLabel?.textColor = UIColor.white
        buttonleft.backgroundColor = UIColor.black
        buttonleft.addTarget(self, action: #selector(ReducePlayerAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(buttonleft)
      
        buttonStart.setTitle("Start Game", for: UIControl.State.normal)
        buttonStart.titleLabel?.textColor = UIColor.white
        buttonStart.backgroundColor = UIColor.black
        buttonStart.addTarget(self, action: #selector(StartGameAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(buttonStart)
       
        buttonReset.setTitle("Reset Game", for: UIControl.State.normal)
        buttonReset.titleLabel?.textColor = UIColor.white
        buttonReset.backgroundColor = UIColor.black
        buttonReset.addTarget(self, action: #selector(ResetGameAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(buttonReset)
      
        buttonReset.setTitle("Reset Game", for: UIControl.State.normal)
        buttonReset.titleLabel?.textColor = UIColor.white
        buttonReset.backgroundColor = UIColor.black
        buttonReset.addTarget(self, action: #selector(ResetGameAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(buttonReset)
        
        
        buttonHistory.setTitle("History", for: UIControl.State.normal)
        buttonHistory.titleLabel?.textColor = UIColor.white
        buttonHistory.backgroundColor = UIColor.black
        buttonHistory.addTarget(self, action: #selector(buttonHistoryAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(buttonHistory)
        
        table.register(UINib.init(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 100
       
        self.view.addSubview(table)
        
        
        self.ReStart()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell:PlayerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PlayerTableViewCell
        Cell.viewSuper = self.table
        let model:PlayerModel = arrayData[indexPath.row] as! PlayerModel
        Cell.Setmodel(modelSet: model)
        Cell.blockproerty = { (backModel) in
            var Count = 0
            for i in 0..<self.arrayData.count {
                let modelTemp:PlayerModel = self.arrayData[i] as! PlayerModel
                if modelTemp.started {
                    self.StartGameAction()
                }
                if modelTemp.isDead {
                    Count+=1
                }
            }
            if Count == self.arrayData.count {
                self.GameOver()
            }
        }
        Cell.blockNameProerty = {(backModel) in
            
            self.ShowChangeNameView(model: backModel)
        }
        return Cell
    }
    
    func ShowChangeNameView(model:PlayerModel) {
        let view = PlayerNameChangeView.init(frame: CGRect(x: 0, y: 0, width: KWidth, height: Kheight))
        view.model = model
        view.blockName = {(name) in
            model.name = name as NSString
            self.table.reloadData()
        }
        self.buttonleft.isEnabled = true
        self.buttonleft.backgroundColor = UIColor.black
        self.buttonRight.isEnabled = true
        self.buttonRight.backgroundColor = UIColor.black
        self.view.addSubview(view)
    }
    
    @objc func ReStart(){
        self.buttonleft.isEnabled = true
        self.buttonleft.backgroundColor = UIColor.black
        self.buttonRight.isEnabled = true
        self.buttonRight.backgroundColor = UIColor.black
        
        buttonGameOver.removeFromSuperview()
        arrayData.removeAllObjects()
        for i in 1..<5 {
            let modelA = PlayerModel.init()
            modelA.plusOrMinus = "5"
            modelA.life = "20"
            modelA.isDead = false
            modelA.started = false
            modelA.name = NSString.localizedStringWithFormat("Player%d", i)
            arrayData.add(modelA)
        }
        table.reloadData()
        //remove history
        UserDefaults.standard.setValue("", forKey: "History")
        

    }
    func GameOver() {
        buttonGameOver = UIButton.init(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        buttonGameOver.setTitle("Game over!", for: UIControl.State.normal)
        buttonGameOver.backgroundColor = UIColor.red
        buttonGameOver.center = self.view.center
        buttonGameOver.addTarget(self, action: #selector(ReStart), for: UIControl.Event.touchUpInside)
        self.view.addSubview(buttonGameOver)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }


    @objc func orientationDidChange(_ notification:Notification) {

        let deviceOrientation = UIDevice.current.orientation
        if deviceOrientation == .portrait {
            buttonRight.frame = CGRect.init(x: KWidth-150, y: 40, width: 140, height: 40)
            buttonleft.frame = CGRect.init(x: 10, y: 40, width: 140, height: 40)
            table.frame = CGRect.init(x: 0, y: 150, width: KWidth, height: Kheight-200)
            buttonStart.frame = CGRect.init(x: KWidth-150, y: 90, width: 140, height: 40)
            buttonReset.frame = CGRect.init(x: 10, y: 90, width: 140, height: 40)
            buttonHistory.frame = CGRect.init(x: KWidth-150, y: Kheight-50, width: 140, height: 40)
            
        }else if deviceOrientation == .landscapeLeft || deviceOrientation == .landscapeRight{
            buttonRight.frame = CGRect.init(x: Kheight-150, y: 40, width: 140, height: 40)
            buttonleft.frame = CGRect.init(x: 10, y: 40, width: 140, height: 40)
            table.frame = CGRect.init(x: 0, y: 150, width: Kheight, height: KWidth-200)
            buttonStart.frame = CGRect.init(x: Kheight-150, y: 90, width: 140, height: 40)
            buttonReset.frame = CGRect.init(x: 10, y: 90, width: 140, height: 40)
            buttonHistory.frame = CGRect.init(x: Kheight-150, y: KWidth-50, width: 140, height: 40)
        }

    }
    
    func setViewFrame() {
        
        buttonHistory.frame = CGRect.init(x: KWidth-150, y: Kheight-50, width: 140, height: 40)
        
        buttonRight.frame = CGRect.init(x: KWidth-150, y: 40, width: 140, height: 40)
        buttonleft.frame = CGRect.init(x: 10, y: 40, width: 140, height: 40)
        
        buttonStart.frame = CGRect.init(x: KWidth-150, y: 90, width: 140, height: 40)
        buttonReset.frame = CGRect.init(x: 10, y: 90, width: 140, height: 40)
        
        table.frame = CGRect.init(x: 0, y: 150, width: KWidth, height: Kheight-200)
    }
}


