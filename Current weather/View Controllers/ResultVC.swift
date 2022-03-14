//
//  ResultVC.swift
//  Current weather
//
//  Created by Aleksandra on 09.03.2022.
//

import UIKit

class ResultVC: UIViewController {
    
    var currentWeather: CurrentWeather?
    var networkingManager = NetworkingManager()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let weatherIconImage = UIImageView()
    let cityNameLabel = CWTitleLabel(textAlignment: .center, fontSize: 40, textColor: .systemTeal)
    let temperatureLabel = CWTitleLabel(textAlignment: .center, fontSize: 35, textColor: .systemGray)
    let feelsLikeLabel = CWTitleLabel(textAlignment: .center, fontSize: 25, textColor: .systemGray)
    let weatherDescriptionLabel = CWTitleLabel(textAlignment: .left, fontSize: 25, textColor: .systemGray)
    let pressureLabel = CWBodyLabel()
    let humidityLabel = CWBodyLabel()
    let windSpeedLabel = CWBodyLabel()
    let cancelButton = CWButton(title: "Сhoose another city", backgroundColor: .systemTeal)
    
    init(currentWeather: CurrentWeather) {
        super.init(nibName: nil, bundle: nil)
        self.currentWeather = currentWeather
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureWeatherIconImage()
        configurecityNameLabel()
        configureTemperatureLabel()
        configureFeelsLikeLabel()
        configureWeatherDescriptionLabel()
        configurePressureLabel()
        configureHumidityLabel()
        configureWindSpeedLabel()
        configureCancelButton()
        configureScrollView()
        updateInterface()
    }
    
    private func updateInterface() {
        guard let currentWeather = self.currentWeather else { return }
        self.weatherDescriptionLabel.text = currentWeather.weatherDescription
        self.feelsLikeLabel.text = currentWeather.feelsLikeTemperatureString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.humidityLabel.text = currentWeather.humidityString
        self.pressureLabel.text = currentWeather.pressureString
        self.windSpeedLabel.text = currentWeather.windSpeedString
        self.cityNameLabel.text = currentWeather.cityName
        self.weatherIconImage.image = UIImage(named: currentWeather.systemNameIconWeather)
        
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

    private func configurecityNameLabel() {
        contentView.addSubview(cityNameLabel)
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cityNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
   private func configureWeatherIconImage() {
        contentView.addSubview(weatherIconImage)
        weatherIconImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            weatherIconImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 110),
            weatherIconImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIconImage.heightAnchor.constraint(equalToConstant: 170),
            weatherIconImage.widthAnchor.constraint(equalToConstant: 185)
        ])
    }
    
    private func configureTemperatureLabel() {
        contentView.addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: weatherIconImage.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 300),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureFeelsLikeLabel() {
        contentView.addSubview(feelsLikeLabel)
        
        NSLayoutConstraint.activate([
            feelsLikeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 15),
            feelsLikeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            feelsLikeLabel.widthAnchor.constraint(equalToConstant: 300),
            feelsLikeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configureWeatherDescriptionLabel() {
        contentView.addSubview(weatherDescriptionLabel)
        
        NSLayoutConstraint.activate([
            weatherDescriptionLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 35),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            weatherDescriptionLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configurePressureLabel() {
        contentView.addSubview(pressureLabel)
        
        NSLayoutConstraint.activate([
            pressureLabel.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: 15),
            pressureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            pressureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            pressureLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func configureHumidityLabel() {
        contentView.addSubview(humidityLabel)
        
        NSLayoutConstraint.activate([
            humidityLabel.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: 15),
            humidityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            humidityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            humidityLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func configureWindSpeedLabel() {
        contentView.addSubview(windSpeedLabel)
        
        NSLayoutConstraint.activate([
            windSpeedLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 15),
            windSpeedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            windSpeedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            windSpeedLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        }
    private func configureCancelButton() {
        contentView.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 50),
            cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            cancelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            cancelButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func dismissVC() { dismiss(animated: true) }
}






