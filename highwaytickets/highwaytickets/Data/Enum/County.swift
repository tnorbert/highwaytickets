//
//  County.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import Foundation

enum County: String, CaseIterable, Identifiable {
    
    case bacskiskun
    case budapest
    case pest
    case baranya
    case bekes
    case borsodabaujzemplen
    case csongradcsanad
    case fejer
    case gyormosonsopron
    case hajdubihar
    case heves
    case jasznagykunszolnok
    case komaromesztergom
    case nograd
    case somogy
    case szabolcsszatmarbereg
    case tolna
    case vas
    case veszprem
    case zala
    
    var id: String {
        return self.rawValue
    }
    
    var imageName: String {
        return self.rawValue
    }
    
    var selectedImageName: String {
        return self.rawValue + "_selected"
    }
    
    var localizedName: String {
        return "county.\(self.rawValue).name".localized()
    }
    
    var neighbours: [County] {
        switch self {
        case .bacskiskun:
            return [.baranya, .tolna, .fejer, .pest, .jasznagykunszolnok, .csongradcsanad]
        case .budapest:
            return [.pest]
        case .pest:
            return [.budapest, .komaromesztergom, .nograd, .heves, .jasznagykunszolnok, .bacskiskun, .fejer]
        case .baranya:
            return [.somogy, .tolna, .bacskiskun]
        case .bekes:
            return [.csongradcsanad, .jasznagykunszolnok, .hajdubihar]
        case .borsodabaujzemplen:
            return [.nograd, .szabolcsszatmarbereg, .hajdubihar, .jasznagykunszolnok, .heves]
        case .csongradcsanad:
            return [.bacskiskun, .jasznagykunszolnok, .bekes]
        case .fejer:
            return [.komaromesztergom, .pest, .bacskiskun, .tolna, .somogy, .veszprem]
        case .gyormosonsopron:
            return [.vas, .veszprem, .komaromesztergom]
        case .hajdubihar:
            return [.borsodabaujzemplen, .szabolcsszatmarbereg, .bekes, .jasznagykunszolnok, .heves]
        case .heves:
            return [.nograd, .borsodabaujzemplen, .jasznagykunszolnok, .pest]
        case .jasznagykunszolnok:
            return [.pest, .heves, .borsodabaujzemplen, .hajdubihar, .bekes, .csongradcsanad, .bacskiskun]
        case .komaromesztergom:
            return [.gyormosonsopron, .veszprem, .fejer, .pest]
        case .nograd:
            return [.pest, .heves, .borsodabaujzemplen]
        case .somogy:
            return [.zala, .veszprem, .fejer, .tolna, .baranya]
        case .szabolcsszatmarbereg:
            return [.borsodabaujzemplen, .hajdubihar]
        case .tolna:
            return [.somogy, .fejer, .bacskiskun, .baranya]
        case .vas:
            return [.zala, .veszprem, .gyormosonsopron]
        case .veszprem:
            return [.vas, .gyormosonsopron, .komaromesztergom, .fejer, .somogy, .zala]
        case .zala:
            return [.vas, .veszprem, .somogy]
        }
    }
    
}
