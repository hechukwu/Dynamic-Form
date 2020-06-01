import XCTest
@testable import Dynamic_Form

class PetAdptionServiceMock: PetAdoptionService {
    private let petArray: PetAdoptionModel
    var sucess: Bool?

    init(petArray: PetAdoptionModel) {
        self.petArray = petArray
    }

    override func getPetAdoptionModel(delegate: PetAdoptionDelegate) {
        guard let sucess = sucess else {
            return
        }
        if sucess {
            delegate.onGetPetModel(response: petArray)
        } else {
            delegate.onFailure("")
        }
    }
}

class PetAdoptionViewModelMock: PetAdoptionViewModel {

    let petArray = PetAdoptionModel(id: "test_form", name: "Pet Adoption Application Test Form", pages: nil)

    override func fetchPetModel(delegate: PetAdoptionDelegate) {
        let service = PetAdptionServiceMock(petArray: petArray)
        service.sucess = true
        service.getPetAdoptionModel(delegate: delegate)
    }
}

class Dynamic_FormTests: XCTestCase {

    let vmTest = PetAdoptionViewModelMock()
    let vc = BasicInfoViewController()

    override func setUp() {
        super.setUp()
        _ = vc.view
        vc.viewModel = vmTest
    }

    override func tearDown() {
        vc.viewModel = nil
        super.tearDown()
    }

    func testShouldCallUpdateElementsFunc() {
        //when
        vmTest.fetchPetModel(delegate: vc)

        //verify
        XCTAssertNotNil(vmTest.pet)
        XCTAssertNil(vmTest.pet?.pages)
        XCTAssertNil(vmTest.aboutHomeElements)
        XCTAssertNil(vmTest.basicInfoElements)
        XCTAssertNil(vmTest.additionalInfoElements)
    }

    func textShouldVerifyPetValues() {
        //when
        vmTest.fetchPetModel(delegate: vc)

        XCTAssert(vmTest.pet?.id == "test_form")
        XCTAssert(vmTest.pet?.name == "Pet Adoption Application Test Form")
        XCTAssert(vc.title == "Pet Adoption Application Test Form")
    }

}
