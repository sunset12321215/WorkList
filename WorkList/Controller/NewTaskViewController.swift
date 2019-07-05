//
//  NewTaskViewController.swift
//  WorkList
//
//  Created by CuongVX-D1 on 6/27/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit

final class NewTaskViewController: UIViewController {
    
<<<<<<< HEAD
=======
    //  MARK: - Outlet
>>>>>>> Complete Push Pull FireBase
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var newTaskTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var updateButton: UIButton!
    @IBOutlet private weak var addTaskButton: UIButton!
    
<<<<<<< HEAD
    var sectionTitle: String!
    var task: Task?
    var ref: DatabaseReference!
    var isUpdate: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRef()
        let _ = isUpdate ? prepareForUpdate() : prepareForNewTask()
    }
    
=======
    //  MARK: - Variable
    var sectionTitle: String?
    var task: Task?
    var ref: DatabaseReference?
    var isUpdate: Bool?
    
    //  MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRef()
        let _ = isUpdate ?? true ? prepareForUpdate() : prepareForNewTask()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //  MARK: - Setup View
>>>>>>> Complete Push Pull FireBase
    private func setupRef() {
        ref = Database.database().reference()
    }
    
    private func prepareForUpdate() {
        newTaskTextField.text = task?.todo
        titleLabel.text = "Update this Task"
        descriptionTextView.text = task?.description
        addTaskButton.isEnabled = false
<<<<<<< HEAD
        
=======
>>>>>>> Complete Push Pull FireBase
        let date = Date(timeIntervalSince1970: TimeInterval(task?.timeInterval ?? 0))
        datePicker.setDate(date, animated: true)
    }
    
    private func prepareForNewTask() {
        updateButton.isEnabled = false
    }
    
<<<<<<< HEAD
=======
    //  MARK: - Action
>>>>>>> Complete Push Pull FireBase
    @IBAction func updateAction(_ sender: Any) {
        task?.todo = newTaskTextField.text ?? ""
        let date = datePicker?.date
        guard let timeInterval = date?.timeIntervalSince1970 else { return }
        let key = task?.id ?? ""
        let isDone = task?.isDone ?? false
        let todo = task?.todo ?? ""
        let description = task?.description ?? ""
<<<<<<< HEAD
        ref.child("Task")
            .child(sectionTitle)
=======
        ref?.child("Task")
            .child(sectionTitle ?? "")
>>>>>>> Complete Push Pull FireBase
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
<<<<<<< HEAD
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date)
        let keyOfDate = "Ngày \(dateComponents.day ?? 0) Tháng \(dateComponents.month ?? 0) Năm \(dateComponents.year ?? 0)"
        let keyOfValue = ref.childByAutoId().key ?? ""
=======
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second],
                                                             from: date)
        let keyOfDate = "Ngày \(dateComponents.day ?? 0) Tháng \(dateComponents.month ?? 0) Năm \(dateComponents.year ?? 0)"
        let keyOfValue = ref?.childByAutoId().key ?? ""
>>>>>>> Complete Push Pull FireBase
        let values = [
            "isDone": false,
            "todo": newTaskTextField.text ?? "",
            "description": descriptionTextView.text ?? "",
            "timeInterval": timeInterval
            ] as [String : Any]
        
<<<<<<< HEAD
        ref.child("Task")
=======
        ref?.child("Task")
>>>>>>> Complete Push Pull FireBase
            .child(keyOfDate)
            .child(keyOfValue).setValue(values)
        navigationController?.popViewController(animated: true)
    }
}
