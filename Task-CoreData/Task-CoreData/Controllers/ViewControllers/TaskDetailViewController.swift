//
//  TaskDetailViewController.swift
//  Task-CoreData
//
//  Created by Kyle Warren on 7/27/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
 
    //MARK: - OUTLETS
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    
    //MARK: - PROPERTIES
    var task: Task?
    var date: Date?
    
    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - HELPER FUNCTIONS
    func updateViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        // Optional, so needs default
        taskDueDatePicker.date = task.dueDate ?? Date()
    }
    

    
    //MARK: - ACTIONS
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text, !name.isEmpty  else { return }
        
        let notes = taskNotesTextView.text
        let dueDate = taskDueDatePicker.date
        
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, dueDate: dueDate)
        } else {
            TaskController.shared.createTaskWith(name: name, notes: notes, dueDate: dueDate)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        guard let picker = sender as? UIDatePicker else { return }
    }
    
    
    
    //MARK: - HELPER FUNCTIONS




}
