//
//  DescriptionViewController.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/18.
//  Copyright © 2020 안재영. All rights reserved.
//

import Firebase
import RxCocoa
import RxSwift
import UIKit

class DescriptionViewController: BaseViewController {
  
  let lblTitle = UILabel().then {
    $0.font = Font.Avenir.bold(size: 40)
    $0.text = "New Task"
  }
  
  let txtTaskTitle = UITextField().then {
    $0.font = Font.Avenir.demiBold(size: 30)
    $0.textColor = .lightGray
    $0.borderStyle = .none
    $0.placeholder = "Title"
  }
  
  let btnDismiss = UIButton().then {
    $0.setImage(SFSymbols.cancel, for: .normal)
  }
  
  let subViewForDate = UIView().then {
    $0.layer.borderColor = UIColor.darkGray.cgColor
    $0.layer.borderWidth = 0.3
    $0.backgroundColor = .white
  }
  
  let btnSelectDate = UIButton().then {
    $0.setImage(SFSymbols.calendar, for: .normal)
    $0.tintColor = .black
  }
  
  let lblDate = UILabel().then {
    $0.font = Font.Avenir.demiBold(size: 25)
    $0.textColor = .lightGray
    $0.text = "Due Date"
  }
  
  let lblSelectedDate = UILabel().then {
    $0.font = Font.Helvetica.medium(size: 17)
  }
  
  let subViewForStartTime = UIView().then {
    $0.layer.borderColor = UIColor.darkGray.cgColor
    $0.layer.borderWidth = 0.3
    $0.backgroundColor = .white
  }
  
  let btnSelectStartTime = UIButton().then {
    $0.setImage(SFSymbols.clock, for: .normal)
    $0.tintColor = .black
  }
  
  let lblStartTime = UILabel().then {
    $0.font = Font.Avenir.demiBold(size: 25)
    $0.textColor = .lightGray
    $0.text = "Start Time"
  }
  
  let lblSelectedStartTime = UILabel().then {
    $0.font = Font.Helvetica.medium(size: 17)
    $0.textColor = .black
  }
  
  let subViewForEndTime = UIView().then {
    $0.layer.borderColor = UIColor.darkGray.cgColor
    $0.layer.borderWidth = 0.3
    $0.backgroundColor = .white
  }
  
  let btnSelectEndTime = UIButton().then {
    $0.setImage(SFSymbols.clockFill, for: .normal)
    $0.tintColor = .black
  }
  
  let lblEndTime = UILabel().then {
    $0.font = Font.Avenir.demiBold(size: 25)
    $0.textColor = .lightGray
    $0.text = "End Time"
  }
  
  let lblSelectedEndTime = UILabel().then {
    $0.font = Font.Helvetica.medium(size: 17)
  }
  
  let subViewForDescription = UIView().then {
    $0.layer.borderColor = UIColor.darkGray.cgColor
    $0.layer.borderWidth = 0.3
    $0.backgroundColor = .white
  }
  
  let imgDescription = UIImageView().then {
    $0.image = SFSymbols.pencil
    $0.tintColor = .black
  }
  
  let lblDescriptionion = UILabel().then {
    $0.font = Font.Avenir.demiBold(size: 25)
    $0.textColor = .lightGray
    $0.text = "Description"
  }
  
  let txtViewDescription = UITextView().then {
    $0.font = Font.Helvetica.medium(size: 18)
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 0.3
  }
  
  let btnAdd = UIButton().then {
    $0.titleLabel?.font = Font.Avenir.bold(size: 23)
    $0.setTitleColor(.white, for: .normal)
    $0.setTitle("Add task", for: .normal)
    $0.layer.shadowOffset = CGSize(width: 0, height: 3)
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowRadius = 5
  }
  
  let category = PublishRelay<String>()
  
  let viewModel: DescriptionViewModel
  
  init(viewModel: DescriptionViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dismissKeyboardOnTap()
    
    txtTaskTitle.delegate = self
    txtViewDescription.delegate = self
  }
  
  override func addSubview() {
    [lblTitle, txtTaskTitle, btnDismiss, btnAdd, subViewForDate, btnSelectDate, lblDate, lblSelectedDate, subViewForStartTime, btnSelectStartTime, lblStartTime, lblSelectedStartTime, subViewForEndTime, btnSelectEndTime, lblEndTime, lblSelectedEndTime, subViewForDescription, imgDescription, lblDescriptionion, txtViewDescription].forEach { self.view.addSubview($0) }
  }
  
  override func setConstraints() {
    lblTitle.snp.makeConstraints {
      $0.top.greaterThanOrEqualToSuperview().offset(20)
      $0.top.lessThanOrEqualToSuperview().offset(80)
      $0.left.equalToSuperview().offset(30)
    }
    
    txtTaskTitle.snp.makeConstraints {
      $0.top.equalTo(lblTitle.snp.bottom).offset(15)
      $0.left.equalToSuperview().offset(35)
    }
    
    btnDismiss.snp.makeConstraints {
      $0.top.equalTo(lblTitle)
      $0.right.equalToSuperview().offset(-25)
      $0.width.height.equalTo(60)
    }
    
    subViewForDate.snp.makeConstraints {
      $0.top.equalTo(txtTaskTitle.snp.bottom).offset(30)
      $0.left.equalToSuperview().offset(20)
      $0.right.equalToSuperview().offset(-20)
      $0.height.equalTo(60)
    }
    
    btnSelectDate.snp.makeConstraints {
      $0.centerY.equalTo(subViewForDate)
      $0.left.equalTo(subViewForDate.snp.left).offset(20)
    }
    
    lblDate.snp.makeConstraints {
      $0.centerY.equalTo(subViewForDate)
      $0.left.equalTo(btnSelectDate.snp.right).offset(28)
    }
    
    lblSelectedDate.snp.makeConstraints {
      $0.centerY.equalTo(subViewForDate)
      $0.right.equalTo(subViewForDate.snp.right).offset(-20)
    }
    
    subViewForStartTime.snp.makeConstraints {
      $0.top.equalTo(subViewForDate.snp.bottom).offset(20)
      $0.left.equalToSuperview().offset(20)
      $0.right.equalToSuperview().offset(-20)
      $0.height.equalTo(60)
    }
    
    btnSelectStartTime.snp.makeConstraints {
      $0.centerY.equalTo(subViewForStartTime)
      $0.left.equalTo(subViewForStartTime.snp.left).offset(23)
    }
    
    lblStartTime.snp.makeConstraints {
      $0.centerY.equalTo(subViewForStartTime)
      $0.left.equalTo(btnSelectStartTime.snp.right).offset(30)
    }
    
    lblSelectedStartTime.snp.makeConstraints {
      $0.centerY.equalTo(subViewForStartTime)
      $0.right.equalTo(subViewForStartTime.snp.right).offset(-20)
    }
    
    subViewForEndTime.snp.makeConstraints {
      $0.top.equalTo(subViewForStartTime.snp.bottom).offset(20)
      $0.left.equalToSuperview().offset(20)
      $0.right.equalToSuperview().offset(-20)
      $0.height.equalTo(60)
    }
    
    btnSelectEndTime.snp.makeConstraints {
      $0.centerY.equalTo(subViewForEndTime)
      $0.left.equalTo(subViewForEndTime.snp.left).offset(23)
    }
    
    lblEndTime.snp.makeConstraints {
      $0.centerY.equalTo(subViewForEndTime)
      $0.left.equalTo(btnSelectEndTime.snp.right).offset(30)
    }
    
    lblSelectedEndTime.snp.makeConstraints {
      $0.centerY.equalTo(subViewForEndTime)
      $0.right.equalTo(subViewForEndTime.snp.right).offset(-20)
    }
    
    subViewForDescription.snp.makeConstraints {
      $0.top.equalTo(subViewForEndTime.snp.bottom).offset(20)
      $0.left.equalToSuperview().offset(20)
      $0.right.equalToSuperview().offset(-20)
      $0.height.greaterThanOrEqualTo(150)
      $0.height.lessThanOrEqualTo(200)
    }
    
    imgDescription.snp.makeConstraints {
      $0.top.equalTo(subViewForDescription.snp.top).offset(20)
      $0.left.equalTo(subViewForDescription.snp.left).offset(20)
    }
    
    lblDescriptionion.snp.makeConstraints {
      $0.top.equalTo(imgDescription.snp.top).offset(-3)
      $0.left.equalTo(imgDescription.snp.right).offset(30)
    }
    
    txtViewDescription.snp.makeConstraints {
      $0.top.equalTo(imgDescription.snp.bottom).offset(20)
      $0.left.equalTo(subViewForDescription.snp.left).offset(20)
      $0.right.equalTo(subViewForDescription.snp.right).offset(-20)
      $0.bottom.equalTo(subViewForDescription.snp.bottom).offset(-20)
    }
    
    btnAdd.snp.makeConstraints {
      $0.top.equalTo(subViewForDescription.snp.bottom).offset(20)
      $0.left.equalToSuperview().offset(20)
      $0.right.equalToSuperview().offset(-20)
      $0.height.equalTo(55)
      $0.bottom.lessThanOrEqualToSuperview().offset(-20)
    }    
  }
  
  override func binding() {
    category
      .asObservable()
      .bind(to: viewModel.input.category)
      .disposed(by: disposeBag)
    
    txtViewDescription.rx.text.orEmpty
      .distinctUntilChanged()
      .bind(to: viewModel.input.description)
      .disposed(by: disposeBag)
    
    txtTaskTitle.rx.text.orEmpty
      .distinctUntilChanged()
      .bind(to: viewModel.input.title)
      .disposed(by: disposeBag)
    
    btnAdd.rx.tap
      .bind(to: viewModel.input.addButtonTapped)
      .disposed(by: disposeBag)
    
    btnDismiss.rx.tap
      .bind(onNext: {
        self.dismiss(animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
    
    btnSelectDate.rx.tap
      .bind(onNext: {
        SCLAlert.presentDatePicker() { date in
          self.viewModel.input.date.accept(date)
          self.lblSelectedDate.text = date
        }
      })
      .disposed(by: disposeBag)
    
    btnSelectStartTime.rx.tap
      .bind(onNext: {
        SCLAlert.presentTimePicker() { time in
          self.viewModel.input.startTime.accept(time)
          self.lblSelectedStartTime.text = time
        }
      })
      .disposed(by: disposeBag)

    btnSelectEndTime.rx.tap
      .bind(onNext: {
        SCLAlert.presentTimePicker() { time in
          self.viewModel.input.endTime.accept(time)
          self.lblSelectedEndTime.text = time
        }
      })
      .disposed(by: disposeBag)
    
    viewModel.output.validateResult
      .subscribe(onNext: {
        self.btnAdd.setEnabledState($0)
      })
      .disposed(by: disposeBag)
    
    viewModel.output.addResult
      .subscribe(onNext: { result in
        switch result {
        case .success:
          guard let presentingViewController = self.presentingViewController else { return }
          self.dismiss(animated: true, completion: {
            presentingViewController.dismiss(animated: true, completion: nil)
          })
          SCLAlert.present(title: "SUCCESS", subTitle: "Success to add task", style: .success)
        case .notice(let message):
          SCLAlert.present(title: "INFO", subTitle: message.description, style: .info)
        case .failure(let error):
          AuthErrorCode.show(error)
        }
      })
      .disposed(by: disposeBag)
  }
}

extension DescriptionViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text else { return true }
    let newLength = text.count + string.count - range.length
    return newLength <= 25
  }
}

extension DescriptionViewController: UITextViewDelegate {
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    guard let texts = textView.text else { return true }
    let newLength = texts.count + text.count - range.length
    return newLength <= 100
  }
}

extension DescriptionViewController: KeyboardObserverProtocol {
  override func viewWillAppear(_ animated: Bool) {
    register(for: txtViewDescription)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    remove()
  }
}
