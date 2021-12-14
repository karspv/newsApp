//
//  ArticleDetailsViewControllerWithTableView+TableView.swift
//  NewsAppKarSpv
//
//  Created by Admin on 2021-03-24.
//

import Foundation
import UIKit

private enum SectionType: Int, CaseIterable {
    
    case publishDate
    case title
    case image
    case description
    case content
    case button
}

// MARK: - Also, instead of numberOfSections we can create/use cellList and append needed values.
extension ArticleDetailsViewControllerWithTableView {
    
    func registerTableViewCells() {
        tableView.registerCellNib(withType: ArticleDetailsDateTableViewCell.self)
        tableView.registerCellNib(withType: ArticleDetailsTitleTableViewCell.self)
        tableView.registerCellNib(withType: ArticleDetailsImageTableViewCell.self)
        tableView.registerCellNib(withType: ArticleDetailsDescriptionTableViewCell.self)
        tableView.registerCellNib(withType: ArticleDetailsContentTableViewCell.self)
        tableView.registerCellNib(withType: ArticleDetailsButtonTableViewCell.self)
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else {
            print("ERROR! unexpected section: \(section)")
            return 0
        }
        
        switch sectionType {
        
        case .publishDate,
             .title:
            return 1
            
        case .image:
            return hasImage() ? 1 : 0
            
        case .description,
             .content,
             .button:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let sectionType = SectionType(rawValue: indexPath.section) else {
            print("ERROR! Unexpected sectionType type at: \(indexPath)")
            return UITableViewCell()
        }
        
        switch sectionType {
        
        case .publishDate:
            return dateTableViewCellFor(tableView: tableView, article: dataModel.article)
            
        case .title:
            
            return titleTableViewCellFor(tableView: tableView, article: dataModel.article)
        case .image:
            
            return imageTableViewCellFor(tableView: tableView, article: dataModel.article)
        case .description:
            
            return descriptionTableViewCellFor(tableView: tableView, article: dataModel.article)
        case .content:
            
            return contentTableViewCellFor(tableView: tableView, article: dataModel.article)
        case .button:
            
            return buttonTableViewCellFor(tableView: tableView, article: dataModel.article)
        }
    }
    
    // MARK: - Cells
    func dateTableViewCellFor(tableView: UITableView, article: ArticleEntity) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withType: ArticleDetailsDateTableViewCell.self) else {
            print("ERROR! Could not get ArticleDetailsDateTableViewCell")
            return UITableViewCell()
        }
        cell.populateWith(article: article)
        return cell
    }
    
    func titleTableViewCellFor(tableView: UITableView, article: ArticleEntity) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withType: ArticleDetailsTitleTableViewCell.self) else {
            print("ERROR! Could not get ArticleDetailsTitleTableViewCell")
            return UITableViewCell()
        }
        cell.populateWith(article: dataModel.article)
        return cell
    }
    
    func imageTableViewCellFor(tableView: UITableView, article: ArticleEntity) -> UITableViewCell {
        guard dataModel.article.urlToImage != nil else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withType: ArticleDetailsImageTableViewCell.self) else {
            print("ERROR! Could not get ArticleDetailsImageTableViewCell")
            return UITableViewCell()
        }
        
        cell.populateWith(article: dataModel.article)
        return cell
    }
    
    func descriptionTableViewCellFor(tableView: UITableView, article: ArticleEntity) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withType: ArticleDetailsDescriptionTableViewCell.self) else {
            print("ERROR! Could not get ArticleDetailsDescriptionTableViewCell")
            return UITableViewCell()
        }
        cell.populateWith(article: dataModel.article)
        return cell
    }
    
    func contentTableViewCellFor(tableView: UITableView, article: ArticleEntity) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withType: ArticleDetailsContentTableViewCell.self) else {
            print("ERROR! Could not get ArticleDetailsContentTableViewCell")
            return UITableViewCell()
        }
        cell.populateWith(article: dataModel.article)
        return cell
    }
    
    func buttonTableViewCellFor(tableView: UITableView, article: ArticleEntity) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withType: ArticleDetailsButtonTableViewCell.self) else {
            print("ERROR! Could not get ArticleDetailsButtonTableViewCell")
            return UITableViewCell()
        }
        cell.didTapLearnMoreButtonCompletion = {
            self.openArticleInBrowser()
        }
        return cell
    }
    
    // MARK: - Helpers
    func hasImage() -> Bool {
        // return urlToImage != nil ----> Used in Entity class
        return dataModel.article.urlToArticle != nil
    }
}
