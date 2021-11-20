//
//  LoginViewController.swift
//  Project
//
//  Created by Bdour Brahim Alharbi on 20/11/2021.
//

import UIKit

protocol LoginInteractable {
    func login(email: String, _ reqResponse: @escaping (Bool) -> Void)
    func varifyOTP(email: String,otp: String, _ reqResponse: @escaping (Bool) -> Void)
    func goToIncidintsPage()
    func showDashboardTapped()

}

final class LoginViewController: UIViewController {


    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var enterEmailLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var oTPTextField: CustomTextField!

    var isEmailLoginCompleted = false

    let interactor: LoginInteractable
    private let viewModel: LoginViewModel

    init(interactor: LoginInteractable, viewModel: LoginViewModel) {
        self.interactor = interactor
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        applyViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @IBAction func buttonTapped() {
        if !isEmailLoginCompleted {
            login()
        } else {
            varifyOTP()
        }
    }

    @IBAction func showIncidintsTapped() {
        interactor.goToIncidintsPage()
    }

    @IBAction func showDashboardTapped() {
        interactor.showDashboardTapped()
    }

    func login(){
        interactor.login(email: emailTextField.text) { succes in
            if succes {
                self.showOTP()
            } else {
                self.presentErrorMessege()
            }
        }
    }

    func showOTP(){
        isEmailLoginCompleted = true
        emailTextField.isUserInteractionEnabled = false
        oTPTextField.isHidden = false
        enterEmailLabel.text = viewModel.enterOTPText
        loginButton.setTitle(viewModel.varifyButtonText, for: .normal)
        disableLoginButton()
    }

    func varifyOTP(){
        interactor.varifyOTP(email: emailTextField.text, otp: oTPTextField.text) { success in
            if !success {
                self.presentErrorMessege()
            }
        }
    }

    private func applyViewModel() {
        loginLabel.text = viewModel.loginText
        disableLoginButton()
        
        enterEmailLabel.text = viewModel.enterEmailText

        emailTextField.placeholder = "a@a.com"
        emailTextField.delegate = self


        oTPTextField.placeholder = "1234"
        oTPTextField.textField.textContentType = .oneTimeCode
        oTPTextField.delegate = self
        oTPTextField.isHidden = true

    }

    func disableLoginButton(){
        loginButton.backgroundColor = .darkGray
        loginButton.isEnabled = false
    }
    func enableLoginButton(){
        loginButton.backgroundColor = .purple
        loginButton.isEnabled = true
    }

    func presentErrorMessege(){
        let alert = UIAlertController(title: "Alert", message: "Somthing wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !isEmailLoginCompleted {
        if textField == emailTextField.field && emailTextField.isEmpty() {
            emailTextField.setError(errorMessage:"the feild is empty")
            disableLoginButton()
        } else {
            enableLoginButton()
        }} else {
            if textField == oTPTextField.field && oTPTextField.isEmpty() {
                emailTextField.setError(errorMessage:"the feild is empty")
                disableLoginButton()
            } else {
                enableLoginButton()
            }
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !isEmailLoginCompleted {
        if textField == emailTextField.field && emailTextField.isEmpty() {
            disableLoginButton()
        } else {
            enableLoginButton()
        }} else {
            if textField == oTPTextField.field && oTPTextField.isEmpty() {
                disableLoginButton()
            } else {
                enableLoginButton()
            }
        }

        return true
    }
}
