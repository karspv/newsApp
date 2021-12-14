//
//  ExtraStuffListViewController.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-27.
//

import UIKit

enum SectionType: Int, CaseIterable {
    case map
    case webPage
    case imagePicker
}

class ExtraStuffListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Declarations
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = R.string.localizable.extraStuff()
        tableView.registerCellNib(withType: ExtraStuffTableViewCell.self)
        tableView.removeEmptyCellSeparators()
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard SectionType(rawValue: section) != nil else {
            print("ERROR! unexpected section: \(section)")
            return 0
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SectionType(rawValue: indexPath.section) else {
            print("ERROR! Unexpected sectionType type at: \(indexPath)")
            return UITableViewCell()
        }
        
        switch sectionType {
        case .map:
            return mapViewCellFor(tableView: tableView)
        case .webPage:
            return webPageCellFor(tableView: tableView)
        case .imagePicker:
            return imagePickerCellFor(tableView: tableView)
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionType = SectionType(rawValue: indexPath.section) else {
            print("ERROR! Unexpected sectionType type at: \(indexPath)")
            return
        }
        
        switch sectionType {
        case .map:
            navigateTo(controller: MapViewController())
        case .webPage:
            navigateTo(controller: WebPageViewController())
        case .imagePicker:
            navigateTo(controller: ImagePickerViewController())
        }
    }
    
    // MARK: - Cells
    func mapViewCellFor(tableView: UITableView) -> UITableViewCell {
        guard let cell: ExtraStuffTableViewCell = tableView.dequeueReusableCell(withType: ExtraStuffTableViewCell.self) else {
            print("ERROR! Could not get MapTableViewCell")
            return UITableViewCell()
        }
        
        cell.populateWith(title: R.string.localizable.reallyExtraMapViewCell())
        return cell
    }
    
    func webPageCellFor(tableView: UITableView) -> UITableViewCell {
        guard let cell: ExtraStuffTableViewCell = tableView.dequeueReusableCell(withType: ExtraStuffTableViewCell.self) else {
            print("ERROR! Could not get WebPageTableViewCell")
            return UITableViewCell()
        }
        
        cell.populateWith(title: R.string.localizable.reallyExtraWebPageCell())
        return cell
    }
    
    func imagePickerCellFor(tableView: UITableView) -> UITableViewCell {
        guard let cell: ExtraStuffTableViewCell = tableView.dequeueReusableCell(withType: ExtraStuffTableViewCell.self) else {
            print("ERROR! Could not get ImagePickerTableViewCell")
            return UITableViewCell()
        }
        
        cell.populateWith(title: R.string.localizable.reallyExtraImagePickerCell())
        return cell
    }
    
    // MARK: - Navigation
    func navigateTo(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}
