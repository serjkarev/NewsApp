//
//  CountriesViewModel.swift
//  NewsApp
//
//  Created by skarev on 16.04.2021.
//

import RxSwift

protocol CountriesViewModelProtocol: class {
    func fetchCountries() -> Observable<[String?]>
}

final class CountriesViewModel: CountriesViewModelProtocol {
    private let countries: Observable<[Country]> = Observable.of([.ae, .ar, .at, .au, .be, .bg, .br, .ca, .ch,
                                                               .cn, .co, .cu, .cz, .de, .eg, .fr, .gb, .gr,
                                                               .hk, .hu, .id, .ie, .il, .`in`, .it, .jp, .kr,
                                                               .lt, .lv, .ma, .mx, .my, .ng, .nl, .no, .nz,
                                                               .ph, .pl, .pt, .ro, .rs, .ru, .sa, .se, .sg,
                                                               .si, .sk, .th, .tr, .tw, .ua, .us, .ve, .za])
    func fetchCountries() -> Observable<[String?]> {
        countries.map { $0.map { (Locale.current.localizedString(forRegionCode: $0.rawValue) ) } }
    }
}
