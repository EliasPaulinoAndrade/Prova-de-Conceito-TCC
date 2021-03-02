//
//  EventDetailViewController.swift
//  TCCPoc
//
//  Created by Elias Paulino on 15/02/21.
//

import UIKit
import SnapKit

class EventDetailViewController: UIViewController {
    private let loadingView = UIActivityIndicatorView().set {
        $0.hidesWhenStopped = true
        $0.isHidden = true
        $0.backgroundColor = .white
    }
    private let titleLabel = UILabel().set {
        $0.textAlignment = .center
    }
    
    private lazy var card1 = EventDetailCardView(title: "Descrição do Evento", description: "O CocoaHeads Fortaleza está chegando!!! Uma oportunidade para conhecer a comunidade de desenvolvedores, aprender e ensinar sobre o ecossistema iOS e outros temas relacionados. Você não pode perder!", link: "Ver toda descrição ", onOpenLinkCompletion: showLinkAlert)
    
    private lazy var card2 = EventDetailCardView(title: "Sobre o Organizador", description: "O CocoaHeads é organizado por desenvolvedores da comunidade iOS de Fortaleza /CE.", link: "Saiba mais sobre o organizador", onOpenLinkCompletion: showLinkAlert)
    
    private lazy var card3 = EventDetailCardView(title: "Evento online via Zoom", description: "Este evento acontecerá via Zoom. O organizador enviará as informações de acesso próximo ao início do evento", link: "Saiba como acessar eventos online", onOpenLinkCompletion: showLinkAlert)
    
    private lazy var card4 = EventDetailCardView(title: "Politicas do Evento", description: "Lembre-se: Você pode editar o participante de um ingresso apenas uma vez. Essa opção é disponibilizada até 24 horas antes do evento.", link: "Saiba como editar participantes", onOpenLinkCompletion: showLinkAlert)
    
    private lazy var cardsStackView = UIStackView(card1, card2, card3, card4).set {
        $0.spacing = 10
        $0.axis = .vertical
    }
    private let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadingView.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            self.loadingView.stopAnimating()
            self.titleLabel.text = "Event Detail"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIAccessibility.post(notification: .layoutChanged, argument: navigationController?.navigationBar)
    }
    
    private func showLinkAlert() {
        navigationController?.view.presentCustomAlert(
            title: "Área em desenvolvimento",
            description: "Desculpe o transtorno. Melhorias estão sendo feitas para garantir uma experiência ainda melhor. Em breve essa área estará disponível.",
            actionTitle: "OK"
        )
    }
}

extension EventDetailViewController: ViewCodable {
    func buildHierarchy() {
        view.addSubviews(scrollView, loadingView)
        scrollView.addSubview(cardsStackView)
    }
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        cardsStackView.snp.makeConstraints {
            $0.top.bottom.centerX.width.equalToSuperview()
        }
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    func applyAddtionalChanges() {
        view.backgroundColor = UIColor(named: "mockBeige")
        title = "Detalhes do Evento"
    }
}
