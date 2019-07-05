//
//  ViewController.swift
//  WorkList
//
//  Created by CuongVX-D1 on 6/26/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit

final class TaskViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var newTaskVC: NewTaskViewController?
    var dayTask = [DayTask]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(UINib(nibName: "TaskCell",
                              bundle: nil),
                        forCellReuseIdentifier: "TaskCell")
        }
    }
    
    private func setupRef() {
        ref = Database.database().reference()
    }
    
    fileprivate func setupNotification() {
        UNUserNotificationCenter.current().delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRef()
        getDataFromFirebase()
        setupNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func getDataFromFirebase() {   
        ref.child("Task").observe(.childAdded) { (data) in
            let result = data.value as? [String : Any] ?? [:]
            let sessionTitle = data.key
            var taskArray = [Task]()
            
            for item in result {
                let id = item.key
                let arrayValue = item.value as? [String : Any] ?? [:]
                let isDone = arrayValue["isDone"] as? Bool ?? false
                let todo = arrayValue["todo"] as? String ?? ""
                let description = arrayValue["description"] as? String ?? ""
                let timeInterval = arrayValue["timeInterval"] as? Double ?? 0
                let task = Task(id: id, isDone: isDone, todo: todo, description: description, timeInterval: timeInterval)
                self.setupNotification(task: task)
                
                taskArray.append(task)
            }
            self.dayTask.append(DayTask(sectionTitle: sessionTitle, task: taskArray))
        }
    }
    
    private func setupNotification(task: Task) {
        let date = Date(timeIntervalSince1970: TimeInterval(task.timeInterval))
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                             from: date)
        let triggerTime = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = task.todo
        content.body  = task.description
        content.sound = UNNotificationSound.default
        let requets = UNNotificationRequest(identifier: task.id, content: content, trigger: triggerTime)
        UNUserNotificationCenter.current().add(requets, withCompletionHandler: nil)
    }
    
    @IBAction func addAction(_ sender: Any) {
        guard let newTaskVC = storyboard?.instantiateViewController(withIdentifier: "NewTaskVC") as? NewTaskViewController else {
            return
        }
        newTaskVC.isUpdate = false
        navigationController?.pushViewController(newTaskVC, animated: true)
    }
}

extension TaskViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dayTask.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dayTask[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayTask[section].task.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContent(data: (sectionTitle: dayTask[indexPath.section].sectionTitle,
                               task: dayTask[indexPath.section].task[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newTaskVC = storyboard?.instantiateViewController(withIdentifier: "NewTaskVC") as? NewTaskViewController else {
            return
        }
        newTaskVC.isUpdate = true
        newTaskVC.task = dayTask[indexPath.section].task[indexPath.row]
        newTaskVC.sectionTitle = dayTask[indexPath.section].sectionTitle
        navigationController?.pushViewController(newTaskVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let fixAction = UIContextualAction(style: .normal, title: nil) { (action, view, nil) in
        }
        fixAction.image = UIImage(named: "fix")
        fixAction.backgroundColor = .blue
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, nil) in
            var dayTaskItem = self.dayTask[indexPath.section]
            let sectionID = dayTaskItem.sectionTitle
            let idValue = dayTaskItem.task[indexPath.row].id
            self.ref.child("Task")
                .child(sectionID)
                .child(idValue).removeValue()
            
            self.dayTask[indexPath.section].task.remove(at: indexPath.row)
        }
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction, fixAction])
    }
}

//  Đoạn code này giúp hiện notif trong khi app chạy
extension  TaskViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .alert, .badge])
    }
}
