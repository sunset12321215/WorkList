//
//  TaskCell.swift
//  WorkList
//
//  Created by CuongVX-D1 on 6/26/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit

final class TaskCell: UITableViewCell, Reusable {
    
    //  MARK: - Outlet
    @IBOutlet private weak var checkTaskImageView: UIImageView!
    @IBOutlet private weak var taskLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var statusView: UIView!
    
    //  MARK: - Variable
    var sectionTitle: String?
    var task: Task?
    var attributeString: NSMutableAttributedString?
    var ref: DatabaseReference?
    
    //  MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupActionCheckImage()
        setupRef()
    }
    
    private func setupRef() {
        ref = Database.database().reference();
    }
    
    func setContent(data: (sectionTitle: String, task: Task)) {
        sectionTitle = data.sectionTitle
        task = data.task
        checkTaskImageView.image = task?.isDone ?? true ? UIImage(named: "uncheck") : UIImage(named: "check")
        taskLabel.text = task?.todo == "" ? "Please Type Something" : task?.todo
        let timeInterval = task?.timeInterval ?? 0
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        let myCalendar = Calendar(identifier: .gregorian)
        let dateComponents = myCalendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date)
        let hour = dateComponents.hour ?? 0
        let minute = dateComponents.minute ?? 0
        let textHour = hour < 10 ? "0\(hour)" : "\(hour)"
        let textMinute = minute < 10 ? "0\(minute)" : "\(minute)"   
        timeLabel.text = textHour + ":" + textMinute
        let strikeValue = task?.isDone ?? true ? 2 : 0
        setupStrikeThroughStyleTaskLabel(value: strikeValue)
        statusView.backgroundColor = (task?.isDone ?? true) ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    }
    
    private func setupStrikeThroughStyleTaskLabel(value: Int) {
        let _ = taskLabel.setupStrikeLine(value: value)
        let _ = timeLabel.setupStrikeLine(value: value)
    }
    
    func setupActionCheckImage() {
        let tapImageAction = UITapGestureRecognizer(target: self,
                                                    action: #selector(actionImage))
        checkTaskImageView.isUserInteractionEnabled = true
        checkTaskImageView.addGestureRecognizer(tapImageAction)
    }
    
    @objc func actionImage() {
        checkTaskImageView.image = task?.isDone ?? true ? UIImage(named: "check") : UIImage(named: "uncheck")
        let strikeValue = task!.isDone ? 0 : 2
        setupStrikeThroughStyleTaskLabel(value: strikeValue)
        let isDone = task?.isDone ?? false
        task?.isDone = !isDone
        statusView.backgroundColor = (task?.isDone ?? true) ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)

        ref?.child("Task")
            .child(sectionTitle ?? "")
            .child(task?.id ?? "").updateChildValues(["isDone": task?.isDone ?? false])
    }
}
