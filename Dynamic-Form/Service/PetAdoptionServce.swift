import Foundation

class PetAdoptionService {

    func getPetAdoptionModel(delegate: PetAdoptionDelegate) {
        guard let path = Bundle.main.path(forResource: "pet_adoption", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)

        do {

            let data = try Data(contentsOf: url)
            let petModel = try JSONDecoder().decode(PetAdoptionModel.self, from: data)
            delegate.onGetPetModel(response: petModel)

        } catch {
            print(error.localizedDescription)
            delegate.onFailure(error.localizedDescription)
            return
        }

    }
}

protocol PetAdoptionDelegate {
    func onGetPetModel(response: PetAdoptionModel)
    func onFailure(_ error: String)
}
