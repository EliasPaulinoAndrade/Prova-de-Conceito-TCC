//
//  AppDelegate.swift
//  TCCPoc
//
//  Created by Elias Paulino on 14/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let section1ViewModel = CardListViewModel(id: "ddwd", title: "Aprenda quanto e onde quiser", events: [
            .init(
                id: UUID().uuidString,
                title: "CocoaHeads Fortaleza",
                author: "Por Organização CocoaHeads Fortaleza",
                imageData: UIImage(named: "cocoaHeads")?.pngData() ?? Data()
            ),
            .init(
                id: UUID().uuidString,
                title: "Terror Clássico - Edição Lovecraft",
                author: "Por Marie Bach",
                imageData: UIImage(named: "lovecraft")?.pngData() ?? Data()),
            .init(
                id: UUID().uuidString,
                title: "As Três Marias",
                author: "Por Cia Cordel Encantado",
                imageData: UIImage(named: "threeMaria")?.pngData() ?? Data()
            )
        ])
        
        let section2ViewModel = CardListViewModel(id: "ddwd3", title: "Achamos que você também vai gostar", events: [
            .init(
                id: UUID().uuidString,
                title: "CocoaHeads Fortaleza",
                author: "Por Organização CocoaHeads Fortaleza",
                imageData: UIImage(named: "cocoaHeads")?.pngData() ?? Data()
            ),
            .init(
                id: UUID().uuidString,
                title: "Terror Clássico - Edição Lovecraft",
                author: "Por Marie Bach",
                imageData: UIImage(named: "lovecraft")?.pngData() ?? Data()),
            .init(
                id: UUID().uuidString,
                title: "As Três Marias",
                author: "Por Cia Cordel Encantado",
                imageData: UIImage(named: "threeMaria")?.pngData() ?? Data()
            )
        ])
        
        let section3ViewModel = CardListViewModel(id: "ddwd4", title: "Achamos que você também vai gostar", events: [
            .init(
                id: UUID().uuidString,
                title: "CocoaHeads Fortaleza",
                author: "Por Organização CocoaHeads Fortaleza",
                imageData: UIImage(named: "cocoaHeads")?.pngData() ?? Data()
            ),
            .init(
                id: UUID().uuidString,
                title: "Terror Clássico - Edição Lovecraft",
                author: "Por Marie Bach",
                imageData: UIImage(named: "lovecraft")?.pngData() ?? Data()),
            .init(
                id: UUID().uuidString,
                title: "As Três Marias",
                author: "Por Cia Cordel Encantado",
                imageData: UIImage(named: "threeMaria")?.pngData() ?? Data()
            )
        ])
        
        let viewModel = HomeViewModel(lists: [section1ViewModel, section2ViewModel, section3ViewModel])
        let viewController = HomeViewController(viewModel: viewModel)
        viewModel.viewable = viewController
    
        window?.rootViewController = UINavigationController(rootViewController: viewController).set {
            $0.navigationBar.prefersLargeTitles = true
        }
        window?.makeKeyAndVisible()
        
        return true
    }
}
