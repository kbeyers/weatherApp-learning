//
//  ContentView.swift
//  WeatherApp
//
//  Created by Kyle Beyers on 16/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight: Bool = false
    
    private var viewModels: [WeatherRailViewModel] = []
    
    init() {
        configureWeatherRail()
    }
    
    private mutating func configureWeatherRail() {
        
        self.viewModels = [WeatherRailViewModel(day: "TUE", imageName: "cloud.sun.fill", temperature: 74),
                           WeatherRailViewModel(day: "WED", imageName: "sun.max.fill", temperature: 88),
                           WeatherRailViewModel(day: "THU", imageName: "wind", temperature: 55),
                           WeatherRailViewModel(day: "FRI", imageName: "sunset.fill", temperature: 60),
                           WeatherRailViewModel(day: "SAT", imageName: "moon.stars.fill", temperature: 59)]
    }
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            VStack {
                CityTextView(cityName: "Cupertino, CA")
                
                VStack(spacing: 8) {
                    MainWeatherStatusView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill",
                                          temperature: 76)
                }
                .padding(.bottom, 40)
                
                HStack(spacing: 20) {
                    ForEach(viewModels) { viewModel in
                        WeatherDayView(dayOfWeek: viewModel.day,
                                       imageName: viewModel.imageName,
                                       temperature: viewModel.temperature)
                    }
                }
                
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time",
                                  textColor: .white,
                                  backgroundColor: .mint)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherRailViewModel: Identifiable {
    var id: String { day }
    var day: String
    var imageName: String
    var temperature: Int
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 2) {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    
    var isNight: Bool
    
    var body: some View {
//        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
//                       startPoint: .topLeading,
//                       endPoint: .bottomTrailing)
//        .ignoresSafeArea(.all)
        
        ContainerRelativeShape()
            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
            .ignoresSafeArea(.all)
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        Image(systemName: imageName)
            .symbolRenderingMode(.multicolor)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 180, height: 180)
        
        Text("\(temperature)°")
            .font(.system(size: 70, weight: .medium))
            .foregroundColor(.white)
    }
}
