describe("updateStatus", () => {
  it.todo('pending');
})

// // describeの前に設定する必要がある
// jest.mock("axios", () => ({
//   patch: jest.fn(() => Promise.resolve({ data: "applied" }))
// }))

// describe("updateStatus", () => {
//   let store
//   let wrapper
//   let mutations

//   beforeEach(() => {
//     mutations = { updateStatus: jest.fn() }

//     store = new Vuex.Store({
//       state: { tickets: [
//         {
//           contact_id: 1,
//           customer_name: "テスト タロウ",
//           status: "reserved",
//         }
//       ] },
//       mutations,
//     })

//     wrapper = shallowMount(StageTicket, { store })
//   });

//   it("ステータスをクリックするとupdateStatusが呼ばれること", async () => {
//     await wrapper.find(".status-btn").trigger("click")
//     expect(mutations.updateStatus).toBeCalled();
//   })
// });
