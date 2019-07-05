//
//  NewTaskViewController.swift
//  WorkList
//
//  Created by CuongVX-D1 on 6/27/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit

final class NewTaskViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var newTaskTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var updateButton: UIButton!
    @IBOutlet private weak var addTaskButton: UIButton!
    
    var sectionTitle: String!
    var task: Task?
    var ref: DatabaseReference!
    var isUpdate: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRef()
        let _ = isUpdate ? prepareForUpdate() : prepareForNewTask()
    }
    
    private func setupRef() {
        ref = Database.database().reference()
    }
    
    private func prepareForUpdate() {
        newTaskTextField.text = task?.todo
        titleLabel.text = "Update this Task"
        descriptionTextView.text = task?.description
        addTaskButton.isEnabled = false
        
        let date = Date(timeIntervalSince1970: TimeInterval(task?.timeInterval ?? 0))
        datePicker.setDate(date, animated: true)
    }
    
    private func prepareForNewTask() {
        updateButton.isEnabled = false
    }
    
    @IBAction func updateAction(_ sender: Any) {
        task?.todo = newTaskTextField.text ?? ""
        let date = datePicker?.date
        guard let timeInterval = date?.timeIntervalSince1970 else { return }
        let key = task?.id ?? ""
        let isDone = task?.isDone ?? false
        let todo = task?.todo ?? ""
        let description = task?.description ?? ""
        ref.child("Task")
            .child(sectionTitle)
            .child(key).updateChildValues(["isDone": isDone,
                                           "todo": todo,
                                           "description": description,
                                           "timeInterval": timeInterval])
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addTaskAction(_ isUpdate: Any) {
        task?.todo = newTaskTextField.text ?? ""
        let date = datePicker?.date ?? Date()
        let timeInterval = date.timeIntervalSince1970
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date)
        let keyOfDate = "Ngày \(dateComponents.day ?? 0) Tháng \(dateComponents.month ?? 0) Năm \(dateComponents.year ?? 0)"
        let keyOfValue = ref.childByAutoId().key ?? ""
        let values = [
            "isDone": false,
            "todo": newTaskTextField.text ?? "",
            "description": descriptionTextView.text ?? "",
            "timeInterval": timeInterval
            ] as [String : Any]
        
        ref.child("Task")
            .child(keyOfDate)
            .child(keyOfValue).setValue(values)
        navigationController?.popViewController(animated: true)
    }
}
