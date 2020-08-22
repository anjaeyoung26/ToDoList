//
//  TodoListViewController.swift
//  ToDoList
//
//  Created by 안재영 on 2020/06/25.
//  Copyright © 2020 안재영. All rights reserved.
//

import Firebase
import FSCalendar
import RxSwift
import RxCocoa
import UIKit

class ToDoListViewController: BaseViewController {
  
  struct Item {
    static let size = CGSize(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 5)
  }
  
  let calendar = FSCalendar(scope: .week).then {
    $0.appearance.headerDateFormat = .none
  }
  
  let lblTodayTasks = UILabel().then {
    $0.font = Font.Helvetica.bold(size: 22)
    $0.text = "Today Tasks"
  }
  
  let lblAllTasks = UILabel().then {
    $0.font = Font.Helvetica.bold(size: 22)
    $0.text = "All Tasks"
  }
  
  let btnSignOut = UIButton().then {
    $0.setImage(SFSymbols.signOut, for: .normal)
  }
  
  let btnAddTask = UIButton().then {
    $0.setImage(SFSymbols.add, for: .normal)
  }
  
  let subView = UIView().then {
    $0.backgroundColor = Color.fordWhite
  }
  
  let tableView = UITableView().then {
    $0.register(AllTasksCell.self, forCellReuseIdentifier: "AllTasksCell")
    $0.backgroundColor = Color.fordWhite
    $0.separatorStyle = .none
  }
  
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
    $0.register(TodayTasksCell.self, forCellWithReuseIdentifier: "TodayTasksCell")
    $0.backgroundColor = Color.fordWhite
  }
  
  let layout = UICollectionViewFlowLayout().then {
    $0.itemSize = Item.size
    $0.scrollDirection = .horizontal
  }
  
  let viewModel: ToDoListViewModel
  
  var tasks = [Task]()
  
  init(viewModel: ToDoListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    
    self.rx.viewDidLoad
      .subscribe(onNext: {
        guard let today = self.calendar.today else { return }
        self.viewModel.input.date.accept(today)
      })
      .disposed(by: disposeBag)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Color.fordWhite
    
    collectionView.collectionViewLayout = layout
    calendar.delegate = self
  }
  
  override func addSubview() {
    [subView, calendar, collectionView, tableView, lblAllTasks, lblTodayTasks, btnAddTask, btnSignOut].forEach { view.addSubview($0) }
  }
  
  override func setConstraints() {
    btnAddTask.snp.makeConstraints { make in
      make.bottom.equalTo(calendar.snp.top).offset(28)
      make.right.equalTo(btnSignOut.snp.left).offset(-15)
    }
    
    btnSignOut.snp.makeConstraints { make in
      make.bottom.equalTo(calendar.snp.top).offset(28)
      make.right.equalToSuperview().offset(-30)
    }
    
    subView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(-20)
      make.left.equalToSuperview()
      make.right.equalToSuperview()
      make.bottom.equalTo(calendar.snp.top).offset(150)
    }

    calendar.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(50)
      make.left.equalToSuperview().offset(20)
      make.right.equalToSuperview().offset(-20)
      make.height.equalTo(view.frame.height / 2)
    }
    
    lblTodayTasks.snp.makeConstraints { make in
      make.top.equalTo(subView.snp.bottom).offset(20)
      make.left.equalToSuperview().offset(25)
    }
    
    collectionView.snp.makeConstraints { make in
      make.top.equalTo(lblTodayTasks.snp.bottom).inset(15)
      make.left.equalToSuperview().offset(25)
      make.right.equalToSuperview().offset(-25)
      make.height.equalTo(view.frame.height / 3.5)
    }
    
    lblAllTasks.snp.makeConstraints { make in
      make.top.equalTo(collectionView.snp.bottom).inset(17)
      make.left.equalToSuperview().offset(25)
    }
    
    tableView.snp.makeConstraints { make in
      make.top.equalTo(lblAllTasks.snp.bottom).offset(25)
      make.left.equalToSuperview().offset(25)
      make.right.equalToSuperview().offset(-25)
      make.bottom.equalToSuperview().offset(-15)
    }
  }
  
  override func binding() {
    tableView.rx
      .setDelegate(self)
      .disposed(by: disposeBag)
    
    tableView.rx.itemSelected
      .bind(onNext: {
        self.toggleCell(indexPath: $0)
      })
      .disposed(by: disposeBag)
    
    btnAddTask.rx.tap
      .bind(onNext: {
        let viewController = CategoryViewController()
        self.present(viewController, animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
    
    btnSignOut.rx.tap
      .bind(onNext: {
        SCLAlert.present(target: self, title: "Do you want to Sign Out?", subTitle: "",
                         FirstbuttonText: "Yes", FirstbuttonSelector: #selector(self.signOut),
                         SecondbuttonText: "No", SecondbuttonSelector: #selector(self.justReturn), style: .question)
      })
      .disposed(by: disposeBag)
    
    viewModel.output.userTasks
      .do(onNext: { self.tasks = $0 })
      .bind(to: tableView.rx.items(cellIdentifier: "AllTasksCell", cellType: AllTasksCell.self)) { row, element, cell in
        cell.configure(with: element) }
      .disposed(by: disposeBag)
    
    
    viewModel.output.userTasksByDate
      .bind(to: collectionView.rx.items(cellIdentifier: "TodayTasksCell", cellType: TodayTasksCell.self)) { row, element, cell in
        cell.configure(with: element) }
      .disposed(by: disposeBag)
    
    viewModel.output.signOutResult
      .subscribe(onNext: { result in
        switch result {
        case .success:
          self.dismiss(animated: true, completion: {
            SCLAlert.present(title: "SUCCESS", subTitle: "Sign out succeeded", style: .success)
          })
        case .notice(let message):
          SCLAlert.present(title: "INFO", subTitle: message.description, style: .info)
        case .failure(let error):
          AuthErrorCode.show(error)
        }
      })
      .disposed(by: disposeBag)
  }
  
  func toggleCell(indexPath: IndexPath) {
    let task = tasks[indexPath.row]
    task.isExpanded = !task.isExpanded
    self.tableView.beginUpdates()
    self.tableView.reloadRows(at: [indexPath], with: .automatic)
    self.tableView.endUpdates()
  }
  
  @objc
  func signOut() {
    guard let user = Auth.auth().currentUser else { return }
    self.viewModel.input.signOut.accept(user)
  }
  
  @objc
  func justReturn() {
    return
  }
}

extension ToDoListViewController: FSCalendarDelegate {
  func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    viewModel.input.date.accept(date)
  }
}

extension ToDoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let task = tasks[indexPath.row]
    return task.isExpanded ? 170 : 100
  }

  func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    let task = tasks[indexPath.row]
    
    let complete = UIAction(title: "Complete", image: SFSymbols.checkMark) { _ in
      self.viewModel.input.complete.accept(task)
    }
    
    let delete = UIAction(title: "Delete", image: SFSymbols.trash, attributes: [.destructive]) { _ in
      self.viewModel.input.delete.accept(task)
    }

    return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
      UIMenu(title: "", children: [complete, delete])
    }
  }
}


