//
//  DiagnosticsChapter.swift
//  Diagnostics
//
//  Created by Antoine van der Lee on 10/12/2019.
//  Copyright © 2019 WeTransfer. All rights reserved.
//

import Foundation

/// Defines a Diagnostics Chapter which will end up in the report as HTML.
public struct DiagnosticsChapter {

    /// The title of the diagnostics report which will also be used as HTML anchor.
    public let title: String

    /// The `Diagnostics` to show in the chapter.
    public private(set) var diagnostics: Diagnostics

    /// Whether the title should be visibly shown.
    public let shouldShowTitle: Bool

    public init(title: String, diagnostics: Diagnostics, shouldShowTitle: Bool = true) {
        self.title = title
        self.diagnostics = diagnostics
        self.shouldShowTitle = shouldShowTitle
    }
}

public protocol DiagnosticsReportFilter {
    associatedtype DiagnosticsType: Diagnostics
    static func filter(_ diagnostics: DiagnosticsType) -> DiagnosticsType
}

extension DiagnosticsChapter {
    mutating func applyingFilters<T: DiagnosticsReportFilter>(_ filters: [T.Type]) {
        filters.forEach { reportFilter in
            guard let diagnostics = diagnostics as? T.DiagnosticsType else { return }
            self.diagnostics = reportFilter.filter(diagnostics)
        }
    }
}
