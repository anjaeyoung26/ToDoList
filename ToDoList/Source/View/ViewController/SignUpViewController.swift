//
//  SignUpViewController.swift
//  ToDoList
//
//  Created by 안재영 on 2020/06/24.
//  Copyright © 2020 안재영. All rights reserved.
//

import Firebase
import UIKit
import RxCocoa
import RxSwift

class SignUpViewController: BaseViewController {
  
  let btnDismiss = UIButton().then {
    $0.setImage(SFSymbols.back, for: .normal)
  }
  
  let lblCaption = UILabel().then {
    $0.font = Font.Avenir.bold(size: 45)
    $0.textAlignment = .center
    $0.text = "Sign up"
  }
  
  let lblSubCaption = UILabel().then {
    $0.font = Font.Avenir.demiBold(size: 18)
    $0.textAlignment = .center
    $0.numberOfLines = 0
    $0.textColor = .gray
    $0.text = "Please enter each item appropriately"
  }
  
  let txtName = UITextField().then {
    $0.leftPaddingView()
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 0.3
    $0.font = Font.Avenir.bold(size: 20)
    $0.textColor = .darkGray
    $0.placeholder = "Name"
  }
  
  let txtEmail = UITextField().then {
    $0.leftPaddingView()
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 0.3
    $0.font = Font.Avenir.bold(size: 20)
    $0.textColor = .darkGray
    $0.placeholder = "Email"
  }
  
  let txtPassword = UITextField().then {
    $0.leftPaddingView()
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 0.3
    $0.font = Font.Avenir.bold(size: 20)
    $0.isSecureTextEntry = true
    $0.textColor = .darkGray
    $0.placeholder = "Password"
  }
  
  let txtConformPassword = UITextField().then {
    $0.leftPaddingView()
    $0.font = Font.Avenir.bold(size: 20)
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 0.3
    $0.isSecureTextEntry = true
    $0.textColor = .darkGray
    $0.placeholder = "Conform Password"
  }
  
  let btnSignUp = UIButton().then {
    $0.setTitleColor(.white, for: .normal)
    $0.setTitle("Sign Up", for: .normal)
    $0.titleLabel?.font = Font.Avenir.bold(size: 23)
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowOffset = CGSize(width: 0, height: 8)
    $0.layer.shadowRadius = 10
  }
  
  let checkName = UIImageView().then {
    $0.tintColor = .gray
  }
  
  let checkEmail = UIImageView().then {
    $0.tintColor = .gray
  }
  
  let checkPassword = UIImageView().then {
    $0.tintColor = .gray
  }
  
  let checkConformPassword = UIImageView().then {
    $0.tintColor = .gray
  }
  
  let viewModel: SignUpViewModel
  
  init(viewModel: SignUpViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dismissKeyboardOnTap()
    
    txtName.delegate = self
    txtEmail.delegate = self
    txtPassword.delegate = self
    txtConformPassword.delegate = self
  }
  
  override func addSubview() {
    [btnDismiss, lblCaption, lblSubCaption, txtName, txtEmail, txtPassword, txtConformPassword, btnSignUp, checkName, checkEmail, checkPassword, checkConformPassword].forEach { view.addSubview($0)}
  }
  
  override func setConstraints() {
    btnDismiss.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(50)
      make.left.equalToSuperview().offset(10)
      make.width.height.equalTo(23)
    }
    
    lblCaption.snp.makeConstraints { make in
      make.top.greaterThanOrEqualTo(btnDismiss.snp.bottom)
      make.top.lessThanOrEqualTo(btnDismiss.snp.bottom).offset(30)
      make.centerX.equalToSuperview()
    }
    
    lblSubCaption.snp.makeConstraints { make in
      make.top.equalTo(lblCaption.snp.bottom).offset(20)
      make.centerX.equalToSuperview()
    }
    
    txtName.snp.makeConstraints { make in
      make.top.equalTo(lblSubCaption.snp.bottom).offset(50)
      make.left.equalToSuperview().offset(30)
      make.right.equalToSuperview().offset(-30)
      make.height.equalTo(55)
    }
    
    txtEmail.snp.makeConstraints { make in
      make.top.equalTo(txtName.snp.bottom).offset(25)
      make.left.equalToSuperview().offset(30)
      make.right.equalToSuperview().offset(-30)
      make.height.equalTo(55)
    }
    
    txtPassword.snp.makeConstraints { make in
      make.top.equalTo(txtEmail.snp.bottom).offset(25)
      make.left.equalToSuperview().offset(30)
      make.right.equalToSuperview().offset(-30)
      make.height.equalTo(55)
    }
    
    txtConformPassword.snp.makeConstraints { make in
      make.top.equalTo(txtPassword.snp.bottom).offset(25)
      make.left.equalToSuperview().offset(30)
      make.right.equalToSuperview().offset(-30)
      make.height.equalTo(55)
    }
    
    btnSignUp.snp.makeConstraints { make in
      make.top.equalTo(txtConformPassword.snp.bottom).offset(25)
      make.left.equalToSuperview().offset(30)
      make.right.equalToSuperview().offset(-30)
      make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(-30)
      make.height.equalTo(55)
    }
    
    checkName.snp.makeConstraints { make in
      make.centerY.equalTo(txtName)
      make.right.equalToSuperview().offset(-42)
    }
    
    checkEmail.snp.makeConstraints { make in
      make.centerY.equalTo(txtEmail)
      make.right.equalToSuperview().offset(-42)
    }
    
    checkPassword.snp.makeConstraints { make in
      make.centerY.equalTo(txtPassword)
      make.right.equalToSuperview().offset(-42)
    }
    
    checkConformPassword.snp.makeConstraints { make in
      make.centerY.equalTo(txtConformPassword)
      make.right.equalToSuperview().offset(-42)
    }
  }
  
  override func binding() {
    let entryObservable = Observable.combineLatest(
      txtEmail.rx.text.orEmpty, txtName.rx.text.orEmpty, txtPassword.rx.text.orEmpty, txtConformPassword.rx.text.orEmpty).share()
    
    entryObservable
      .map { email, name, password, conformPassword -> Bool in
        let isEmailForm = email.isEmailForm()
        let isNameHasCharacters = name.hasCharacters()
        let isPasswordHasCharacters = password.hasCharacters()
        let isConformPasswordHasCharacters = conformPassword.hasCharacters()
        
        self.checkEmail.image = isEmailForm ? SFSymbols.checkMarkCircle : SFSymbols.circle
        self.checkName.image = isNameHasCharacters ? SFSymbols.checkMarkCircle : SFSymbols.circle
        self.checkPassword.image = isPasswordHasCharacters ? SFSymbols.checkMarkCircle : SFSymbols.circle
        self.checkConformPassword.image = isConformPasswordHasCharacters ? SFSymbols.checkMarkCircle : SFSymbols.circle
        
        return isEmailForm && isNameHasCharacters && isPasswordHasCharacters && isConformPasswordHasCharacters
      }
      .distinctUntilChanged()
      .subscribe(onNext: {
        self.btnSignUp.setEnabledState($0)
      })
      .disposed(by: disposeBag)
    
    btnSignUp.rx.tap
      .withLatestFrom(entryObservable)
      .bind(to: viewModel.input.signUpButtonTapped)
      .disposed(by: disposeBag)
    
    btnDismiss.rx.tap
      .bind(onNext: {
        self.dismiss(animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
    
    viewModel.output.result
      .subscribe(onNext: { result in
        switch result {
        case .success:
          self.dismiss(animated: true, completion: {
            SCLAlert.present(title: "SUCCESS", subTitle: "Sign up succeeded", style: .success)
          })
        case .notice(let message):
          SCLAlert.present(title: "INFO", subTitle: message.description, style: .info)
        case .failure(let error):
          AuthErrorCode.show(error)
        }
      })
      .disposed(by: disposeBag)
  }
}

extension SignUpViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text else { return true }
    let newLength = text.count + string.count - range.length
    return newLength <= 25
  }
}

extension SignUpViewController: KeyboardObserverProtocol {
  override func viewWillAppear(_ animated: Bool) {
    register()
  }
  override func viewWillDisappear(_ animated: Bool) {
    remove()
  }
}
 
