//
//  MainViewController.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import UIKit
import Closures

class MainViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: - Properties
    
    weak var coordinator: MainCoordinator?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Setup
    
    private func setup() {
        setupButtons()
        setupTextFields()
    }
    
    private func setupButtons() {
        searchButton.onTap { [weak self] in
            guard let self = self else { return }
            self.search() // proceed to search
        }
    }
    
    private func setupTextFields() {
        searchTextField.onChange { [weak self] text in // disables the button if textfield is empty
            guard let self = self else { return }
            self.searchButton.alpha = text.isEmpty ? 0.5 : 1
            self.searchButton.isUserInteractionEnabled = !text.isEmpty
        }.onReturn { [weak self] in
            guard let self = self else { return }
            self.search() // proceeds to search if return button is tapped
        }
    }
    
    // MARK: - CTA
    
    // proceed to the results screen passing the search string
    private func search() {
        self.coordinator?.showSearchResults(searchString: self.searchTextField.text ?? "")
    }
}

// MARK: - StoryboardInstantiable

extension MainViewController: StoryboardInstantiable {
    struct Input {}
    struct Output {}
    
    static func generateFromStoryboard(input: Input = .init(), output: Output = .init()) -> MainViewController {
        let controller = StoryboardScene.Main.initialScene.instantiate()
        return controller
    }
}
