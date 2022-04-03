import { mount } from "@vue/test-utils"
import StageCandidate from "StageCandidate"
import Vuetify from "vuetify"
import Vuex from "vuex"

describe("searchCustomers", () => {
  // 入力が合った場合はstore/gettersのテストとする
  it("未入力の場合は全ての顧客を取得すること", () => {
    const localThis = {
      customers: [
        { name: "テスト タロウ" },
        { name: "テスト ジロウ" }
      ],
      keyword: ""
    }

    expect(StageCandidate.computed.searchCustomers.call(localThis)).toEqual(
      [
        { name: "テスト タロウ" },
        { name: "テスト ジロウ" }
      ]
    )
  });
});

jest.mock("axios", () => ({
  post: jest.fn(() => Promise.resolve(
    {
      data: {
        id: 1,
        name: "テスト タロウ"
      }
    }
  ))
}));

describe("createTicket", () => {
  let mutations
  let store
  let wrapper

  beforeEach(() => {
    mutations = {
      addTicket: jest.fn(),
      deleteCustomer: jest.fn()
    }
    store = new Vuex.Store({
      state: {
        id: 1,
        schedules: [],
        tickets: [],
        candidates: [{ id: 1, name: "テスト タロウ" }]
      },
      mutations,
    })

    wrapper = mount(StageCandidate, {
      vuetify: new Vuetify(),
      store
    });
  })

  it("予約ボタンをクリックするとaddTicketが呼ばれること", async () => {
    wrapper.find("#input-8").setValue(1)
    wrapper.find("#input-13").setValue(1)

    expect(wrapper.vm.scheduleIds).toEqual({ schedule_1: "1" })
    expect(wrapper.vm.ticketsCount).toEqual({ count_1: "1" })

    expect(store.state.tickets).toEqual([])
    expect(store.state.candidates).toEqual([{ id: 1, name: "テスト タロウ" }])

    wrapper.find(".reserved-btn_content").trigger("click")
    await wrapper.vm.$nextTick()

    expect(mutations.addTicket).toBeCalled();
  })
})
