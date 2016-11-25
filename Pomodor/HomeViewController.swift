//
//  HomeViewController.swift
//  Pomodor
//
//  Created by Pablo on 11/23/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit
import UITableView_NXEmptyView

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let workingTaskTitle = "Working Task"
    fileprivate let noTasksTitle     = "No Tasks"
    
    @IBOutlet fileprivate weak var headerView:   HeaderView!
    @IBOutlet fileprivate weak var controlsView: ControlsView!
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    fileprivate var index: Int = 0
    
    fileprivate var tasks: Array<Task> {
        
        return Task.mr_findAll() as! Array<Task>
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = workingTaskTitle
        
        self.tableView.nxEV_emptyView = emptyView()
        
        if self.tasks.count <= 0 {
            
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        }
        
        setupControlsViewBlocks()
        checkIfActiveTask()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Action Methods
    
    @IBAction func actionAddTask(_ sender: UIBarButtonItem) {
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        let alert = UIAlertController(title: "New Task",
                                      message: "",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Add",
                                       style: .default,
                                       handler: { action -> Void in
                                        
                                        self.title = self.workingTaskTitle
                                        
                                        let textField = alert.textFields![0] as UITextField
                                        
                                        let task = Task.task(textField.text!)
                                        
                                        self.navigationItem.leftBarButtonItem?.isEnabled = true
                                        
                                        if Session.currentSession().activeTask != .none { return }
                                        
                                        self.index = self.tasks.index(of: task!)!
                                        
                                        self.headerView.taskPaused(remainingTime: (task?.remainingTime)!)
                                        self.controlsView.taskPaused()
                                        
                                        self.tableView.reloadData()
        })
        
        saveAction.isEnabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler:.none)
        
        alert.addTextField { (textField : UITextField!) -> Void in
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"),
                                                   object: textField,
                                                   queue: OperationQueue.main,
                                                   using: { notification in
                                                    
                                                    saveAction.isEnabled = !(textField.text?.isEmpty)!
            })
            
            textField.keyboardType           = .default
            textField.spellCheckingType      = .default
            textField.autocapitalizationType = .sentences
            textField.placeholder            = "Task description"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert,
                     animated: true,
                     completion: {
                        
                        self.navigationItem.rightBarButtonItem?.isEnabled = true
        })
    }
    
    @IBAction func actionRemoveAll(_ sender: UIBarButtonItem) {
        
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        
        let message = "All your tasks will be discarded."
        
        let callAction = { (action: UIAlertAction) -> Void in
            
            self.title = self.noTasksTitle
            
            Task.mr_truncateAll()
            
            DatabaseController.persist()
            
            self.tableView.reloadData()
            
            self.headerView.noTasks()
            self.controlsView.noTasks()
        }
        
        let keepAction = { (action: UIAlertAction) -> Void in
            
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        }
        
        let alert = UIAlertController.showAlert("Discard Tasks?",
                                                message: message,
                                                callTitle: "Discard",
                                                callHandler: callAction,
                                                cancelTitle: "Keep",
                                                cancelHandler: keepAction)
        
        present(alert,
                animated: true,
                completion: .none)
    }
    
    // MARK: - Private Methods
    
    fileprivate func setupControlsViewBlocks() {
        
        self.controlsView.didTouchReset = {
            
            let currentTask = self.tasks[self.index]
            
            currentTask.reset()
            
            self.controlsView.taskPaused()
            self.headerView.taskPaused(remainingTime: currentTask.remainingTime)
            
            if currentTask.isEqual(Session.currentSession().activeTask) {
                
                Session.currentSession().activeTask = .none
            }
            
            DatabaseController.persist()
        }
        
        self.controlsView.didTouchStop  = {
            
            self.controlsView.taskPaused()
            self.headerView.taskPaused(remainingTime: (Session.currentSession().activeTask?.remainingTime)!)
            
            Session.currentSession().activeTask = .none
            
            // Stop Timer...
            
            DatabaseController.persist()
        }
        
        self.controlsView.didTouchStart = {
            
            let currentTask = self.tasks[self.index]
            
            self.controlsView.taskRunning()
            self.headerView.taskRunning(remainingTime: currentTask.remainingTime)
            
            // Start Timer...
            
            Session.currentSession().activeTask = currentTask
                
            DatabaseController.persist()
        }
    }
    
    fileprivate func checkIfActiveTask() {
        
        if let activeTask = Session.currentSession().activeTask {
            
            self.headerView.taskRunning(remainingTime: activeTask.remainingTime)
            self.controlsView.taskRunning()
            
            return
        }
        
        if self.tasks.count == 0 {
            
            self.headerView.noTasks()
            self.controlsView.noTasks()
            
            self.title = noTasksTitle
            
        } else {
            
            let firstTask = Task.mr_findFirst()
            
            if (firstTask?.completed)! {
                
                self.headerView.taskCompleted()
                self.controlsView.taskCompleted()
                
                return
            }
            
            self.headerView.taskPaused(remainingTime: (firstTask?.remainingTime)!)
            self.controlsView.taskPaused()
        }
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let task = self.tasks[indexPath.row]
        
        (cell as! TaskCell).task = task
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.index = indexPath.row
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier(), for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tasks.count
    }
    
}

extension HomeViewController {
    
    fileprivate func emptyView() -> UIView? {
        
        return UINib(nibName: "TableEmptyView",
                     bundle: nil).instantiate(withOwner: nil, options: nil).first as? UIView
    }
}
