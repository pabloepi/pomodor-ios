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
        
        return Task.mr_findAllSorted(by: "createdAt", ascending: true) as! Array<Task>
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = workingTaskTitle
        
        self.tableView.nxEV_emptyView = emptyView()
        
        if self.tasks.count <= 0 {
            
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        }
        
        setupControlsViewBlocks()
        setupCountdownTimerControllerBlocks()
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
                                        
                                        self.tableView.reloadData()
                                        
                                        if Session.currentSession().activeTask != .none { return }
                                        
                                        self.index = 0
                                        
                                        self.headerView.taskPaused(remainingTime: (task?.remainingTime)!)
                                        self.controlsView.taskPaused()
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
            
            CountdownTimerController.sharedInstance.stopCountdown()
            
            Task.mr_truncateAll()
            
            Session.currentSession().activeTask = .none
            
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
    
    fileprivate func setupCountdownTimerControllerBlocks() {
        
        CountdownTimerController.sharedInstance.didUpdateCountdown = { remainingTime in
            
            Session.currentSession().activeTask?.remainingTime = remainingTime
            
            let currentTask = self.tasks[self.index]
            
            if currentTask.isEqual(Session.currentSession().activeTask) {
                
                self.headerView.taskRunning(remainingTime: remainingTime)
            }
        }
        
        CountdownTimerController.sharedInstance.didCompleteCountdown = {
            
            Session.currentSession().activeTask?.markAsCompleted()
            
            let currentTask = self.tasks[self.index]
            
            if currentTask.isEqual(Session.currentSession().activeTask) {
                
                self.controlsView.taskCompleted()
                self.headerView.taskCompleted()
            }
            
            Session.currentSession().activeTask = .none
            
            DatabaseController.persist()
            
            DeviceHelper.vibratingDevice()
        }
    }
    
    fileprivate func setupControlsViewBlocks() {
        
        self.controlsView.didTouchReset = {
            
            let currentTask = self.tasks[self.index]
            
            currentTask.reset()
            
            self.controlsView.taskPaused()
            self.headerView.taskPaused(remainingTime: currentTask.remainingTime)
            
            if Session.currentSession().activeTask != .none &&
                currentTask.isEqual(Session.currentSession().activeTask) {
                
                CountdownTimerController.sharedInstance.stopCountdown()
                
                Session.currentSession().activeTask = .none
            }
            
            DatabaseController.persist()
            
            self.refreshVisibleCells()
        }
        
        self.controlsView.didTouchStop  = {
            
            CountdownTimerController.sharedInstance.stopCountdown()
            
            self.controlsView.taskPaused()
            self.headerView.taskPaused(remainingTime: (Session.currentSession().activeTask?.remainingTime)!)
            
            Session.currentSession().activeTask = .none
            
            DatabaseController.persist()
            
            self.refreshVisibleCells()
        }
        
        self.controlsView.didTouchStart = {
            
            let currentTask = self.tasks[self.index]
            
            self.controlsView.taskRunning()
            self.headerView.taskRunning(remainingTime: currentTask.remainingTime)
            
            Session.currentSession().activeTask = currentTask
            
            CountdownTimerController.sharedInstance.startCountdown(Session.currentSession().activeTask?.remainingTime)
            
            DatabaseController.persist()
            
            self.refreshVisibleCells()
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
    
    fileprivate func refreshVisibleCells() {
        
        for cell in tableView.visibleCells {
            
            let cellIndexPath = tableView.indexPath(for: cell)
            let task          = self.tasks[(cellIndexPath?.row)!]
            
            if (Session.currentSession().activeTask != .none &&
                (Session.currentSession().activeTask?.isEqual(task))!) {
                
                if (cellIndexPath?.row == self.index) {
                    
                    (cell as! TaskCell).activeTask()
                    
                } else {
                    
                    (cell as! TaskCell).activeTaskNotCurrent()
                }
            } else if cellIndexPath?.row == self.index {
                
                (cell as! TaskCell).currentTask(isCurrent: true)
                
            } else {
                
                (cell as! TaskCell).currentTask(isCurrent: false)
            }
        }
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let task     = self.tasks[indexPath.row]
        let taskCell = cell as! TaskCell
        
        taskCell.task = task
        
        if (Session.currentSession().activeTask != .none &&
            (Session.currentSession().activeTask?.isEqual(task))!) {
            
            taskCell.activeTask()
            
        } else if self.index == indexPath.row {
            
            taskCell.currentTask(isCurrent: true)
            
        } else {
            
            taskCell.currentTask(isCurrent: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.index = indexPath.row
        
        refreshVisibleCells()
        
        let task = self.tasks[self.index]
        
        if task.completed {
            
            self.headerView.taskCompleted()
            self.controlsView.taskCompleted()
            
            return
        }
        
        if (Session.currentSession().activeTask != .none &&
            (Session.currentSession().activeTask?.isEqual(task))!) {
            
            self.headerView.taskRunning(remainingTime: task.remainingTime)
            self.controlsView.taskRunning()
            
        } else {
            
            self.headerView.taskPaused(remainingTime: task.remainingTime)
            self.controlsView.taskPaused()
        }
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
