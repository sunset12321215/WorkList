//
//  ViewController.swift
//  WorkList
//
//  Created by CuongVX-D1 on 6/26/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit

final class TaskViewController: UIViewController {
<<<<<<< HEAD
    
    @IBOutlet private weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var newTaskVC: NewTaskViewController?
=======

    //  MARK: - Outlet
    @IBOutlet private weak var tableView: UITableView!
    
    //  MARK: - Constant & Variable
    private struct Constant {
        static let heightForRow: CGFloat = 86
        static let heightForHeaderInSection: CGFloat = 50
        static let widthScreen = UIScreen.main.bounds.width
        static let heightScreen = UIScreen.main.bounds.height
        static let iPhoneXHeightScreen = UIScreen.main.bounds.height
    }
    var ref: DatabaseReference?
>>>>>>> Complete Push Pull FireBase
    var dayTask = [DayTask]() {
        didSet {
            tableView.reloadData()
        }
    }
    
<<<<<<< HEAD
=======
    //  MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRef()
        title = "Task list"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dayTask.removeAll()
        getDataFromFirebase()
    }
    
>>>>>>> Complete Push Pull FireBase
    private func setupTableView() {
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(UINib(nibName: "TaskCell",
                              bundle: nil),
<<<<<<< HEAD
                        forCellReuseIdentifier: "TaskCell")
=======
                              forCellReuseIdentifier: "TaskCell")
>>>>>>> Complete Push Pull FireBase
        }
    }
    
    private func setupRef() {
        ref = Database.database().reference()
    }
    
<<<<<<< HEAD
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
=======
    func getDataFromFirebase() {
        ref?.child("Task").observe(.childAdded) { (data) in
>>>>>>> Complete Push Pull FireBase
            let result = data.value as? [String : Any] ?? [:]
            let sessionTitle = data.key
            var taskArray = [Task]()
            
            for item in result {
<<<<<<< HEAD
                let id = item.key
                let arrayValue = item.value as? [String : Any] ?? [:]
                let isDone = arrayValue["isDone"] as? Bool ?? false
                let todo = arrayValue["todo"] as? String ?? ""
                let description = arrayValue["description"] as? String ?? ""
                let timeInterval = arrayValue["timeInterval"] as? Double ?? 0
                let task = Task(id: id, isDone: isDone, todo: todo, description: description, timeInterval: timeInterval)
                self.setupNotification(task: task)
                
                taskArray.append(task)
=======
                let task = Task(item: item)
                taskArray.append(task)
                task.setupNotification()
>>>>>>> Complete Push Pull FireBase
            }
            self.dayTask.append(DayTask(sectionTitle: sessionTitle, task: taskArray))
        }
    }
    
<<<<<<< HEAD
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
=======
    //  MARK: - Action
    @IBAction func addAction(_ sender: Any) {
        guard let newTaskVC = storyboard?.instantiateViewController(withIdentifier: "NewTaskVC") as? NewTaskViewController else { return }
>>>>>>> Complete Push Pull FireBase
        newTaskVC.isUpdate = false
        navigationController?.pushViewController(newTaskVC, animated: true)
    }
}

extension TaskViewController: UITableViewDataSource, UITableViewDelegate {
<<<<<<< HEAD
=======
    
>>>>>>> Complete Push Pull FireBase
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
<<<<<<< HEAD
        guard let newTaskVC = storyboard?.instantiateViewController(withIdentifier: "NewTaskVC") as? NewTaskViewController else {
            return
        }
=======
        guard let newTaskVC = storyboard?.instantiateViewController(withIdentifier: "NewTaskVC") as? NewTaskViewController else { return }
>>>>>>> Complete Push Pull FireBase
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
<<<<<<< HEAD
        fixAction.backgroundColor = .blue
        
=======
        fixAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)

>>>>>>> Complete Push Pull FireBase
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, nil) in
            var dayTaskItem = self.dayTask[indexPath.section]
            let sectionID = dayTaskItem.sectionTitle
            let idValue = dayTaskItem.task[indexPath.row].id
<<<<<<< HEAD
            self.ref.child("Task")
                .child(sectionID)
                .child(idValue).removeValue()
            
=======
            self.ref?.child("Task")
                .child(sectionID)
                .child(idValue).removeValue()
>>>>>>> Complete Push Pull FireBase
            self.dayTask[indexPath.section].task.remove(at: indexPath.row)
        }
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction, fixAction])
    }
<<<<<<< HEAD
}

//  Đoạn code này giúp hiện notif trong khi app chạy
extension  TaskViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .alert, .badge])
=======

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.heightForRow * Constant.iPhoneXHeightScreen / Constant.heightScreen
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.heightForHeaderInSection
>>>>>>> Complete Push Pull FireBase
    }
}
