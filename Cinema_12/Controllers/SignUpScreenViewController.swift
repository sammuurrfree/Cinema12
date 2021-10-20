//
//  SignUpScreenViewController.swift
//  Cinema_12
//
//  Created by Преподаватель on 20.10.2021.
//

import UIKit

class SignUpScreenViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAtributs()
    }
    
    // Регистрация
    @IBAction func register(_ sender: UIButton) {
        let cheker = EmailCheker(email: emailField.text!)
        let registartion = Registration()
        
        guard nameTextField.hasText, firstNameField.hasText, emailField.hasText, passwordField.hasText, repeatPasswordField.hasText else{
            sendAlert(message: "Заполните все поля!")
            return
        }
        guard cheker.chekEmailPatern() else {
            sendAlert(message: "Email должен соответствовать паттерну 'name@domenname.ru'!")
            return
        }
        guard cheker.chekDomen() else {
            sendAlert(message: "Длина домена верхнего уровня - не более 3х символов!")
            return
        }
        guard cheker.chekDomainRegister() else {
            sendAlert(message: "Домен второго уровня могут состоять только из маленьких букв и цифр!")
            return
        }
        guard passwordField.text == repeatPasswordField.text else {
            sendAlert(message: "Пароль и повтор пороля должны совподать!")
            return
        }
        
        guard registartion.register(email: emailField.text!, password: passwordField.text!, firstName: firstNameField.text!, lastName: nameTextField.text!) ?? false else{
            sendAlert(message: "При регестрации произошла ошибка!")
            return
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "main")
        present(vc!, animated: true)
            
    }
    
    
    // Создание и отправка окна уводомления
    func sendAlert(title: String = "Ошибка", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true)
    }
    
    
    // Загрузка атрибутов для элементов
    func loadAtributs(){
        nameTextField.attributedPlaceholder = NSAttributedString(string: "   Имя", attributes: [.foregroundColor : UIColor(red: 168, green: 168, blue: 168, alpha: 100)])
        firstNameField.attributedPlaceholder = NSAttributedString(string: "  Фамилия", attributes: [.foregroundColor : UIColor(red: 168, green: 168, blue: 168, alpha: 100)])
        emailField.attributedPlaceholder = NSAttributedString(string: "  E-mail", attributes: [.foregroundColor : UIColor(red: 168, green: 168, blue: 168, alpha: 100)])
        passwordField.attributedPlaceholder = NSAttributedString(string: "  Пароль", attributes: [.foregroundColor : UIColor(red: 168, green: 168, blue: 168, alpha: 100)])
        repeatPasswordField.attributedPlaceholder = NSAttributedString(string: "  Повторите пароль", attributes: [.foregroundColor : UIColor(red: 168, green: 168, blue: 168, alpha: 100)])
        
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor(red: 175, green: 175, blue: 175, alpha: 100).cgColor
        nameTextField.layer.cornerRadius = 7
        
        firstNameField.layer.borderWidth = 1
        firstNameField.layer.borderColor = UIColor(red: 175, green: 175, blue: 175, alpha: 100).cgColor
        firstNameField.layer.cornerRadius = 7
        
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor(red: 175, green: 175, blue: 175, alpha: 100).cgColor
        emailField.layer.cornerRadius = 7
        
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor(red: 175, green: 175, blue: 175, alpha: 100).cgColor
        passwordField.layer.cornerRadius = 7
        
        repeatPasswordField.layer.borderWidth = 1
        repeatPasswordField.layer.borderColor = UIColor(red: 175, green: 175, blue: 175, alpha: 100).cgColor
        repeatPasswordField.layer.cornerRadius = 7
        
        
        registerButton.layer.cornerRadius = 7
        loginButton.layer.cornerRadius = 7
        loginButton.layer.borderColor = UIColor(red: 175, green: 175, blue: 175, alpha: 100).cgColor
        loginButton.layer.borderWidth = 1
        
        
    }

}
