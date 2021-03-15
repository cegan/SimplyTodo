//
//  AddNewToDoViewController.swift
//  SimplyTodo
//
//  Created by Casey Egan on 3/13/21.
//

import UIKit

class AddNewToDoViewController: UIViewController {
    
    @IBOutlet weak var todoTextView: UITextView!
    var delegate: TodoDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installViewProperties()
        installNavigationItems()
    }
    

    private func installViewProperties() {
        self.view.backgroundColor = .white
        self.title = "Add ToDo"
    }
    
    private func installNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .red
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .red
    }
    
    @objc private func doneButtonTapped() {
        
        if !todoTextView.text.isEmpty {
            delegate.TodoWasAdded(todo: Todo(name: todoTextView.text))
            dismiss(animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Please Enter A Todo", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func cancelButtonTapped(){
        dismiss(animated: true, completion: nil)
    }

}
