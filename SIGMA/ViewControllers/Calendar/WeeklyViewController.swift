//
//  WeeklyViewController.swift
//  SIGMA
//
//  Created by Matt on 12/5/2022.
//

import UIKit

var selectedDate = Date()

class WeeklyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var totalSquares = [Date]()
    let calendar = Calendar.current

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
        setWeekView()
    }
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2)
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setWeekView() {
        totalSquares.removeAll()
         
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = calendar.date(byAdding: .day, value: 7, to: current)!
        
        while (current < nextSunday) {
            totalSquares.append(current)
            current = calendar.date(byAdding: .day, value: 1, to: current)!
            
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCellCollectionViewCell
        
        let date = totalSquares[indexPath.item]
        
        cell.dayOfMonth.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if (date == selectedDate) {
            cell.backgroundColor = UIColor.systemGreen
        }
        else {
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    @IBAction func previousWeek(_ sender: Any) {
        selectedDate = calendar.date(byAdding: .day, value: -7, to: selectedDate)!
        setWeekView()
    }
    
    @IBAction func nextWeek(_ sender: Any) {
        selectedDate = calendar.date(byAdding: .day, value: 7, to: selectedDate)!
        setWeekView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Event().eventsForDate(date: selectedDate).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! EventCellTableViewCell
        let event = Event().eventsForDate(date: selectedDate)[indexPath.row]
        cell.eventLabel.text = event.title! + " " + CalendarHelper().timeString(date: event.date!)
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exerciseListVC = storyboard?.instantiateViewController(withIdentifier: "eventExercisesVC") as! ExerciseListCollectionViewController
        present(exerciseListVC, animated: true)

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
