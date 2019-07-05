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
    
    var sectionTitle: String!
    var task: Task!
    var attributeString: NSMutableAttributedString!
    var ref: DatabaseReference!
    
    //  MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupActionCheckImage()
        setupRef()
    }
    
    private func setupRef() {
        ref = Database.database().reference()
    }
    
    func setContent(data: (sectionTitle: String, task: Task)) {
        sectionTitle = data.sectionTitle
        task = data.task
        
        checkTaskImageView.image = task.isDone ? UIImage(named: "uncheck") : UIImage(named: "check")
        taskLabel.text = task.todo == "" ? "Please Type Something" : task.todo
        let timeInterval = task.timeInterval
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date)
        timeLabel.text = "\(dateComponents.hour ?? 0):\(dateComponents.minute ?? 0)"
        let strikeValue = !task.isDone ? 0 : 2
        setupStrikeThroughStyleTaskLabel(value: strikeValue)
    }
    
    private func setupStrikeThroughStyleTaskLabel(value: Int) {
        attributeString = NSMutableAttributedString(string: taskLabel.text ?? "")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: value,
                                     range: NSMakeRange(0, attributeString.length))
        taskLabel.attributedText = attributeString
    }
    
    func setupActionCheckImage() {
        let tapImageAction = UITapGestureRecognizer(target: self,
                                                    action: #selector(actionImage))
        checkTaskImageView.isUserInteractionEnabled = true
        checkTaskImageView.addGestureRecognizer(tapImageAction)
    }
    
    @objc func actionImage() {
        checkTaskImageView.image = !task.isDone ? UIImage(named: "uncheck") : UIImage(named: "check")
        let strikeValue = task!.isDone ? 0 : 2
        setupStrikeThroughStyleTaskLabel(value: strikeValue)
        task!.isDone = !task.isDone

        ref.child("Task")
            .child(sectionTitle)
            .child(task?.id ?? "").updateChildValues(["isDone": task?.isDone ?? false])
    }
}
