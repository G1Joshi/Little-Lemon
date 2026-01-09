//
//  MapLocationView.swift
//  Little Lemon
//
//  Created by Jeevan Chandra Joshi on 25/11/25.
//

import MapKit
import SwiftUI

struct MapLocationView: View {
    @Environment(Model.self) var model
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        )
    )

    let restaurantCoordinates: [String: CLLocationCoordinate2D] = [
        "Las Vegas": CLLocationCoordinate2D(latitude: 36.1699, longitude: -115.1398),
        "Los Angeles": CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),
        "San Francisco": CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        "Nevada": CLLocationCoordinate2D(latitude: 39.5296, longitude: -119.8138),
    ]

    var body: some View {
        VStack(spacing: 0) {
            LittleLemonBanner(size: 80)
                .padding(20)

            Map(position: $cameraPosition) {
                ForEach(mapAnnotations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "fork.knife.circle.fill")
                                .font(.title)
                                .foregroundColor(LittleLemonTheme.primaryGreen)
                                .background(
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 35, height: 35)
                                )

                            Text(location.name)
                                .font(.caption)
                                .padding(4)
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(4)
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(model.restaurants, id: \.self) { restaurant in
                        RestaurantMapCard(restaurant: restaurant) {
                            if let coordinate = restaurantCoordinates[restaurant.city] {
                                withAnimation {
                                    cameraPosition = .region(
                                        MKCoordinateRegion(
                                            center: coordinate,
                                            span: MKCoordinateSpan(
                                                latitudeDelta: 0.1, longitudeDelta: 0.1
                                            )
                                        )
                                    )
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color.white.opacity(0.95))
        }
    }

    var mapAnnotations: [MapLocation] {
        var annotations: [MapLocation] = []
        var cityCount: [String: Int] = [:]

        for restaurant in model.restaurants {
            if let baseCoordinate = restaurantCoordinates[restaurant.city] {
                let count = cityCount[restaurant.city, default: 0]
                cityCount[restaurant.city] = count + 1

                let offset = Double(count) * 0.01
                let coordinate = CLLocationCoordinate2D(
                    latitude: baseCoordinate.latitude + offset,
                    longitude: baseCoordinate.longitude + offset
                )

                annotations.append(
                    MapLocation(
                        name: restaurant.neighborhood,
                        coordinate: coordinate
                    ))
            }
        }

        return annotations
    }
}

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct RestaurantMapCard: View {
    let restaurant: RestaurantLocation
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(LittleLemonTheme.primaryGreen)
                        .font(.title2)

                    VStack(alignment: .leading) {
                        Text(restaurant.city)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(restaurant.neighborhood)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }

                HStack(spacing: 3) {
                    ForEach(0 ..< 5) { index in
                        Image(systemName: index < Int(restaurant.rating) ? "star.fill" : "star")
                            .font(.caption2)
                            .foregroundColor(LittleLemonTheme.primaryYellow)
                    }
                }
            }
            .padding()
            .frame(width: 200)
            .cardStyle()
        }
    }
}

#Preview {
    MapLocationView()
        .environment(Model())
}
