//
//  JGGMonthlySelectPickerVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/14/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import MZFormSheetPresentationController

class JGGMonthlySelectPickerVC: JGGPopupBaseVC, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var clsviewDays: UICollectionView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnDone: UIButton!

    var selectedDatesHandler: (([Int]) -> Void)?
    var selectedDates: [Int] = []
    
    fileprivate lazy var days: [(Int, Bool)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for day in 1...31 {
            var selected = false
            for selectedDay in selectedDates {
                if day == selectedDay {
                    selected = true
                    break
                }
            }
            days.append((day, selected))
        }
        clsviewDays.dataSource = self
        clsviewDays.delegate = self
        
    }
    
    override func contentViewFrame(for presentationController: MZFormSheetPresentationController!, currentFrame: CGRect) -> CGRect {
        var frame = UIScreen.main.bounds.insetBy(dx: 10, dy: 50)
        frame.size.height = 450
        return frame
    }
    
    @IBAction func onPressedCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPressedDone(_ sender: UIButton) {
        if let selectedDatesHandler = selectedDatesHandler {
            var selectedDates: [Int] = []
            for (day, selected) in days {
                if selected {
                    selectedDates.append(day)
                }
            }
            selectedDatesHandler(selectedDates)
        }
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - UICollectionView datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JGGMonthlyDateCell", for: indexPath) as! JGGMonthlyDateCell
        cell.lblDate.text = String(days[indexPath.row].0)
        selectCell(cell, isSelected: days[indexPath.row].1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        days[indexPath.row].1 = !(days[indexPath.row].1)
        if let cell = collectionView.cellForItem(at: indexPath) as? JGGMonthlyDateCell {
            selectCell(cell, isSelected: days[indexPath.row].1)
        }
    }
    
    private func selectCell(_ cell: JGGMonthlyDateCell, isSelected: Bool) {
        if isSelected {
            cell.lblDate.backgroundColor = UIColor.JGGCyan
            cell.lblDate.textColor = UIColor.JGGWhite
        } else {
            cell.lblDate.backgroundColor = UIColor.JGGWhite
            cell.lblDate.textColor = UIColor.JGGCyan
        }
    }
}

class JGGMonthlyDateCell: UICollectionViewCell {
    
    @IBOutlet weak var lblDate: UILabel!
    
    
}
