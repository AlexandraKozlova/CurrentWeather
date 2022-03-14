//
//  SearchVC.swift
//  Current weather
//
//  Created by Aleksandra on 09.03.2022.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoView = UIImageView()
    let searchTextField = CWTextField()
    let searchButton = CWButton(title: "Search", backgroundColor: .systemTeal)
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
    var networkingManager = NetworkingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        view.backgroundColor = .white
        configureLogoView()
        configureTextField()
        configureSearchButton()
        createDismissKeyboardTapGesture()
        configureScrollView()
        configureKeyboard()
        
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 700)
        ])
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: contentView, action: #selector(UIView.endEditing))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc func searchButtonTapped() {
        guard let cityName = searchTextField.text else { return }
        if cityName != "" {
            let city = cityName.split(separator: " ").joined(separator: "%20")
            showLoadingView()
            networkingManager.fetchCurrentWeather(forCity: city) { result in
                DispatchQueue.main.async {
                    self.dissmisLoadingView()
                    switch result {
                    case .success(let currentWeather):
                        let resultVC = ResultVC(currentWeather: currentWeather)
                        self.present(resultVC, animated: true)
                    case.failure(let error):
                        self.presentAlert(withTitle: "Something went wrong", message: error.rawValue, actionTitle: "Okay")
                    }
                }
            }
        } else {
            self.presentAlert(withTitle: "You need to select a city", message: "Please enter the city.", actionTitle: "Okay")
        }
    }
    
    
    
    private func configureLogoView() {
        contentView.addSubview(logoView)
        logoView.image = UIImage(named: "logo")
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            logoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 330),
            logoView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureTextField() {
        contentView.addSubview(searchTextField)

        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: logoView.bottomAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            searchTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSearchButton() {
        contentView.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 40),
            searchButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureKeyboard() {
        subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
    }
}


extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonTapped()
        return true
    }
}


extension SearchVC {
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
           NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
       }
    
    func unsubscribeFromAllNotifications() {
            NotificationCenter.default.removeObserver(self)
        }
    
    @objc func keyboardWillShowOrHide(notification: NSNotification) {
           if let userInfo = notification.userInfo,
              let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey],
              let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey],
              let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] {
               
            let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)
               let keyboardOverlap = scrollView.frame.maxY - endRect.origin.y
               
               scrollView.contentInset.bottom = keyboardOverlap
               scrollView.verticalScrollIndicatorInsets.bottom = keyboardOverlap
               
               let duration = (durationValue as AnyObject).doubleValue
                          let options = UIView.AnimationOptions(rawValue: UInt((curveValue as AnyObject).integerValue << 16))
                          UIView.animate(withDuration: duration!, delay: 0, options: options, animations: {
                              self.view.layoutIfNeeded()
                          }, completion: nil)
           }
    }
}

