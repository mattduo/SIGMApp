//
//  CalendarViewController.swift
//  SIGMA
//
//  Created by Matt on 4/5/2022.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate {
    
    var calendar: FSCalendar!
    var formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calendar = FSCalendar(frame: CGRect(x: 5.0, y: 60.0, width: self.view.frame.size.width, height: self.view.frame.size.height - 150))
        calendar.scrollDirection = .horizontal
        self.view.addSubview(calendar)
        
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17.0)
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18.0)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 16.0)
        
        calendar.delegate = self
    }
    
    //MARK: - Delegate
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MM-yyyy"
        print("Date Selected == \(formatter.string(from: date))")
        print(self.view.frame.size.height)
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
