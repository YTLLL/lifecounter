//
//  HistoryViewController.swift
//  lifecounter
//
//  Created by Lei Ryan on 4/26/21.
//

import UIKit

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let table = UITableView.init()
    let KWidth = UIScreen.main.bounds.size.width
    let Kheight = UIScreen.main.bounds.size.height
    let buttonBack = UIButton.init()
    var arrayData = NSArray.init()
    
    @objc func buttonBackAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()

        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChangeA(_ :)), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        buttonBack.frame = CGRect.init(x: 10, y: 40, width: 50, height: 40)
        buttonBack.setTitle("Back", for: UIControl.State.normal)
        buttonBack.titleLabel?.textColor = UIColor.white
        buttonBack.backgroundColor = UIColor.black
        buttonBack.addTarget(self, action: #selector(buttonBackAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(buttonBack)
        
        
        table.frame = CGRect(x: 0, y: 100, width:KWidth , height: Kheight-150)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(table)
    }
  
    override func viewDidAppear(_ animated: Bool) {
        let strHistory = UserDefaults.standard.object(forKey: "History") as! String
        let char:CharacterSet = [","];
        let elementarr = strHistory.components(separatedBy: char);
        
        arrayData = elementarr as NSArray
        
        self.table.reloadData()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = arrayData[indexPath.row] as? String
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    @objc  func orientationDidChangeA(_ notification:Notification) {

        let deviceOrientation = UIDevice.current.orientation
        if deviceOrientation == .portrait {
            table.frame = CGRect(x: 0, y: 100, width:KWidth , height: Kheight-150)
        }else if deviceOrientation == .landscapeLeft || deviceOrientation == .landscapeRight{
            table.frame = CGRect(x: 0, y: 100, width:Kheight , height: KWidth-150)
            
        }

    }
    
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
