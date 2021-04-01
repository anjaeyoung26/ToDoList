# __ToDoList__

![Swift](http://img.shields.io/badge/Swift-5.2-orange.svg)

인원 : 1명   

기간 : 2020.04.16 - 2020.05.07   

## __Screenshot__

<img src="ToDoList/Resource/Screenshots/LoginViewController.png" width="200" height="400"> <img src="ToDoList/Resource/Screenshots/ResetPasswordViewController.png" width="200" height="400"> <img src="ToDoList/Resource/Screenshots/SignUpViewController.png" width="200" height="400">

<img src="ToDoList/Resource/gif/ToDoListViewController.gif" width="200" height="400"> <img src="ToDoList/Resource/Screenshots/CategoryViewController.png" width="200" height="400"> <img src="ToDoList/Resource/Screenshots/DescriptionViewController.png" width="200" height="400">

## __Library__, __SDK__

- [FSCalendar](https://github.com/WenchaoD/FSCalendar)
- [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)
- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [Then](https://github.com/devxoul/Then)
- [SCLAlertView](https://github.com/vikmeup/SCLAlertView-Swift)
- [SnapKit](https://github.com/SnapKit/SnapKit)
- FBSDKLoginKit
- Firebase Auth
- Firebase Realtime Database
- GoogleSignIn

## __Feature__

- MVVM + RxSwift
- 소셜 로그인
- 형식 검사

<img src="ToDoList/Resource/gif/SignUpViewController.gif" width="200" height="400"> <img src="ToDoList/Resource/gif/ResetPasswordViewController.gif" width="200" height="400"> <img src="ToDoList/Resource/gif/DescriptionViewController.gif" width="200" height="400">

- Without Storyboard

## __Requirement__

- iOS 13
- Swift 5

## __Structure__

+ __서비스__

    + TaskService : Task 추가, 완료, 삭제, fetch
    
        &emsp;Firebase Realtime Database를 사용

        ~~~swift
        protocol TaskServiceProtocol {
            func search(about target: Task, key completion: @escaping (String?) -> ())
            func add(_ targetDictionary: [String:Any]) -> Observable<ServiceResult>
            func complete(_ target: Task) -> Observable<Void>
            func delete(_ target: Task) -> Observable<Void>
            func fetch(_ target: Task) -> Observable<Void>
        }
        ~~~

    + AuthService : 회원가입, 로그인, 로그아웃, 비밀번호 재설정

        &emsp;이메일, 페이스북, 구글 세 종류의 로그인 방식

        ~~~swift
        protocol AuthServiceProtocol {
            func signUp(with email: String, _ name: String, _ password: String, _ conformPassword: String) -> Observable<ServiceResult>

            func signInWithEmail(email: String, password: String) -> Observable<ServiceResult>

            func signInWithFacebook(accessToken: AccessToken) -> Observable<ServiceResult>

            func signInWithGoogle(authentication: GIDAuthentication) -> Observable<ServiceResult>

            func sendPasswordResetEmail(email: String) -> Observable<ServiceResult>

            func signOut(providerData: UserInfo) -> Observable<ServiceResult>
        }
        ~~~

+ __모델__   

    &emsp;`ObjectMapper`를 사용해서 JSON을 매핑

    + User

        ~~~swift
        class User: Mappable {
            var name: String?
            var uid: String?

            func mapping(map: Map) {
                name <- map["name"]
                uid <- map["uid]
            }
        }
        ~~~

    + Task

        ~~~swift
        class Task: Mappable {
            var title: String?
            var category: String?
            ...

            func mapping(map: Map) {
                title <- map["title"]
                category <- map["category"]
                ...
            }
        }
        ~~~

+ __뷰 모델__   

    &emsp;Input, Output, Dependency의 구조

    ~~~swift
    protocol ViewModel {
        associatedtype Input
        associatedtype Output
        associatedtype Dependency

        var input: Input { get }
        var output: Output { get }
        var dependency: Dependency { get }
    }
    ~~~

+ __Util__

    + Extension

        + Rx   

            + UIViewController+Rx
            
                뷰 컨트롤러의 라이프 사이클 이벤트를 Rx 방식으로 사용

                ~~~swift
                import RxSwift
                import RxCocoa

                extension Reactive where Base: UIViewController {
                    var viewDidLoad: ControlEvent<Void> {
                        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
                        return ControlEvent(events: source)
                    }
                    
                    var viewDidAppear: ControlEvent<Void> {
                        let source = self.methodInvoked(#selector(Base.viewDidAppear)).map { _ in }
                        return ControlEvent(events: source)
                    }
                }
                ~~~

        + Constant   

            &emsp;프로젝트 내에서 자주 쓰이는 상수들을 정의

        + SCLAlertView  

            &emsp;로그인 과정에서 발생하는 에러를 `SCLAlertView`를 통해 사용자에게 알릴 수 있도록 구현

            ~~~swift
            extension AuthErrorCode {
                static func show(_ error: NSError) {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .networkError :
                        SCLAlert.present(title: "ERROR", subTitle: "Please check your network connection", style: .error)

                    case .userNotFound :
                        SCLAlert.present(title: "ERROR", subTitle: "Your account could not be found.", style: .error)

                            .
                            .
                            .
                    }
                }
            }
            ~~~

            ~~~swift
            extension GIDSignInErrorCode {
                static func show(_ error: NSError) {
                    switch GIDSignInErrorCode(rawValue: error.code) {
                    case .unknown:
                        SCLAlert.present(title: "ERROR", subTitle: "Unknown Error has been occured", style: .error)
                    
                    case .keychain:
                        SCLAlert.present(title: "ERROR", subTitle: "Keychain Error", style: .error)

                            .
                            .
                            .
                    }
                }
            }
            ~~~

    
    + KeyboardObserverProtocol   

        프로토콜을 채택한 뷰 컨트롤러에서 키보드 숨김 / 표시 이벤트에 대한 옵저버를 생성하여 사용자가 텍스트 입력 시 키보드에 의해 뷰가 가려지는 현상을 방지할 수 있도록 구현

        ~~~swift
        protocol KeyboardObserverProtocol {
            func register(for object: AnyObject)
            func register()
            func remove()
        }
        ~~~

        `register(for object: AnyObject)`는 특정 Object만 옵저버의 대상으로 지정하기 위해 구현
        