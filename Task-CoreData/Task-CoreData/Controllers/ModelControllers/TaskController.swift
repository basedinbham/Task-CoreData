//
//  TaskController.swift
//  Task-CoreData
//
//  Created by Kyle Warren on 7/27/21.
//

import CoreData

class TaskController {
    
    //Shared instance
    static let shared = TaskController()
    //SOT
    var tasks: [Task] = []
     
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        
        let request = NSFetchRequest<Task>(entityName: "Task")
        
        request.predicate = NSPredicate(value: true)
        
        return request
    }()
    
    //MARK: - CRUD
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        tasks.append(newTask)
        
        CoreDataStack.saveContext()
    }
    
    func fetchTasks() {
        let tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        self.tasks = tasks
        
        CoreDataStack.saveContext()
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        
        CoreDataStack.saveContext()
    }
    
    func deleteTask(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        
        //Removes from persistence
        CoreDataStack.context.delete(task)
        CoreDataStack.saveContext()
    }
    
} // End of Class
