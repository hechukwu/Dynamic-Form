import Foundation

class PetAdoptionViewModel {

    var pet: PetAdoptionModel?
    var basicInfoElements: [Elements]?

    func fetchPetModel(delegate: PetAdoptionDelegate) {
        let service = PetAdoptionService()
        service.getPetAdoptionModel(delegate: delegate)
    }

    func updateBasicInfoElements(response: PetAdoptionModel) {
        basicInfoElements = response.pages?[0].sections?[1].elements
    }
}
