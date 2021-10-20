//
//  SignInScreenViewController.swift
//  Cinema_12
//
//  Created by Преподаватель on 20.10.2021.
//

import UIKit

class SignInScreenViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAtributs()
    }
    
    
    // Авторизация
    @IBAction func authoriztion(_ sender: Any) {
        let cheker = EmailCheker(email: emailTextField.text!)
        let authorization = Authorization()
        
        guard emailTextField.hasText, passwordTextField.hasText else{
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
        
        let auth = authorization.login(email: emailTextField.text!, password: passwordTextField.text!)
        guard auth == "" else {
            sendAlert(message: auth)
            return
        }
        
        let vc = storyboard!.instantiateViewController(withIdentifier: "main")
        present(vc, animated: true)
        
    }
    
    // Создание и отправка окна уводомления
    func sendAlert(title: String = "Ошибка", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true)
    }
    
    // Загрузка атрибутов для элементов
    func loadAtributs(){
        emailTextField.attributedPlaceholder = NSAttributedString(string: "   E-mail", attributes: [.foregroundColor : UIColor(red: 175, green: 175, blue: 175, alpha: 100)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "  Пароль", attributes: [.foregroundColor : UIColor(red: 175, green: 175, blue: 175, alpha: 100)])
        
        emailTextField.layer.borderWidth = 1
        
        emailTextField.layer.borderColor = UIColor(red: 175, green: 175, blue: 175, alpha: 100).cgColor
        emailTextField.layer.cornerRadius = 7
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(red: 175, green: 175, blue: 175, alpha: 100).cgColor
        passwordTextField.layer.cornerRadius = 7
        
        loginButton.layer.cornerRadius = 7
        registerButton.layer.cornerRadius = 7
        registerButton.layer.borderColor = UIColor(red: 175, green: 175, blue: 175, alpha: 100).cgColor
        registerButton.layer.borderWidth = 1
        
    }
    
    
}
