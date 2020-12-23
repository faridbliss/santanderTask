//
//  HomeDetailView.swift
//  SantanderTask
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation
import UIKit
import Base
import UIComponents
import Resources
import API

class HomeDetailView: BaseView {
    private let scrollView = configure( UIScrollView()) {
        $0.isUserInteractionEnabled = true
        $0.isScrollEnabled = true
    }
    private let lblName = UIFactory.label()
    private let imageView = configure(UIImageView()) {
        $0.contentMode = .scaleAspectFill
    }
   private var lbl1 = UIFactory.label()
   private var lbl2 = UIFactory.label()
   private var lbl3 = UIFactory.label()
   private var lbl4 = UIFactory.label()
   private var lbl5 = UIFactory.label()
   private var lbl6 = UIFactory.label()
   private var lbl7 = UIFactory.label()
   private var lbl8 = UIFactory.label()
   private var lbl9 = UIFactory.label()
    private let stackView = configure(UIStackView()) {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 20
        $0.isUserInteractionEnabled = true
    }
    override func setupSubviews() {
        super.setupSubviews()
    }
    override func addSubviews() {
        super.addSubviews()
        addSubview(lblName)
        addSubview(imageView)
        stackView.addArrangedSubview(lbl1)
        stackView.addArrangedSubview(lbl2)
        stackView.addArrangedSubview(lbl3)
        stackView.addArrangedSubview(lbl4)
        stackView.addArrangedSubview(lbl5)
        stackView.addArrangedSubview(lbl6)
        stackView.addArrangedSubview(lbl7)
        stackView.addArrangedSubview(lbl8)
        stackView.addArrangedSubview(lbl9)
        scrollView.addSubview(stackView)
        addSubview(scrollView)
    }
    override func setupAutoLayout() {
        super.setupAutoLayout()
        lblName.snp.makeConstraints {make in
            make.top.equalTo(self).offset(100)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
        }
        imageView.snp.makeConstraints {make in
            make.top.equalTo(lblName.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.trailing.leading.bottom.equalToSuperview()
        }
        stackView.snp.makeConstraints {make in
            make.trailing.leading.top.bottom.equalTo(scrollView)
        }
        lbl1.snp.makeConstraints {make in
            make.height.equalTo(40)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
        }

    }
    func configureView(text: String, number: String) {

        imageView.image(with: R.string.base.pokemonImageUrl(Int(number)!),
                        shouldHideOnError: false,
                        placeHolderImage: UIColor.gray.image())
        lblName.text = text
    }
    
    func configureDetail(data: HomeDetailResponse) {
        lbl1.text = "Abilities:  \(data.abilities?.first?.ability.name ?? "")"
        lbl2.text = "Height:  \(data.height ?? 0)"
        lbl3.text = "Order:  \(data.order ?? 0)"
        lbl4.text = "Form:  \(data.forms?.first?.name ?? "")"
        lbl5.text = "Move:  \(data.moves?.first?.move.name ?? "")"
        lbl6.text = "Species:  \(data.species?.name ?? "")"
        lbl7.text = "Weight:  \(data.weight ?? 0)"
        lbl8.text = "Type:  \(data.types?.first?.type.name ?? "")"
        lbl9.text = "Stat:  \(data.stats?.first?.stat.name ?? "")"
    }
}
