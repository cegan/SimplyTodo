//
//  EditToDoViewController.swift
//  SimplyTodo
//
//  Created by Casey Egan on 3/13/21.
//

import UIKit


protocol TodoDelegate{
    func TodoWasModified(todo: Todo)
    func TodoWasAdded(todo: Todo)
    func TodoWasDelted(todo: Todo)
}

class EditToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var todoStatusTableView: UITableView!
    @IBOutlet weak var todoTextView: UITextView!
    
    var todoToEdit: Todo = Todo()
    var delegate: TodoDelegate!
    
    init(withTodo: Todo) {
        super.init(nibName: "EditToDoViewController", bundle: nil)
        todoToEdit = withTodo
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        installViewProperties()
        installNavigationItems()
        
        todoStatusTableView.delegate = self
        todoStatusTableView.dataSource = self
        todoStatusTableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoStatusCellIdentifier")
        todoTextView.text = todoToEdit.name
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        /*Check if Todo was actually changed before issuing the update*/
        todoToEdit.name = self.todoTextView.text
        delegate.TodoWasModified(todo: todoToEdit)
    }
    
    private func installViewProperties() {
        navigationController!.navigationBar.tintColor = .red
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        title = "Edit ToDo"
    }
    
    
    private func installNavigationItems() {
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "trash")?.withRenderingMode(.alwaysOriginal),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(self.deleteTodoWasTapped))
    }
    
    @objc private func deleteTodoWasTapped() {
        displayDeleteConfirmation()
    }
    
    
    private func displayDeleteConfirmation(){
        
        let optionMenu = UIAlertController(title: nil, message: "Delete This Todo?", preferredStyle: .actionSheet)

            let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: { [self](alert: UIAlertAction!) -> Void in
                delegate.TodoWasDelted(todo: todoToEdit)
                navigationController?.popViewController(animated: true)
            })
        
            deleteAction.setValue(UIColor.red, forKey: "titleTextColor")
    
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            present(optionMenu, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoToEdit.statuses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoStatusCellIdentifier", for: indexPath)
        let statusOption = todoToEdit.statuses[indexPath.row]
        
        
        switch indexPath.row {
        case 0:
            cell.accessoryType = todoToEdit.isComplete ? .checkmark : .none
        case 1:
            cell.accessoryType = !todoToEdit.isComplete ? .checkmark : .none
           
        default:
            cell.accessoryType = .none
        }
        
        cell.textLabel?.text = statusOption.displayName
        cell.selectionStyle = .none
        cell.tintColor = .red

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        resetStatuses()
        
        switch indexPath.row {
        case 0:
            todoToEdit.isComplete = true
        case 1:
            todoToEdit.isComplete = false
        default:
            todoToEdit.isComplete = false
        }
        
        todoStatusTableView.reloadData()
    }

  
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Status"
    }
    
    
    func resetStatuses() {
        self.todoToEdit.statuses.forEach({ $0.isSelected = false})
    }
}



