//
//  TaskListTableViewController.swift
//  Task-CoreData
//
//  Created by Kyle Warren on 7/27/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            TaskController.shared.fetchTasks()
            tableView.reloadData()
    }

    // MARK: - Table view data source

   // override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
       // return 0
   // }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  TaskController.shared.tasks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        

        cell.task = TaskController.shared.tasks[indexPath.row]

        cell.delegate = self

        return cell
    }

/*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
*/



   
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
        
        guard let indexPath = tableView.indexPathForSelectedRow,
        let destination = segue.destination as? TaskDetailViewController else { return }
        
        let task = TaskController.shared.tasks[indexPath.row]
        destination.task = task
        }
    }
} // End of Class

extension TaskListTableViewController: TaskCompletionDelegate {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let task = sender.task else { return }
        TaskController.shared.toggleIsComplete(task: task)
        //tableView.reloadData()
        sender.updateViews()
    }
}
