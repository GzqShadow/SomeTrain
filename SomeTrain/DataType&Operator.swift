//
//  DataType.swift
//  SomeTrain
//
//  Created by listome on 2017/7/11.
//  Copyright © 2017年 listome. All rights reserved.
//

import UIKit

class DataType: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:基本数据类型
        /*
         1.整数: int
         2.浮点数:Double（64位），float（32位）
         3.布尔类型:Bool, true false
         4.字符串:string
         5.字符:Character
         */
        
        var aq = 10
        aq = 20
        let b = 20
//        b = 1  wrong
        
        //自动推导类型
        let str = "dfak"
        let intValue = 10
        let floatValue = 1.5
        
        //指定数据类型
        let doubleVlaue:Double = 10
        
        print("打印:\(aq,b,str,intValue,floatValue,doubleVlaue)")
        
        //MARK:运算符
        //赋值运算符
        aq=b
        let (x,y) = (1,2) //赋值的右边如果是元组，它的元素可以被分为多个常量或变量
        //!swift的赋值操作不反悔任何值，不可以用于if判断
        
        //算数运算符 + - * /
        //也可用于String的拼接  "hello, " + "world", 等于 "hello, world"
        
        //求余运算符 %
        /*   8 % 2.5    等于 0.5     */
        
        //一元负号运算符  数值的正负号可以使用前缀
        let three = 3
        let fuSan = -three
        let fusan2 = -fuSan
        
        //一元正号运算符
        let zH = +fusan2  //zH 等于 -3
        
        //组合赋值运算符
        var df = 1
        df = df + 2 //df现在是3
        
        //比较运算符
        /*
         1 == 1   // true, 因为 1 等于 1
         2 != 1   // true, 因为 2 不等于 1
         2 > 1    // true, 因为 2 大于 1
         1 < 2    // true, 因为 1 小于2
         1 >= 1   // true, 因为 1 大于等于 1
         2 <= 1   // false, 因为 2 并不小于等于 1
         */
        
        let name = "world"
        if name == "world" {
            print("hello, world")
        }else{
            print("I'm sorry \(name), but I don't recognize you")
        }
        /*当元组中的值可以比较时，你也可以使用这些运算符来比较它们的大小。例如，因为 `Int` 和 `String` 类型的值可以比较，所以类型为 `(Int, String)` 的元组也可以被比较。相反，`Bool` 不能被比较，也意味着存有布尔类型的元组不能被比较。*/
        (1, "zebra") < (2, "apple")   // true，因为 1 小于 2
        (3, "apple") < (3, "bird")    // true，因为 3 等于 3，但是 apple 小于 bird
        (4, "dog") == (4, "dog")      // true，因为 4 等于 4，dog 等于 dog
        //!!Swift 标准库只能比较七个以内元素的元组比较函数。如果你的元组元素超过七个时，你需要自己实现比较运算符
        
        //三目运算符
        let contentHeight = 40
        let hasHeader = true
        let rowHeight = contentHeight + (hasHeader ? 50 : 20)
        // rowHeight 现在是 90
        
        //空合运算符 (Nil Coalescing Operator)
        /*********************************************************************
         1.空合运算符( a ?? b )将对可选类型 a 进行空判断(可选项内容详见:04-可选项)
         2.如果 aName 为 nil，则执行??后面的，否则执行aName（注意??两边都有空格）
         ********************************************************************/
        
        var aName: String? = "ningcol"
        //var aName: String? = nil
        let bName = aName ?? "aNameIsNil"
        let na = aName ?? "Sovereign"
        
        
        //9.区间运算
        /*********************************************************************
         1.闭区间运算符( a...b )定义一个包含从 a 到 b (包括 a 和 b )的所有值的区间
         2.半开区间( a..<b )定义一个从 a 到 b 但不包括 b 的区间
         ********************************************************************/
        for index in 1...aq {
            print(index)
        }
        for index in 1..<b {
            print("半开区间:\(index)")
        }
        
        //逻辑运算
        /*********************************************************************
         1.逻辑非(!a):布尔值取反
         2.逻辑与( a && b ):只有 a 和 b 的值都为 true 时，整个表达式的值才会是 true
         3.逻辑或( a || b ):两个逻辑表达式的其中一个为 tru e ，整个表达式就为 true
         ********************************************************************/
        let allowedEntry = false
        let enteredDoorCode = true
        
        if !allowedEntry {
            print("ACCESS DENIED")
        }
        
        if allowedEntry && enteredDoorCode {
            print("Welcome!")
        } else {
            print("ACCESS DENIED")
        }
        
        if allowedEntry || enteredDoorCode {
            print("Welcome!")
        } else {
            print("ACCESS DENIED")
        }

        //MARK:可选项
        /*********************************************************************
         1.可选值:可以有值,可以为nil(用 ? 表示可选值)
         ********************************************************************/
        //URL 为可选项
        let URL = NSURL(string:"http://www.baidu.com/")
        //括号里面的string要小写
        //str 为可选项
        var str1: String? = "Sovereign" //括号外面大写
        
        //var 的可选项默认为 nil
        var a:Int?
        print(a)
        
        
        /*************************** if let *************************/
        // if let : 确保 myUrl 有值，才会进入分支
        if  let myurl = URL {
            print(myurl)
        }
        
        var aname:String? = "sovereign" //可选项 "?" 和 "=" 之间要有空格
        var age: Int? = 18
        //可以对值进行修改
        if let name = aName,let ag = age {
            print(name + String(describing: age))
        }
        
        
        
        // 创建一个类(详见:10-对象和类)
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
