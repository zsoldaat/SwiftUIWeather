//
//  ContentView.swift
//  SwiftUIWeatherApp
//
//  Created by Zac Soldaat on 2020-09-09.
//  Copyright © 2020 Zac Soldaat. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var weatherVM: WeatherVM
    
    init() {
        self.weatherVM = WeatherVM()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button(action: {
                        self.weatherVM.fetchWeather(location: true)
                    }) {
                        Image(systemName: "location.circle.fill").resizable()
                            .frame(width: 30, height: 30)
                    }.buttonStyle(PlainButtonStyle())
                    TextField("Search", text: self.$weatherVM.searchText)
                        .onTapGesture {
                            self.weatherVM.searchText = ""
                        }
                    Button(action: {
                        self.weatherVM.fetchWeather(location: false)
                    }) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 30, height: 30)
                    }.buttonStyle(PlainButtonStyle())
                }
                .padding()
                HStack {
                    Spacer()
                    Image(systemName: self.weatherVM.conditionString)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .animation(.default)
                }
                .padding(.horizontal)
                HStack {
                    Spacer()
                    Text(self.weatherVM.temperature)
                        .animation(.spring(response: 0.0, dampingFraction:1))
                    Button(action: {

                        self.weatherVM.unitsInMetric.toggle()
                        self.weatherVM.fetchWeather()
                        
                    }) {
                        Text(self.weatherVM.unitsInMetric ? "°C" : "°F")
                    }
                    .buttonStyle(PlainButtonStyle())
                }.font(.system(size: 80))
                    .padding(.horizontal)
                HStack {
                    Spacer()
                    Text(self.weatherVM.cityName)
                        .font(.system(size: 40))
                }
                .padding(.horizontal)
                Spacer()
            }.background(Image("background")
                .resizable()
                .offset(x: -geometry.size.width/3, y: 0)
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
