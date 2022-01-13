//
//  SceneDelegate.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    
    let dependencies = EventsListModuleFactoryDependencies(interactorFactory: EventsListInteractorModuleFactory())
    let view = EventsListModuleFactory(dependencies: dependencies).makeView()
    let navigationController = UINavigationController(rootViewController: view)
    
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {}
  
  func sceneDidBecomeActive(_ scene: UIScene) {}
  
  func sceneWillResignActive(_ scene: UIScene) {}
  
  func sceneWillEnterForeground(_ scene: UIScene) {}
  
  func sceneDidEnterBackground(_ scene: UIScene) {}
}

// MARK: - EventsListModuleFactoryDependenciesProtocol

private struct EventsListModuleFactoryDependencies: EventsListModuleFactoryDependenciesProtocol {
  var interactorFactory: EventsListInteractorModuleFactoryProtocol
}

