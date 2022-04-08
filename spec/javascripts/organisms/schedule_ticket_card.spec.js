describe("reserveTicket", () => {
  it.todo('pending');
})

// jest.mock("axios", () => ({
//   post: jest.fn(() => Promise.resolve(
//     {
//       data: {
//         id: 1,
//         name: "テスト タロウ"
//       }
//     }
//   ))
// }));

// describe("createTicket", () => {
//   let mutations
//   let store
//   let wrapper

//   beforeEach(() => {
//     mutations = {
//       addTicket: jest.fn(),
//       deleteCustomer: jest.fn()
//     }
//     store = new Vuex.Store({
//       state: {
//         id: 1,
//         schedules: [],
//         tickets: [],
//         candidates: [{ id: 1, name: "テスト タロウ" }]
//       },
//       mutations,
//     })

//     wrapper = mount(StageCandidate, {
//       vuetify: new Vuetify(),
//       store
//     });
//   })

//   it("予約ボタンをクリックするとaddTicketが呼ばれること", async () => {
//     wrapper.find("#input-8").setValue(1)
//     wrapper.find("#input-13").setValue(1)

//     expect(wrapper.vm.scheduleIds).toEqual({ schedule_1: "1" })
//     expect(wrapper.vm.ticketsCount).toEqual({ count_1: "1" })

//     expect(store.state.tickets).toEqual([])
//     expect(store.state.candidates).toEqual([{ id: 1, name: "テスト タロウ" }])

//     wrapper.find(".reserved-btn_content").trigger("click")
//     await wrapper.vm.$nextTick()

//     expect(mutations.addTicket).toBeCalled();
//   })
// })
