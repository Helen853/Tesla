//
//  Model.swift
//  Tesla

import Foundation

/// Ячейка для таббара
struct TabItem: Identifiable, Equatable {
    /// Идентификатор
    var id = UUID()
    /// Наименование картинки
    var icount: String
}
