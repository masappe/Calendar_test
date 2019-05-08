//
//  ViewController.swift
//  Calender_test
//
//  Created by Masato Hayakawa on 2019/05/06.
//  Copyright © 2019 masappe. All rights reserved.
//

import UIKit

extension UIColor {
    class func lightBlue() -> UIColor {
        return UIColor(red: 92/255, green: 192/255, blue: 210/255, alpha: 1)
    }
    
    class func lightRed() -> UIColor {
        return UIColor(red: 195/255, green: 123/255, blue: 175/255, alpha: 1)
    }
}
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    let dateManager = DateManager()
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 2.0
    var selectedDate = Date()
    var today: Date!
    let weekArray = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    
    @IBOutlet weak var headerPrevButton: UIButton!
    @IBOutlet weak var headerNextButton: UIButton!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var calenderHeaderView: UIView!
    @IBOutlet weak var calenderCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self
        calenderCollectionView.backgroundColor = .white
    }
    //セルをタップした時のアクション
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //タップした日付の取得
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/M/d"
        let selectMonth = formatter.string(from: dateManager.currentMonthOfDates[indexPath.row])
        print(selectMonth)
    }
    //前の月へ
    @IBAction func tappedHeaderPrevBtuuon(_ sender: Any) {
        selectedDate = dateManager.prevMonth(date: selectedDate)!
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle(date: selectedDate)
    }
    //次の月へ
    @IBAction func tappedHeaderNextButton(_ sender: Any) {
        selectedDate = dateManager.nextMonth(date: selectedDate)!
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle(date: selectedDate as Date)
    }
    //section数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    //sectionごとのセルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 7
        } else {
            return dateManager.daysAcquisition()
        }
    }
    //cellの情報を記載
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarCell
        //textColor
        if indexPath.row % 7 == 0 {
            cell.textLabel.textColor = .lightRed()
        }else if indexPath.row % 7 == 6 {
            cell.textLabel.textColor = .lightBlue()
        }else {
            cell.textLabel.textColor = .lightGray
        }
        //テキストの配置
        if indexPath.section == 0 {
            cell.textLabel.text = weekArray[indexPath.row]
        } else {
            cell.textLabel.text = dateManager.conversionDateFormat(indexPath: indexPath)
        }
        return cell
    }
    
    //セルの配置
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(daysPerWeek)
        let height: CGFloat = width * 1.0
        return CGSize(width: width, height: height)
    }
    
    //セルの垂直方向のマージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    //セルの水平方向のマージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    //ヘッダーの命名規則
    func changeHeaderTitle(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/M"
        let selectMonth = formatter.string(from: date)
        return selectMonth
    }

}

