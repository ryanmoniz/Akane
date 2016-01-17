//
// This file is part of Akane
//
// Created by JC on 17/01/16.
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code
//

import Foundation

class TableViewSectionDelegate<TableViewType : UITableView where
    TableViewType : ComponentTableView,
    TableViewType.DataSourceType.DataType == TableViewType.ViewModelType.CollectionDataType,
    TableViewType.DataSourceType.ItemIdentifier.RawValue == String,
    TableViewType.DataSourceType : TableSectionDataSource,
    TableViewType.ViewModelType : CollectionSectionViewModel,
    TableViewType.DataSourceType.SectionIdentifier.RawValue == String> : TableViewDelegate<TableViewType>
{

    override init(tableView: TableViewType, collectionViewModel: CollectionViewModelType) {
        super.init(tableView: tableView, collectionViewModel: collectionViewModel)
    }

    @objc
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.viewForSection(section, sectionKind: "footer")
    }

    @objc
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewForSection(section, sectionKind: "header")
    }

    @objc
    func viewForSection(section: Int, sectionKind: String) -> UIView? {
        let data = self.dataSource.sectionItemAtIndex(section)
        let sectionType = CollectionRowType.Section(identifier: data.identifier.rawValue, kind: sectionKind)

        guard let template = self.dataSource.tableViewSectionTemplate(data.identifier) else {
            return nil
        }

        if (self.templateHolder[sectionType] == nil) {
            self.tableView.register(template, type: sectionType)
        }

        let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier(data.identifier.rawValue)!

        if let item = data.item {
            let viewModel = self.collectionViewModel.viewModelForSection(item as! CollectionViewModelType.SectionType)

            self.observer?.observe(viewModel).bindTo(view, template: template)
        }
        
        return view
    }
}