////
////  ComposeViewController.swift
////  MiniBootcamp
////
////  Created by Juan David Torres on 10/06/22.
////
//
//import UIKit
//
//class ComposeViewController: UIViewController, UITextFieldDelegate {
//
//    weak var coordinator: MainCoordinator?
//
//    let textFieldTweet: UITextField = create {
//        $0.font = UIFont.bold(withSize: .content)
//        $0.adjustsFontSizeToFitWidth = true
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.placeholder = "Write the content of the tweet..."
//        $0.font = UIFont.normal(withSize: .content)
//        $0.borderStyle = UITextField.BorderStyle.roundedRect
//        $0.autocorrectionType = UITextAutocorrectionType.no
//        $0.keyboardType = UIKeyboardType.default
//        $0.clearButtonMode = UITextField.ViewMode.whileEditing
//    }
//    let buttonSend: UIButton = create {
//        $0.setTitle("Send", for: .normal)
//        $0.backgroundColor = UIColor.redMain
//        $0.setTitleColor(.white, for: .normal)
//        $0.addTarget(ComposeViewController.self, action: #selector(sendTapped), for: UIControl.Event.touchUpInside)
//    }
//
//    let verticalStack: UIStackView = create {
//        $0.axis = .vertical
//        $0.distribution = .fill
//        $0.translatesAutoresizingMaskIntoConstraints = false
//    }
//
//    init(_ coordinator: MainCoordinator) {
//        self.coordinator = coordinator
//        super.init(nibName: "ComposeViewController", bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        textFieldTweet.delegate = self
//        if ((textFieldTweet.text?.isEmpty) != nil){
//            buttonSend.isUserInteractionEnabled = false
//        }
//    }
//
//    @objc func sendTapped() {
//
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//
//        if !text.isEmpty{
//            buttonSend.isUserInteractionEnabled = true
//        } else {
//            buttonSend.isUserInteractionEnabled = false
//        }
//        return true
//    }
//
//    private func configureUI() {
//        self.navigationItem.title = "New Tweet"
//
//        verticalStack.addArrangedSubview(textFieldTweet)
//        verticalStack.addArrangedSubview(buttonSend)
//        self.view.addSubview(verticalStack)
//
//    }
//
//    private func configureConstraints() {
//        NSLayoutConstraint.activate([
//            verticalStack.topAnchor.constraint(equalTo: view.topAnchor),
//            verticalStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
//
//}
