//
//  BaseVC.swift
//  SomeTrain
//
//  Created by listome on 2017/8/1.
//  Copyright © 2017年 listome. All rights reserved.
//

import UIKit

class BaseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //定义变量
    var tableView: UITableView!
    var sectionHeaders:Array<String>!
    var sectionTitles:Array<Array<String>>!
    var sectionSampleClasses: Array<Array<UIViewController.Type>>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "swift测试VC"

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTableData() {
        sectionHeaders = ["A","B","C","D"]
//        sectionTitles = ["A","B","C","D"]
    }

    
    func initTableView() {
        
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.grouped)
        tableView.autoresizingMask = [UIViewAutoresizing.flexibleHeight,UIViewAutoresizing.flexibleWidth]
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

//didselected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        tableView.deselectRow(at: indexPath, animated: false)
//        
//        let section = self.sectionTitles[indexPath.section]
//        let rowTitle = section[indexPath.row]
//        
//        let section_Class = self.sectionSampleClasses[indexPath.section]
//        let vcClass = section_Class[indexPath.row]
//        var vcInstance = vcClass.init()
//        
//        let xibBundlePath = Bundle.main.path(forResource: String(describing:vcClass), ofType: "xib")
//        if (xibBundlePath != nil) {
//            vcInstance = vcClass.init(nibName:String(describing:vcClass), bundle: nil)
//        }
//        
//        vcInstance.title = rowTitle
//        
//        self.navigationController?.pushViewController(vcInstance, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let sectionDef = self.sectionTitles[section]
//        return sectionDef.count
        return sectionTitles.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    
    //MARK:- TableViewDataSource
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionHeaders[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "demoCellIdentifier"
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIdentifier)
        }
        
//        let section = self.sectionTitles[indexPath.section]
//        let rowTitle = section[indexPath.row]
//        
//        let section_Class = self.sectionSampleClasses[indexPath.section]
//        let className = section_Class[indexPath.row]
//        
//        cell!.textLabel?.text = rowTitle
//        cell!.detailTextLabel?.text = String(describing: className)
        
        return cell!
    }
}
