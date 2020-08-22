//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by 안재영 on 2020/07/18.
//  Copyright © 2020 안재영. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class CategoryViewController: BaseViewController {
  
  struct Item {
    static let size = CGSize(width: UIScreen.main.bounds.width / 1.15, height: UIScreen.main.bounds.height / 5)
  }
  
  let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
    $0.register(CategorysCell.self, forCellWithReuseIdentifier: "CategorysCell")
    $0.backgroundColor = .white
  }
  
  let layout = UICollectionViewFlowLayout().then {
    $0.itemSize = Item.size
  }
  
  let lblTitle = UILabel().then {
    $0.font = Font.Avenir.bold(size: 40)
    $0.text = "New Task"
  }
  
  let lblSubTitle = UILabel().then {
    $0.font = Font.Avenir.demiBold(size: 30)
    $0.textColor = .lightGray
    $0.text = "Category"
  }
  
  let btnDismiss = UIButton().then {
    $0.setImage(SFSymbols.cancel, for: .normal)
  }
  
  var category: [String] {
    return Category.allCases.map { $0.rawValue }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.collectionViewLayout = layout
  }
  
  override func addSubview() {
    [lblTitle, lblSubTitle, btnDismiss, collectionView].forEach { view.addSubview($0) }
  }
  
  override func setConstraints() {
    lblTitle.snp.makeConstraints {
      $0.top.equalToSuperview().offset(80)
      $0.left.equalToSuperview().offset(30)
    }
    
    lblSubTitle.snp.makeConstraints {
      $0.top.equalTo(lblTitle.snp.bottom).offset(5)
      $0.left.equalToSuperview().offset(30)
    }
    
    btnDismiss.snp.makeConstraints {
      $0.top.equalToSuperview().offset(77)
      $0.right.equalToSuperview().offset(-25)
      $0.width.height.equalTo(60)
    }
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(lblSubTitle.snp.bottom).offset(30)
      $0.left.equalToSuperview().offset(20)
      $0.right.equalToSuperview().offset(-20)
      $0.bottom.equalToSuperview().offset(-50)
    }
  }
  
  override func binding() {
    Observable.just(category)
      .bind(to: collectionView.rx.items(cellIdentifier: "CategorysCell", cellType: CategorysCell.self)) { row, category, cell in
        cell.configure(category: category) }
      .disposed(by: disposeBag)
    
    btnDismiss.rx.tap
      .bind(onNext: {
        self.dismiss(animated: true, completion: nil)
      })
      .disposed(by: disposeBag)
    
    collectionView.rx.itemSelected
      .map { self.category[$0.row] }
      .bind(onNext: { category in
        let dependency = DescriptionViewModel.Dependency(taskService: TaskService())
        let viewModel = DescriptionViewModel(dependency: dependency)
        let viewController = DescriptionViewController(viewModel: viewModel)
        self.present(viewController, animated: true, completion: {
          viewController.category.accept(category)
        })
      })
      .disposed(by: disposeBag)
  }
}
