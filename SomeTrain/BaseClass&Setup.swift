//
//  BaseClass&Setup.swift
//  SomeTrain
//
//  Created by listome on 2017/7/12.
//  Copyright © 2017年 listome. All rights reserved.
//

import UIKit


/*********************************************************************
 
 类和结构体命名首字母大写，属性和方法命名首字母小写
 1.guard let 和 if let 相反。表示一定有值,没有就直接返回
 2.降低分支层次结构
 3.playground不能展示效果，要在函数中展示
 ********************************************************************/

//MARK:创建  类 & 结构体
class test{
    var width = 10
    var height = 20
    var third = JiegouTi()
    
    func demo() {
        let aNick:String? = "Soveriegn"
        let aAge:Int? = 10
        guard let nick = aNick,let age = aAge else {
            print("nil")
            return
        }
        print("guard let:" + nick + String(age))
    }
}

struct JiegouTi{
    var width = 0
    var height = 0
}


class BaseClass_Setup: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var t = test()
        t.demo()
        
        //MARK:强制解包
        var dataList:[String]?
        dataList = ["zhangsan","lisi"]
        /*********************************************************************
         1.dataList? 表示 datalist 可能为 nil
         2.如果为 nil, .count 不会报错，仍然返回 nil
         2.如果不为 nil，.count执行，返回数组元素个数
         4. ?? 空合运算符(详见:02-运算符)
         *********************************************************************/
        let count = dataList?.count ?? 0
        //表示dataList一定有值，否则会出错
        let cou = dataList!.count
        
        let aa = test()
        let bb = JiegouTi()
        //属性访问(点语法)
        print("width:\(aa.width)")
        print("height:\(bb.height)")
        //访问子属性
        print("third:\(aa.third.width)")
        
        //使用点语法为变量属性赋值
        aa.third.width = 1280
        print("The width of someVideoMode is now \(aa.third.width)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
























