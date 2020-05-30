import Foundation

class PetAdoptionViewModel {

    var pet: PetAdoptionModel?
    var basicInfoElements: [Elements]?
    var aboutHomeElements: [Elements]?

    func fetchPetModel(delegate: PetAdoptionDelegate) {
        let service = PetAdoptionService()
        service.getPetAdoptionModel(delegate: delegate)
    }

    func updateElements(response: PetAdoptionModel) {
        basicInfoElements = response.pages?[0].sections?[1].elements
        aboutHomeElements = response.pages?[1].sections?[0].elements
    }
}
