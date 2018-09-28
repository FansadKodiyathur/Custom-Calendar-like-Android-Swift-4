//
//  ViewController.swift
//  customeCalendar
//
//  Created by Beegains-PC on 9/28/18.
//  Copyright © 2018 Beegains-PC. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var lbl_month_out: UILabel!
    @IBOutlet weak var lbl_year_out: UILabel!
    var daysArray : [String] = [String]()
    let dayOne = 1
    @IBOutlet weak var btn_previous_out: UIButton!
    @IBOutlet weak var btn_next_out: UIButton!
    @IBOutlet weak var col_calendar_out: UICollectionView!
    var selected = false
    var selectionIndex : Int = Int()
    
    var livedate : Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        

       livedate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: date)
        SetCalendar(dateForcalendar: result, monthName:nameOfMonth)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return daysArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell_id", for: indexPath) as! CalendarCell
        
        
        
        if selected
        {
            
            if indexPath.row == selectionIndex && daysArray[indexPath.row] != " " {
                
                cell.layer.borderWidth = 2
                cell.layer.borderColor = UIColor.lightGray.cgColor
                
            } else {
                cell.layer.borderWidth = 0
                cell.layer.borderColor = UIColor.clear.cgColor
            }
        } else {
            cell.layer.borderWidth = 0
            cell.layer.borderColor = UIColor.clear.cgColor
        }
        
        
        print(livedate)
        
        let today = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let livedateNow = formatter.string(from: livedate)
        let livedatetoday = formatter.string(from: today)
        
        


        
        if livedateNow == livedatetoday {
            
            
            print(livedateNow)
            print(livedatetoday)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let result = formatter.string(from: today)
            
            let todayArray = result.components(separatedBy: ".")
            
            let currentday = todayArray[0]
            if daysArray[indexPath.row] == currentday {
                
                
                cell.layer.borderWidth = 2
                cell.layer.borderColor = UIColor.white.cgColor
                
            }
            
            
        } else {
            if selected == false {
                cell.layer.borderWidth = 0
                cell.layer.borderColor = UIColor.clear.cgColor
            }
      
        }
        
        
        
        
        cell.lbl_calendar_day_out.text = daysArray[indexPath.row]
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        selectionIndex = indexPath.row
        
        selected = true
        
        col_calendar_out.reloadData()
        

  
    }
    

    @IBAction func btn_next_act(_ sender: UIButton) {
        
//        let today = Date()
        selected = false
        let nextmonth = Calendar.current.date(byAdding: .month, value: 1, to: livedate)!
        
        livedate = nextmonth
        print(nextmonth)

        print(livedate)
        
        
                  // "Oct 29, 2017 at 12:54 PM"
        
//         print(today)
//       let tomorrow = Date().tomorrow    // "Oct 30, 2017 at 12:00 PM"
//         print(tomorrow)
//       let someMonth = Date().yesterday.month   // 10
//          print(someMonth)
//      let somedate = Date().isLastDayOfMonth  // false
//        print(somedate)
        
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "dd.MM.yyyy"
        
        let nextMonthString = formatter.string(from: nextmonth) // string purpose I add here
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: nextmonth)
        SetCalendar(dateForcalendar: nextMonthString, monthName:nameOfMonth)
        

        
        
        
    }
    
    @IBAction func btb_previous_act(_ sender: UIButton) {
        
         selected = false
//        let today = Date()
        
        let previousmonth = Calendar.current.date(byAdding: .month, value: -1, to: livedate)!
        
        livedate = previousmonth
        print(previousmonth)
        
//             print(today)
//
//        let yesterday = Date().yesterday   // "Oct 28, 2017 at 12:00 PM"
//
//        print(yesterday)
        
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "dd.MM.yyyy"
        
        let previousString = formatter.string(from: previousmonth) // string purpose I add here
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: previousmonth)
        SetCalendar(dateForcalendar: previousString, monthName:nameOfMonth)
        
        
    }
    
    
    func SetCalendar(dateForcalendar:String,monthName:String)
    {
       
        
        
        let weekday = Calendar.current.component(.weekday, from: livedate)
        
        
        print(weekday)
        
        
        
        print(dateForcalendar)
        
    daysArray.removeAll()
        
        if weekday != 7 {
            
            for i in 0..<weekday {
                
                daysArray.append(" ")
                
            }
        }
        
   
        
        
    
        let splitDateArray = dateForcalendar.components(separatedBy: ".")
   
        lbl_year_out.text = splitDateArray[2]
        lbl_month_out.text = monthName
        
        
        
        
        
        let intyear = Int(splitDateArray[2])!
        let intmonth = Int(splitDateArray[1])!
     
     
        let dateComponents = DateComponents(year: intyear, month: intmonth)
        let calendar = Calendar.current
        let dateSecond = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: dateSecond)!
        let numDays = range.count
        
        
        print(numDays)
        
        for i in 0..<numDays {
            
            daysArray.append(String(i + 1))
            
            
        }
        
        col_calendar_out.reloadData()
        
        
    }

}

extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    func getNextMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    
    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
}
// Conform UICollectionViewDelegateFlowLayout first
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: self.col_calendar_out.bounds.width, height: self.col_calendar_out.bounds.height)
//    }
//
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}
