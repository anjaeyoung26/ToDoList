//
//  ResetPasswordViewController.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/18.
//  Copyright © 2020 안재영. All rights reserved.
//

import Firebase
import RxCocoa
import RxSwift
import UIKit

class ResetPasswordViewController: BaseViewController {
  
  let btnDismiss = UIButton().then {
    $0.setImage(SFSymbols.back, for: .normal)
  }
  
  let lblTitle = UILabel().then {
    $0.font = Font.Avenir.bold(size: 45)
    $0.textAlignment = .center
    $0.text = "Reset Password"
  }
  
  let lblSubTitle = UILabel().then {
    $0.font = Font.Avenir.demiBold(size: 16)
    $0.textAlignment = .center
    $0.textColor = .lightGray
    $0.numberOfLines = 0
    $0.text = "If you want to reset your password, Enter provide email address that you used when you signed up"
  }
  
  let txtEmail = UITextField().then {
    $0.leftPaddingView()
    $0.font = Font.Avenir.bold(size: 20)
    $0.textColor = .darkGray
    $0.placeholder = "Email"
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 0.3
  }
  
  let btnSend = UIButton().then {
    $0.setTitleColor(.white, for: .normal)
    $0.setTitle("Send", for: .normal)
    $0.titleLabel?.font = Font.Avenir.bold(size: 23)
    $0.layer.shadowOffset = CGSize(width: 0, height: 3)
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowRadius = 5
  }
  
  let lblRemenberPassword = UILabel().then {
    $0.font = Font.Avenir.demiBold(size: 17)
    $0.textColor = .lightGray
    $0.text = "Remember password ?"
  }
  
  let btnSignIn = UIButton().then {
    $0.titleLabel?.font = Font.Avenir.bold(size: 17)
    $0.setTitleColor(.black, for: .normal)
    $0.setTitle("Sign in", for: .normal)
  }
  
  let viewModel: ResetPasswordViewModel
  
  init(viewModel: ResetPasswordViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dismissKeyboardOnTap()
  }
  
  override func addSubview() {
    [btnDismiss, lblTitle, lblSubTitle, txtEmail, btnSend, lblRemenberPassword, btnSignIn].forEach { self.view.addSubview($0) }
  }
  
  override func setConstraints() {
    btnDismiss.snp.makeConstraints {
      $0.top.equalToSuperview().offset(50)
      $0.left.equalToSuperview().offset(10)
      $0.width.height.equalTo(23)
    }
    
    lblTitle.snp.makeConstraints {
      $0.top.equalTo(btnDismiss.snp.bottom).offset(50)
      $0.centerX.equalToSuperview()
    }
    
    lblSubTitle.snp.makeConstraints {
      $0.top.equalTo(lblTitle.snp.bottom).offset(20)
      $0.left.right.equalTo(view.readableContentGuide)
      $0.centerX.equalToSuperview()
    }
    
    txtEmail.snp.makeConstraints {
      $0.top.equalTo(lblSubTitle.snp.bottom).offset(70)
      $0.left.equalToSuperview().offset(20)
      $0.right.equalToSuperview().offset(-20)
      $0.height.equalTo(55)
    }
    
    btnSend.snp.makeConstraints {
      $0.top.equalTo(txtEmail.snp.bottom).offset(30)
      $0.left.equalToSuperview().offset(20)
      $0.right.equalToSuperview().offset(-20)
      $0.height.equalTo(55)
    }
    
    lblRemenberPassword.snp.makeConstraints {
      $0.top.equalTo(btnSend.snp.bottom).offset(33)
      $0.centerX.equalToSuperview().offset(-50)
    }
    
    btnSignIn.snp.makeConstraints {
      $0.top.equalTo(btnSend.snp.bottom).offset(26)
      $0.left.equalTo(lblRemenberPassword.snp.right).offset(10)
    }
  }
  
  override func binding() {
    let email = txtEmail.rx.text.orEmpty.share()
    
    email
      .map { $0.isEmailForm() }
      .subscribe(onNext: { self.btnSend.setEnabledState($0) })
      .disposed(by: disposeBag)
    
    btnSend.rx.tap
      .withLatestFrom(email)
      .bind(to: viewModel.input.sendButtonTapped)
      .disposed(by: disposeBag)
    
    viewModel.output.result
      .subscribe(onNext: { result in
        switch result {
        case .success:
          self.dismiss(animated: true, completion: {
            SCLAlert.present(title: "SUCCESS", subTitle: "Send email succeeded", style: .success)
          })
        case .notice(let message):
          SCLAlert.present(title: "INFO", subTitle: message.description, style: .info)
        case .failure(let error):
          AuthErrorCode.show(error)
        }
      })
      .disposed(by: disposeBag)
    
    Observable.of(btnSignIn.rx.tap, btnDismiss.rx.tap).merge()
      .bind(onNext: { self.dismiss(animated: true, completion: nil) })
      .disposed(by: disposeBag)
  }
}

extension ResetPasswordViewController: KeyboardObserverProtocol {
  override func viewWillAppear(_ animated: Bool) {
    register()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    remove()
  }
}
