//
//  ApplicationTabBarViewController.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-04-20.
//

import UIKit

class ApplicationTabBarViewController: CustomTabbarViewController {
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        let sourceListViewController = navigationController(controller: SourceListViewController(),
                                                            selected: R.image.selectedTabbarList(),
                                                            unselected: R.image.unselectedTabbarList(),
                                                            title: R.string.localizable.sourceList())
        
        let favouriteArticlesListViewController = navigationController(controller: FavouriteArticleListViewController(),
                                                                       selected: R.image.selectedTabbarStar(),
                                                                       unselected: R.image.unselectedTabbarStar(),
                                                                       title: R.string.localizable.favourites())
        
        let extraStuffViewController = navigationController(controller: ExtraStuffListViewController(),
                                                            selected: R.image.selectedTabbarInfo(),
                                                            unselected: R.image.unselectedTabbarInfo(),
                                                            title: R.string.localizable.extra())
        
        viewControllers = [sourceListViewController, favouriteArticlesListViewController, extraStuffViewController]
    }
    
    func navigationController(controller: UIViewController,
                              selected: UIImage?,
                              unselected: UIImage?,
                              title: String) -> UINavigationController {
        let navigationController = CustomNavigationViewController(rootViewController: controller)
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.image = unselected
        navigationController.tabBarItem.selectedImage = selected
        navigationController.tabBarItem.title = title
        
        return navigationController
    }
}
