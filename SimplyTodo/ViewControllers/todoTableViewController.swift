//
//  todoTableViewController.swift
//  SimplyTodo
//
//  Created by Casey Egan on 3/13/21.
//

import UIKit

class TodoTableViewController: UITableViewController {
    
    var todoList: [Todo] = [Todo]()
    var editTodoViewController: EditToDoViewController!
    var addTodoViewController: AddNewToDoViewController!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        installViewProperties()
        installRefreshControll()
        installNavigationItems()
        retrieveTodos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        todoList = ApplicationTodos.shared.todos
        tableView.reloadData()
    }
    
    private func installRefreshControll() {
        let refreshControl = UIRefreshControl()
        self.refreshControl = refreshControl
        refreshControl.addTarget(self, action:  #selector(retrieveTodos), for: .valueChanged)
        
    }
    
    private func installViewProperties() {
        self.title = "Simply ToDo"
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoTableCellIdentifier")
    }
    
    
    private func installNavigationItems() {
        
        let addNewTodo = UIBarButtonItem(image: UIImage(named: "addTask")?.withRenderingMode(.alwaysOriginal),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(self.addTodoWasTapped))
        
        
        let filter = UIBarButtonItem(image: UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(self.filterTodosoWasTapped))
        
        
        let moreOptions = UIBarButtonItem(image: UIImage(named: "moreOptions")?.withRenderingMode(.alwaysOriginal),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(self.moreOptionsWasTapped))
    
      
        self.navigationItem.rightBarButtonItems = [moreOptions, filter, addNewTodo];
    
    }
    
    
    @objc private func addTodoWasTapped() {
        
        addTodoViewController = AddNewToDoViewController()
        addTodoViewController.delegate = self
        
        present(UINavigationController(rootViewController: addTodoViewController),
                animated: true,
                completion: {})
    }
    
    
    @objc private func filterTodosoWasTapped(){
        
        let optionMenu = UIAlertController(title: nil, message: "Filter Options", preferredStyle: .actionSheet)

            let showAllTodos = UIAlertAction(title: "Show All", style: .default, handler: { [self](alert: UIAlertAction!) -> Void in
                todoList =  ApplicationTodos.shared.todos
                tableView.reloadData()
            })
        
            let filterByCompleted = UIAlertAction(title: "Show Completed", style: .default, handler: { [self](alert: UIAlertAction!) -> Void in
                todoList = ApplicationTodos.shared.todos.filter( { $0.isComplete })
                tableView.reloadData()
            })
        
        
            let filterByInComplete = UIAlertAction(title: "Show Incomplete", style: .default, handler: { [self](alert: UIAlertAction!) -> Void in
                
                todoList = ApplicationTodos.shared.todos.filter( { !$0.isComplete })
                tableView.reloadData()
            })
    
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
            {
                (alert: UIAlertAction!) -> Void in
               
            })
            optionMenu.addAction(showAllTodos)
            optionMenu.addAction(filterByCompleted)
            optionMenu.addAction(filterByInComplete)
            optionMenu.addAction(cancelAction)
            self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    
    @objc private func moreOptionsWasTapped(){
       
        let optionMenu = UIAlertController(title: nil, message: "Additional Options", preferredStyle: .actionSheet)

            let clearAllCompleted = UIAlertAction(title: "Delete All Completed", style: .default, handler: { [self](alert: UIAlertAction!) -> Void in
                ApplicationTodos.shared.todos.removeAll { $0.isComplete }
                todoList = ApplicationTodos.shared.todos
                tableView.reloadData()
            })
    
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           
            optionMenu.addAction(clearAllCompleted)
            optionMenu.addAction(cancelAction)
            self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    
    
    @objc private func retrieveTodos() {
        
        TodoService().retrieveTodos() { results in
            ApplicationTodos.shared.todos = results
            self.todoList = results
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }

    
  
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return ApplicationTodos.shared.todos.count
        return todoList.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        editTodoViewController = EditToDoViewController(withTodo: todoList[indexPath.row])
        editTodoViewController.delegate = self;
        
        self.navigationController?.pushViewController(editTodoViewController,
                                                      animated: true)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoTableCellIdentifier", for: indexPath)
        
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.textLabel?.text = ApplicationTodos.shared.todos[indexPath.row].name
        cell.textLabel?.text = todoList[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let todoToDelete = ApplicationTodos.shared.todos[indexPath.row]
        
            if let index = ApplicationTodos.shared.todos.firstIndex(where: {$0.id == todoToDelete.id}) {
                ApplicationTodos.shared.todos.remove(at: index)
                todoList = ApplicationTodos.shared.todos
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


extension TodoTableViewController: TodoDelegate {
    
    func TodoWasModified(todo: Todo) {

        if let index = ApplicationTodos.shared.todos.firstIndex(where: { $0.id == todo.id }) {
            ApplicationTodos.shared.todos[index] = todo
            todoList = ApplicationTodos.shared.todos
        }
    }
    
    func TodoWasDelted(todo: Todo) {
       
        if let index = ApplicationTodos.shared.todos.firstIndex(where: {$0.id == todo.id}) {
            ApplicationTodos.shared.todos.remove(at: index)
            todoList = ApplicationTodos.shared.todos
            tableView.reloadData()
        }
    }
    
    func TodoWasAdded(todo: Todo) {
        ApplicationTodos.shared.todos.append(todo)
        todoList = ApplicationTodos.shared.todos
        tableView.reloadData()
    }
}
