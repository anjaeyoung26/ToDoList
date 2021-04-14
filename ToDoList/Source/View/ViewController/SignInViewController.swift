//
//  SignInViewController.swift
//  ToDoList
//
//  Created by 안재영 on 2020/06/24.
//  Copyright © 2020 안재영. All rights reserved.
//

import Firebase
import FBSDKLoginKit
import GoogleSignIn
import RxCocoa
import RxSwift
import UIKit

class SignInViewController: BaseViewController {

  let lblCaption = UILabel().then {
    $0.font = Font.Helvetica.condensedBlack(size: 55)
    $0.textAlignment = .center
    $0.textColor = .black
    $0.text = "To do List"
  }
  
  let subViewEmail = UIView().then {
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 0.3
    $0.backgroundColor = .white
  }
  
  let imgViewEmail = UIImageView().then {
    $0.image = Image.email
  }
  
  let txtEmail = UITextField().then {
    $0.font = Font.Avenir.demiBold(size: 21)
    $0.textColor = .darkGray
  }
  
  let subViewPassword = UIView().then {
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 0.3
    $0.backgroundColor = .white
  }
  
  let imgPassword = UIImageView().then {
    $0.image = Image.password
  }
  
  let txtPassword = UITextField().then {
    $0.font = Font.Avenir.demiBold(size: 21)
    $0.isSecureTextEntry = true
    $0.textColor = .darkGray
  }
  
  let btnSecurePassword = UIButton().then {
    $0.setImage(UIImage(named: "Close eye.png"), for: .normal)
  }
  
  let btnResetPassword = UIButton().then {
    $0.setTitleColor(.lightGray, for: .normal)
    $0.setTitle("Forgot your Password?", for: .normal)
    $0.titleLabel?.font = Font.Avenir.bold(size: 18)
  }
  
  let btnSignIn = UIButton().then {
    $0.setTitleColor(.darkGray, for: .normal)
    $0.setTitle("Sign In", for: .normal)
    $0.titleLabel?.font = Font.Helvetica.condensedBlack(size: 22)
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 0.3
  }
  
  let btnSignUp = UIButton().then {
    $0.setTitleColor(.darkGray, for: .normal)
    $0.setTitle("Sign Up", for: .normal)
    $0.titleLabel?.font = Font.Helvetica.condensedBlack(size: 22)
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 0.3
  }
  
  let lblOr = UILabel().then {
    $0.font = Font.System.nomal(size: 15)
    $0.textColor = .black
    $0.text = "⏤ Or ⏤"
  }
  
  let btnFacebook = UIButton().then {
    $0.setImage(Image.facebook, for: .normal)
  }
  
  let btnGoogle = UIButton().then {
    $0.setImage(Image.google, for: .normal)
  }
  
  let facebookDelegate = FBLoginButton().then {
    $0.isHidden = true
  }
  
  let googleDelegate = GIDSignInButton().then {
    $0.isHidden = true
  }
  
  let viewModel: SignInViewModel
  
  init(viewModel: SignInViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    
    self.rx.viewDidLoad
      .subscribe(onNext: {
        guard let user = Auth.auth().currentUser else { return }
        self.viewModel.input.loggedInUser.accept(user)
      })
      .disposed(by: disposeBag)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dismissKeyboardOnTap()
    GIDSignIn.sharedInstance()?.presentingViewController = self
  }
  
  override func addSubview() {
    [lblCaption, lblOr, subViewEmail, txtEmail, subViewPassword, txtPassword, imgViewEmail, imgPassword, btnSecurePassword, btnSignIn, btnSignUp, btnResetPassword, btnFacebook, btnGoogle].forEach { view.addSubview($0) }
  }
  
  override func setConstraints() {
    lblCaption.snp.makeConstraints { make in
      make.top.greaterThanOrEqualToSuperview().offset(50)
      make.top.lessThanOrEqualToSuperview().offset(130)
      make.left.equalToSuperview().offset(30)
      make.right.equalToSuperview().offset(-30)
    }
    
    subViewEmail.snp.makeConstraints { make in
      make.top.equalTo(lblCaption.snp.bottom).offset(70)
      make.left.equalToSuperview().offset(35)
      make.right.equalToSuperview().offset(-35)
      make.bottom.equalTo(subViewPassword.snp.top).offset(-20)
    }
    
    txtEmail.snp.makeConstraints { make in
      make.top.right.height.equalTo(subViewEmail)
      make.left.equalTo(subViewEmail).offset(53)
    }
    
    imgViewEmail.snp.makeConstraints { make in
      make.top.equalTo(subViewEmail).offset(12)
      make.left.equalTo(subViewEmail).offset(10)
      make.width.height.equalTo(35)
    }
    
    subViewPassword.snp.makeConstraints { make in
      make.top.equalTo(lblCaption.snp.bottom).offset(150)
      make.left.equalToSuperview().offset(35)
      make.right.equalToSuperview().offset(-35)
      make.height.equalTo(55)
    }
    
    txtPassword.snp.makeConstraints { make in
      make.top.equalTo(subViewPassword).offset(2)
      make.right.height.equalTo(subViewPassword)
      make.left.equalTo(subViewPassword).offset(53)
    }
    
    imgPassword.snp.makeConstraints { make in
      make.top.equalTo(subViewPassword).offset(10)
      make.left.equalTo(subViewPassword).offset(10)
      make.width.height.equalTo(35)
    }
    
    btnSecurePassword.snp.makeConstraints { make in
      make.top.equalTo(lblCaption.snp.bottom).offset(158)
      make.right.equalToSuperview().offset(-45)
      make.width.height.equalTo(40)
    }
    
    btnResetPassword.snp.makeConstraints { make in
      make.top.equalTo(txtPassword.snp.bottom).offset(7)
      make.left.equalToSuperview().offset(35)
      make.height.equalTo(30)
    }
    
    btnSignIn.snp.makeConstraints { make in
      make.top.greaterThanOrEqualTo(btnResetPassword.snp.bottom).offset(20)
      make.top.lessThanOrEqualTo(btnResetPassword.snp.bottom).offset(50)
      make.left.equalToSuperview().offset(35)
      make.right.equalToSuperview().offset(-35)
      make.height.equalTo(55)
    }

    btnSignUp.snp.makeConstraints { make in
      make.top.equalTo(btnSignIn.snp.bottom).offset(10)
      make.left.equalToSuperview().offset(35)
      make.right.equalToSuperview().offset(-35)
      make.height.equalTo(55)
    }
    
    lblOr.snp.makeConstraints { make in
      make.top.greaterThanOrEqualTo(btnSignUp.snp.bottom).offset(25)
      make.top.lessThanOrEqualTo(btnSignUp.snp.bottom).offset(60)
      make.centerX.equalToSuperview()
    }
    
    btnFacebook.snp.makeConstraints { make in
      make.top.greaterThanOrEqualTo(lblOr.snp.bottom).offset(10)
      make.top.lessThanOrEqualTo(lblOr.snp.bottom).offset(20)
      make.centerX.equalToSuperview().offset(-40)
      make.width.height.equalTo(40)
      make.bottom.lessThanOrEqualToSuperview().offset(-70)
      make.bottom.greaterThanOrEqualToSuperview().offset(-120)
    }
    
    btnGoogle.snp.makeConstraints { make in
      make.top.greaterThanOrEqualTo(lblOr.snp.bottom).offset(15)
      make.top.lessThanOrEqualTo(lblOr.snp.bottom).offset(20)
      make.centerX.equalToSuperview().offset(40)
      make.width.height.equalTo(40)
      make.bottom.lessThanOrEqualToSuperview().offset(-70)
      make.bottom.greaterThanOrEqualToSuperview().offset(-120)
    }
  }
  
  override func binding() {
    btnSignUp.rx.tap
      .bind(onNext: { self.presentSignUpViewController() })
      .disposed(by: disposeBag)
    
    btnResetPassword.rx.tap
      .bind(onNext: { self.presentResetPasswordViewController() })
      .disposed(by: disposeBag)
    
    btnSignIn.rx.tap
      .withLatestFrom(Observable.combineLatest(txtEmail.rx.text.orEmpty, 
                                               txtPassword.rx.text.orEmpty))
      .map { (email: $0, password: $1) }
      .bind(to: viewModel.input.emailLogin)
      .disposed(by: disposeBag)
    
    btnFacebook.rx.tap
      .bind(onNext: { self.facebookDelegate.sendActions(for: .touchUpInside) })
      .disposed(by: disposeBag)
    
    btnGoogle.rx.tap
      .bind(onNext: { self.googleDelegate.sendActions(for: .touchUpInside) })
      .disposed(by: disposeBag)
    
    btnSecurePassword.rx.tap
      .do(afterNext: { self.txtPassword.isSecureTextEntry.toggle() })
      .bind(onNext: { self.btnSecurePassword.setImage(self.txtPassword.isSecureTextEntry ? Image.openEye : Image.closeEye, for: .normal) })
      .disposed(by: disposeBag)
    
    viewModel.output.loginResult
      .subscribe(onNext: { result in
        switch result {
        case .success:
          SCLAlert.present(target: self, title: "SUCCESS", subTitle: "Sign in succeeded", buttonText: "Start",
                           buttonSelector: #selector(self.presentToDoListViewController), style: .success)
        case .notice(let message):
          SCLAlert.present(title: "INFO", subTitle: message.description, style: .info)
        case .failure(let error):
          AuthErrorCode.show(error)
        }
      })
      .disposed(by: disposeBag)
    
    facebookDelegate.rx.result
      .subscribe(onNext: { result, error in
        if let token = result?.token {
          self.viewModel.input.facebookLogin.accept(token)
        } else if let error = error as NSError? {
          AuthErrorCode.show(error)
        }
      })
      .disposed(by: disposeBag)
    
    GIDSignIn.sharedInstance().rx.result
      .subscribe(onNext: { user, error in
        if let user = user {
          self.viewModel.input.googleLogin.accept(user.authentication)
        } else if let error = error as NSError? {
          GIDSignInErrorCode.show(error)
        }
      })
      .disposed(by: disposeBag)
  }
}

extension SignInViewController {
  @objc
  func presentToDoListViewController() {
    let dependency = ToDoListViewModel.Dependency(taskService: TaskService(), authService: AuthService())
    let viewModel = ToDoListViewModel(dependency: dependency)
    let viewController = ToDoListViewController(viewModel: viewModel)
    
    viewController.modalPresentationStyle = .fullScreen
    viewController.modalTransitionStyle = .crossDissolve
    
    self.present(viewController, animated: true, completion: {
      self.txtEmail.text = nil
      self.txtPassword.text = nil
    })
  }
  
  private func presentSignUpViewController() {
     let dependency = SignUpViewModel.Dependency(authService: AuthService())
     let viewModel = SignUpViewModel(dependency: dependency)
     let viewController = SignUpViewController(viewModel: viewModel)

     self.present(viewController, animated: true, completion: nil)
  }
  
  private func presentResetPasswordViewController() {
    let dependency = ResetPasswordViewModel.Dependency(authService: AuthService())
    let viewModel = ResetPasswordViewModel(dependency: dependency)
    let viewController = ResetPasswordViewController(viewModel: viewModel)
    
    self.present(viewController, animated: true, completion: nil)
  }
}
