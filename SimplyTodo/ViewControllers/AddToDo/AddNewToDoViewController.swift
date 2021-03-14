//
//  AddNewToDoViewController.swift
//  SimplyTodo
//
//  Created by Casey Egan on 3/13/21.
//

import UIKit

class AddNewToDoViewController: UIViewController {
    
    @IBOutlet weak var todoTextView: UITextView!
    var delegate: SomeDelegate!
    
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
        delegate.TodoWasAdded(todo: Todo(name: self.todoTextView.text))
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButtonTapped(){
        dismiss(animated: true, completion: nil)
    }

}
